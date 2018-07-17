%t1=cputime;
%image1 = imread('JayCropTest.jpg');

%crop(image1);

%tend1=(cputime-t1)/10; 

%t2=cputime;
%image1 = imread('croptest3.jpg');

%crop(image1);

%tend2=(cputime-t2)/10; 

%image1 = imread('croptest1.jpg');

%crop(image1);

%Extract Function Test
%image3 = imread('jay5by5.png');

image3 = imread('DarkImages/bg16by6.png');

imageOut3 = extract(image3,6,6);

    figure
    imshow(imageOut3{15});

%image4 = imread('blue9by16.png');

%imageOut4 = extract(image4,9,16);

for i = 1:length(imageOut3)
    figure
    imshow(imageOut3{i});
end


%------------------- Add Normalizing step here ---------------

%Test Reconstructing the original Image

dImage = decrypt(imageOut3,6,6);

figure
imshow(dImage);
