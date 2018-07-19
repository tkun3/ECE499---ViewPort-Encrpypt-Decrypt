% Testing normalization functoin
% Written by: James Wong

img = imread('jayEnc.jpg');
extractImg = extract(img, 6, 6);
tic
normImg = normalization(extractImg);
toc
time = toc;
img1 = cell2mat(normImg);
figure('Name','Normalized Cell Image Size');
imshow(img1);