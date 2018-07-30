function [outTime] = frameDecrypt(directory,x,y,variance,bias)

t1=cputime;
%imageRead
image1 = imread(directory);
%image2 = imread('-pastespecial');

%Image Extraction
imageOut = extract_B(image1,x,y,variance,bias);
%Normalization
imageOut = normalization(imageOut);
%Decryption
dImage = decrypt(imageOut,x,y);

outDirectory = 'prototype/output/1.jpg';

%outDirectory2 = 'prototype/output/2.jpg';

%count = strcat(count, '.jpg');
%outDirectory = strcat(outDirectory, count);

imwrite(dImage,outDirectory);
%imwrite(image2,outDirectory2);

outTime=(cputime-t1);

end

