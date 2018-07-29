%Final Testing Script

image3 = imread('TestPhotos/railroad27by27LOW.jpg');

x = 27;
y = 27;
variance = 15;

imageOut3 = extract_B(image3,x,y,variance);

imageOut3 = normalization(imageOut3);

%Decryption
dImage = decrypt(imageOut3,x,y);
imwrite(dImage,'outputDecry/1D.png');
decryptTestTime=(cputime-t1);