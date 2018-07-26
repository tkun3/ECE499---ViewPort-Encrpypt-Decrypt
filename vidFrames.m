% Script to extract frames from a video and to save the individual frames
% for processing later on.
% ECE 499
% Written by: James Wong
close all;
clear;

% Get desired video path
% v = 'VideoFileName.type';
v = 'rhinos.avi'; %Video File name
folder = fileparts(which(v));
fullPath = fullfile(folder, v);

% Create video object
vObject = VideoReader(fullPath);
vDuration = vObject.Duration;
numFrames = vObject.NumberOfFrames;

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

% Get random frames from video
% Number of frames to be extracted from video
f = 10;
rand('state', 7); %randomized state
randFrames = randperm(numFrames, f);
randFrames = sort(randFrames);

% Extract frames from video
for iFrame = 1:f
    frameInd = randFrames(iFrame);
    frame = read(vObject, frameInd);
    outputFileName = sprintf('Frame %d.jpg', frameInd); %types: jpg, png
    imwrite(frame, fullfile(outputFolder, outputFileName));
end