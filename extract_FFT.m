%Attempting to find maximum frequency changes in a pixel width of a row
%to find where the vertical green lines exist

%Test1.png has a total of 5 pseudo pixels
%N = 5, therefore a total of 6 edges must be found
fftTime=cputime;
image3 = imread('FFTTesting/test1.png');
image3 = rgb2gray(image3);
%figure('name','Grey Image');
%imshow(image3Grey);

[rows cols depth] = size(image3);
rowIncrement = round(rows/2);
colIncrement = round(cols/2);
rowRange = [rowIncrement - round(0.2*rowIncrement) rowIncrement + round(0.2*rowIncrement)];
colRange = [colIncrement - round(0.2*colIncrement) colIncrement + round(0.2*colIncrement)];


image3 = image3(rowRange(1):rowRange(2),:,:);
%image3 = image3(:,:,:);


%image3 = image3(round(rows/2),:,:);



%Testing with a greyscale version of the image
image3FFT = fft(image3);
image3FFT = abs(image3FFT);
image3FFT = log(image3FFT + 1);

%image3FFT = fftshift(image3FFT);
imshow(image3FFT,[]);



[Max, I] = maxk(abs(image3FFT),6);

fftEndTime = cputime - fftTime;