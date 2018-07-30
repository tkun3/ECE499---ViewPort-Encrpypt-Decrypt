% Script which extracts video frames from a specified video then encrypts
% them to be stitched back together as a video
% ECE 499
% Written by: James Wong

clear;
close all;

% Get desired video path
% v = 'VideoFileName.type';
% Test videos: rhinos.avi, traffic.avi, xylophone.mp4
vObject = 'NOTLDMP4.mp4'; %Video File name
folder = fileparts(which(vObject));
fullPath = fullfile(folder, vObject);

% Create video object
vObject = VideoReader(fullPath);
vDuration = vObject.Duration; %seconds
vFrameRate = vObject.FrameRate; %frames per second
vHeight = vObject.Height; %pixels
vWidth = vObject.Width; %pixels

% Create directory to save to
currFolder = pwd;
outputFolder = sprintf('%s/VideoFrames', currFolder);
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end %if

% Specify image type: .jpg, .png
type = '.jpg';

% Delete contents of folder to avoid clutter
% Comment/Uncomment as necessary
filePattern = fullfile(outputFolder, '*.jpg'); %types: jpg, png
fileList = dir(filePattern);
if ~(cellfun(@isempty, {outputFolder}))
    for iDel = 1:length(fileList)
        delFileName = fullfile(outputFolder, fileList(iDel).name);
        delete(delFileName);
    end %for
end %if

%% Get a random number of frames throughout the video
% % Get random frames from video
% % Number of frames to be extracted from video
% numFrames = vObject.NumberOfFrames;
% f = 10;
% rand('state', 7); %randomized state
% randFrames = randperm(numFrames, f);
% randFrames = sort(randFrames);
% 
% % Extract frames from video
% %tic
% for iFrame = 1:f
%     frameInd = randFrames(iFrame);
%     frame = read(vObject, frameInd);
%     outputFileName = sprintf('Frame %d.jpg', frameInd); %types: jpg, png
%     imwrite(frame, fullfile(outputFolder, outputFileName));
% end
% %toc

%% Get a sequence of frames within specified period
vObject.CurrentTime = 30; %time to start
%tEnd = vDuration; %time to end
tEnd = vObject.CurrentTime + 20; % collect 2 minutes of frames specified start
%tic
while vObject.CurrentTime < tEnd
    thisFrame.cdata = readFrame(vObject);
    outputFileName = sprintf('Frame Time %0.2f%s', vObject.CurrentTime, type); %types: jpg, png
    imwrite(thisFrame.cdata, fullfile(outputFolder, outputFileName));
end %while
%toc

%% Encrypt the extracted frames
% GridDisplacerV2.m
% Written by Takuma Pimlott

% Load frames to be encrypted
frameFolder = outputFolder;
frameWildcard = sprintf('*%s', type);
frameBaseName = fullfile(frameFolder, frameWildcard);
frameList = dir(frameBaseName);
frameListLength = length(fileList);

% Create list of frame image names
encryptedNameList = cell(frameListLength,1);
for i = 1:frameListLength
    frameImageName = fullfile(frameFolder, fileList(i).name);
    encryptedNameList{i} = frameImageName;
end %for

% Create encrypted output folder
encOutputFolder = sprintf('%s/EncryptedFrames', currFolder);
if ~exist(encOutputFolder, 'dir')
    mkdir(encOutputFolder);
end %if

% Delete contents of encrypted frames folder
% Comment/Uncomment as necessary
filePattern = fullfile(encOutputFolder, '*.jpg'); %types: jpg, png
fileList = dir(filePattern);
if ~(cellfun(@isempty, {encOutputFolder}))
    for iDel = 1:length(fileList)
        delFileName = fullfile(encOutputFolder, fileList(iDel).name);
        delete(delFileName);
    end %for
end %if

% Encrypt images and place into folder
for j = 1:frameListLength
    inputImage = imread(encryptedNameList{j});
    encImage = gridDisplacer_func(inputImage);
    encOutputName = sprintf('Encrypted Frame %d.jpg', j);
    imwrite(encImage, fullfile(encOutputFolder, encOutputName));
end %for
%% Combine encrypted frames as a video
% Create directory to save new video to
currFolder = pwd;
outputFolder = sprintf('%s/EncryptedVid', currFolder);
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end %if

% Create VideoWriter object to write to
vidFileName = fullfile(outputFolder, 'NewVid.avi');
vidObj = VideoWriter(vidFileName); %name of video file
vidObj.FrameRate = vFrameRate;
open(vidObj);

% Delete previous

% Create array of encrypted frame names
encBaseFileName = fullfile(encOutputFolder, frameWildcard);
encryptedList = dir(encBaseFileName);
% Sort array in natural order (ascending)
encryptedListSorted = natsortfiles({encryptedList.name});
encryptedListSorted = transpose(encryptedListSorted);
encryptedListLength = length(encryptedList);

encryptedNameList = cell(encryptedListLength,1);
for i = 1:frameListLength
    encryptedImageName = fullfile(encOutputFolder, encryptedListSorted{i});
    encryptedNameList{i} = encryptedImageName;
end %for

% Preallocate array structure for frames to go into
% Create cell array ready for frames
allFrames = cell(encryptedListLength, 1);
allFrames(:) = {zeros(vHeight, vWidth, 3, 'uint8')};
% Create cell array with all colourmaps
allColorMaps = cell(encryptedListLength, 1);
allColorMaps(:) = {zeros(256, 3)};
% Combine to make array of structures
encryptedVid = struct('cdata', allFrames, 'colormap', allColorMaps);
% encImageName = encryptedNameList{1};
% thisFrame = imread(encImageName);
% asdf = im2frame(thisFrame);
% encryptedVid(1) = im2frame(thisFrame);
for k = 1:encryptedListLength
    encImageName = encryptedNameList{k};
    % Read encrypted image from disk
    thisFrame = imread(encImageName);
    % Convert image to movie frame
    encryptedVid(k) = im2frame(thisFrame);
    % Write frame to video file
    writeVideo(vidObj, thisFrame);
end %for

close(vidObj);

% axis off;
% title('Encrypted Video from Disk');
% movie(encryptedVid);