function [outThreshold] = threshold(inputImage)
%Function to identify the thresholding values to be used
%Purpose is to find what RGB level the percieved grid is 
%which may vary between screens and cameras

[rows columns depth] = size(inputImage);

R = 0;
G = 0;
B = 0;


%Left Top Corner
R = inputImage(2,2,1);
G = inputImage(2,2,2);
B = inputImage(2,2,3);

%LAB Testing
%Obtain Lab Samples from 4 Corners of Green Grid
lab_1 = rgb2lab(inputImage(2,2,:));
lab_2 = rgb2lab(inputImage(rows-2,2,:));
lab_3 = rgb2lab(inputImage(2,columns-2,:));
lab_4 = rgb2lab(inputImage(rows-2,columns-2,:));

lab_GridA = [lab_1(1,1,2) lab_2(1,1,2) lab_3(1,1,2) lab_4(1,1,2)];
lab_GridB = [lab_1(1,1,3) lab_2(1,1,3) lab_3(1,1,3) lab_4(1,1,3)];

%Calculate mean a* and b* value to use as Grid Color 'Markers'

color_marker = zeros([4, 2]);

AmeanVal = mean2(lab_GridA);
BmeanVal = mean2(lab_GridB);


%tValues = [R G B];

tValues = [AmeanVal BmeanVal];

outThreshold = tValues;


end

