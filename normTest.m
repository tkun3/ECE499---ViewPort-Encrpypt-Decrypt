% Testing normalization functoin
% Written by: James Wong

close all

%% Image
%img = imread('jayEnc.jpg');
% thresh = threshold(img);
% extractImg = extract(img, 6, 6, thresh);

% Test empty matrix
img = imread('TestPhotos/apple8by8.jpg');
thresh = threshold(img);
extractImg = extract(img, 8, 8, thresh);

%% Normalization
tic
normImg = normalization(extractImg);
toc
time = toc;

%% Show image
img1 = cell2mat(normImg);
figure('Name','Normalized Cell Image Size');
imshow(img1);