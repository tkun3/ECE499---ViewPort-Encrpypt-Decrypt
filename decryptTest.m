
%Extract the information
%image3 = imread('DarkImages/bg16by6.png');
%imageOut3 = extract(image3,6,6);

image3 = imread('jgs/jgs1.png');
imageOut3 = extract(image3,6,6);

image3 = imread('jgs/jgs.png');
imageOut3 = extract(image3,10,10);

image3 = imread('DecryptionTestImages/jay10by10.png');
imageOut3 = extract(image3,10,10);

%image3 = imread('TestPhotos/6by6Cropped.jpg');
%imageOut3 = extract(image3,6,6);

%image3 = imread('DarkImages/bg16by6.png');
%imageOut3 = extract(image3,6,6);

figure('Name','Encrypted Image')
imshow(image3);

%figure
%imshow(imageOut3{15});

%for i = 1:length(imageOut3)
%    figure
%    imshow(imageOut3{i});
%end


%------------------- Add Normalizing step here ---------------
imageOut3 = normalization(imageOut3);

%Test Reconstructing the original Image
t1=cputime;
dImage = decrypt(imageOut3,10,10);
tend1=(cputime-t1)/10;

figure('Name','Decrypted Image')
imshow(dImage);