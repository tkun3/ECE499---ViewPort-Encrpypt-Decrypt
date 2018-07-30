%Final Testing Script


t1=cputime;

%Image Reading
%image3 = imread('DecryptionTestImages/jay10by10.png');
%image3 = imread('TestPhotos/appleGrey8by8Crop.jpg');
%image3 = imread('TestPhotos/apple8by8.jpg');
%image3 = imread('TestPhotos/apple16by16.png');
%image3 = imread('TestPhotos/apple32by321.png');
%image3 = imread('TestPhotos/apple8by8enc2.jpg');
%image3 = imread('DecryptionTestImages/jay10by10.png');
image3 = imread('TestPhotos/j5by5Low.jpg');
%image3 = imread('TestPhotos/railroad27by27LOW.jpg');

x = 5;
y = 5;
variance = 8; %Default Variance ~= 10 to 15
bias = 2;

%Image Extraction
imageOut3 = extract_B(image3,x,y,variance,bias);
%Normalization
imageOut3 = normalization(imageOut3);
%Decryption
dImage = decrypt(imageOut3,x,y);
imwrite(dImage,'outputDecry/1D.png');
decryptTestTime=(cputime-t1);