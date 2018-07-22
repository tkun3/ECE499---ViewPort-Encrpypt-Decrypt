
%{

I = imread('TestPhotos/j5by5Low.jpg');
I = rgb2gray(I);
I = imsharpen(I);
[~, threshold] = edge(I, 'sobel');
fudgeFactor = .5;
BWs = edge(I,'sobel', threshold * fudgeFactor);



figure, imshow(BWs), title('binary gradient mask');


A = imread('TestPhotos/j5by5.jpg');
B = imgaussfilt(A,2);
figure('Name','Smoothed image')
imshow(B);

I = imread('TestPhotos/j5by5Low.jpg');

Red = I(:,:,1);
Green = I(:,:,2);
Blue = I(:,:,3);
Get histValues for each channel
[yRed, x] = imhist(Red);
[yGreen, x] = imhist(Green);
[yBlue, x] = imhist(Blue);



plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');




%Filter all high frequency from image
%Sharpen an image to better define high frequency portions of image

t1 = cputime;
B = imread('TestPhotos/j5by5Low.jpg');
%B = imsharpen(I);


%B = imgaussfilt(B,0.1);
t1End = cputime - t1;
%}
%figure('Name','Smoothed image')
%imshow(B);




tEdge=cputime;
I = imread('TestPhotos/appleFS.jpg');
BW = im2bw(I);
imshow(BW);
dim = size(BW);
col = round(dim(2)/2)-90;
row = min(find(BW(:,col)));
boundary = bwtraceboundary(BW,[row, col],'N');
tEdgeEnd=(cputime-tEdge)
figure('Name','Border image');
imshow(I)
hold on;
plot(boundary(:,2),boundary(:,1),'g','LineWidth',3);
BW_filled = imfill(BW,'holes');
boundaries = bwboundaries(BW_filled);

for k=1:1
   b = boundaries{k};
   plot(b(:,2),b(:,1),'r','LineWidth',3);
end
