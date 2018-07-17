
%Extract the information
image3 = imread('DarkImages/bg16by6.png');
imageOut3 = extract(image3,6,6);

figure('Name','Encrypted Image')
imshow(image3);

%figure
%imshow(imageOut3{15});

%for i = 1:length(imageOut3)
%    figure
%    imshow(imageOut3{i});
%end


%------------------- Add Normalizing step here ---------------

%Test Reconstructing the original Image
t1=cputime;
dImage = decrypt(imageOut3,6,6);
tend1=(cputime-t1)/10;

figure('Name','Decrypted Image')
imshow(dImage);