% Script to extract frames from a video and to save the individual frames
% for processing later on. Comment/Uncomment 'tic' and 'toc' for elapsed
% times.
% ECE 499
% Written by: James Wong
close all;
clear;

% Get desired video path
% v = 'VideoFileName.type';
vObject = 'rhinos.avi'; %Video File name
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
vObject.CurrentTime = 0; %time to start
tEnd = vDuration; %time to end
%tEnd = vObject.CurrentTime + 120; % collect 2 minutes of frames specified start
tic
while vObject.CurrentTime < tEnd
    thisFrame.cdata = readFrame(vObject);
    outputFileName = sprintf('Frame Time %0.2f.jpg', vObject.CurrentTime); %types: jpg, png
    imwrite(thisFrame.cdata, fullfile(outputFolder, outputFileName));
end %while
toc