
%Extract the information
%image3 = imread('DarkImages/bg16by6.png');
%tThresStart=cputime;
%outThreshold = threshold(image3);
%tThresEnd=(cputime-tThresStart)/10;
%imageOut3 = extract(image3,6,6,outThreshold);

%Read Image-----------------------------
%image3 = imread('jgs/jgs1.png');
%Find Image Green Threshold Value
%outThreshold = threshold(image3);
%Extract Data
%imageOut3 = extract(image3,6,6,outThreshold);


%Read Image-----------------------------
%image3 = imread('jgs/jgs.png');
%Find Image Green Threshold Value
%outThreshold = threshold(image3);
%Extract Data
%imageOut3 = extract(image3,10,10);


%Read Image-----------------------------
%image3 = imread('DecryptionTestImages/jay10by10.png');
%Find Image Green Threshold Value
%outThreshold = threshold(image3);
%Extract Data
%imageOut3 = extract(image3,10,10,outThreshold);

%Read Image-----------------------------
image3 = imread('DecryptionTestImages/jay10by10.png');
%Find Image Green Threshold Value
outThreshold = threshold(image3);
%Extract Data
imageOut3 = extract(image3,10,10,outThreshold);

%Read Image-----------------------------
%image3 = imread('TestPhotos/j5by5.jpg');
%Find Image Green Threshold Value
%outThreshold = threshold(image3);
%Extract Data
%imageOut3 = extract(image3,5,5,outThreshold);


figure('Name','Encrypted Image')
imshow(image3);

%figure
%imshow(imageOut3{15});

%for i = 1:length(imageOut3)
%    figure
%    imshow(imageOut3{i});
%end


%Normalize Data-----------------------------
imageOut3 = normalization(imageOut3);

%Decrypt Image-----------------------------
t1=cputime;
dImage = decrypt(imageOut3,10,10);
tend1=(cputime-t1)/10;

figure('Name','Decrypted Image')
imshow(dImage);