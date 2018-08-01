% Script which extracts video frames from a specified video then encrypts
% them to be stitched back together as a video
% ECE 499
% Written by: James Wong

clear;
close all;

% Get desired video path
% v = 'VideoFileName.type';
% Example: rhinos.avi, traffic.avi, xylophone.mp4
vObject = 'NOTLDMP4.mp4'; %Video File name
folder = fileparts(which(vObject));
fullPath = fullfile(folder, vObject);

% Create video object
vObject = VideoReader(fullPath);
vDuration = vObject.Duration; %seconds
vFrameRate = vObject.FrameRate; %frames per second
vHeight = vObject.Height; %pixels
vWidth = vObject.Width; %pixels

% Specify image type: .jpg, .png
type = '.jpg';
typeWildcard = sprintf('*%s',type);
% Specify video type: .avi, .mp4, .wmv
vType = '.avi';

% Specify time to start video at
tStart = 30;
% Specify length of time to extract
tDuration = 300;
% tDuration = vDuration;

% Create directory for frames to save to
currFolder = pwd;
frameOutputFolder = sprintf('%s/VideoFrames', currFolder);
if ~exist(frameOutputFolder, 'dir')
    mkdir(frameOutputFolder);
end %if

% Delete contents of folder to avoid clutter
% Comment/Uncomment as necessary
filePattern = fullfile(frameOutputFolder, typeWildcard); %types: jpg, png
fileList = dir(filePattern);
if ~(cellfun(@isempty, {frameOutputFolder}))
    for iDel = 1:length(fileList)
        delFileName = fullfile(frameOutputFolder, fileList(iDel).name);
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
vObject.CurrentTime = tStart; %time to start
%tEnd = vDuration; %time to end
tEnd = vObject.CurrentTime + tDuration; % collect 2 minutes of frames specified start
%tic
while vObject.CurrentTime < tEnd
    thisFrame.cdata = readFrame(vObject);
    outputFileName = sprintf('Frame Time %0.2f%s', vObject.CurrentTime, type); %types: jpg, png
    imwrite(thisFrame.cdata, fullfile(frameOutputFolder, outputFileName));
end %while
%toc

%% Encrypt the extracted frames
% GridDisplacerV2.m
% Written by Takuma Pimlott
% Script by James Wong

% Load frames to be encrypted
frameFolder = frameOutputFolder;
frameBaseName = fullfile(frameFolder, typeWildcard);
frameList = dir(frameBaseName);
% Sort array in natural order (ascending)
frameListSorted = natsortfiles({frameList.name});
frameListSorted = transpose(frameListSorted);
frameListLength = length(frameList);

% Create list of frame image names
encryptedNameList = cell(frameListLength,1);
for i = 1:frameListLength
    frameImageName = fullfile(frameFolder, frameList(i).name);
    encryptedNameList{i} = frameImageName;
end %for

% Create encrypted output folder
encOutputFolder = sprintf('%s/EncryptedFrames', currFolder);
if ~exist(encOutputFolder, 'dir')
    mkdir(encOutputFolder);
end %if

% Delete contents of encrypted frames folder
% Comment/Uncomment as necessary
filePattern = fullfile(encOutputFolder, typeWildcard); %types: jpg, png
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
    encOutputName = sprintf('Encrypted Frame %d%s', j, type);
    imwrite(encImage, fullfile(encOutputFolder, encOutputName));
end %for
%% Combine encrypted frames as a video
% Create directory to save new video to
currFolder = pwd;
vidOutputFolder = sprintf('%s/EncryptedVid', currFolder);
if ~exist(vidOutputFolder, 'dir')
    mkdir(vidOutputFolder);
end %if

% Create VideoWriter object to write to
vidName = sprintf('video%s', vType);
vidFileName = fullfile(vidOutputFolder, vidName);
vidObj = VideoWriter(vidFileName); %name of video file
vidObj.FrameRate = vFrameRate;
open(vidObj);

% Create array of encrypted frame names
encBaseFileName = fullfile(encOutputFolder, typeWildcard);
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
% Iterate through frames in folder and combine as a video
for k = 1:encryptedListLength
    encImageName = encryptedNameList{k};
    % Read encrypted image from disk
    thisFrame = imread(encImageName);
    % Convert image to movie frame
    encryptedVid(k) = im2frame(thisFrame);
    % Write frame to video file
    writeVideo(vidObj, thisFrame);
end %for

close(vidObj); %close video object

% axis off;
% title('Encrypted Video from Disk');
% movie(encryptedVid);