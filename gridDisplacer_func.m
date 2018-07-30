% Grid displacer function Version 2
% Used as a function for the video output
function [encImage] = gridDisplacer_func(inputImage)

%img = imread(inputImage);

% Block size (z * z cube)
% GCM for 1920*1080 is 120px, 40px was a nice grid
%z = 120;
%z = 100;
%z = 105;
% Night of the Living Dead (400x400)
% z = 80; % 5x5
% z = 40; % 10x10
% z = 20; % 20x20
z = 10; % 40x40

[rows columns depth] = size(inputImage);

%of horizontal cubes
x = rows / z;

%of vertical cubes
y = columns / z;

%Store image as blocks
blockR = cell(x,y);
blockG = cell(x,y);
blockB = cell(x,y);

%------Break image down into z*z blocks with x*y size matrix------

%grid Size
% pad = 10;
pad = 5;

%Pad each pseudoPixel of the image

counti = 0;
for i = 1:z:rows-1
   counti = counti + 1;
   countj = 0;
   for j = 1:z:columns-1
        countj = countj + 1;
 
        o = inputImage(i:i+z-1,j:j+z-1,1);
        blockR{counti,countj} = padarray(o,[pad pad],0,'both');
        
        o = inputImage(i:i+z-1,j:j+z-1,2);
        blockG{counti,countj} = padarray(o,[pad pad],255,'both');
        
        o = inputImage(i:i+z-1,j:j+z-1,3);
        blockB{counti,countj} = padarray(o,[pad pad],0,'both');
   end
     
end

%blockRGB99 = cat(3, blockR, blockG, blockB);
%outputConverted = cell2mat(blockRGB99);
%figure('Name','Original Image')
%imshow(outputConverted);

%----------------Encrpyt the image-----------------

blockRe = cell(x,y);
blockGe = cell(x,y);
blockBe = cell(x,y);

counti = 0;
i2 = 1;
j2 = 1;

%---------------create Index Hash based on # of blocks per row----------
xPreHash = zeros([1 x]);
yPreHash = zeros([1 y]);

for i = 1:1:x
    xPreHash(i) = i;
end

for i = 1:1:y
    yPreHash(i) = i;
end


[m1,n1] = size(xPreHash) ;
[m2,n2] = size(yPreHash) ;

rng(1);
idx = randperm(n1) ;
xHash = xPreHash;
xHash(1,idx) = xPreHash(1,:);

rng(1);
idy = randperm(n2) ;
yHash = yPreHash;
yHash(1,idy) = yPreHash(1,:);


for i = 1:1:x
   for j = 1:1:y
        blockRe{i,j} = blockR{xHash(i),yHash(j)};
        blockGe{i,j} = blockG{xHash(i),yHash(j)};
        blockBe{i,j} = blockB{xHash(i),yHash(j)};
   end
end

encryptedImagePre = cat(3, blockRe, blockGe, blockBe);
encryptedImagePost = cell2mat(encryptedImagePre);

encImage = encryptedImagePost;
%imwrite(encryptedImagePost,'output/1.png');
end

