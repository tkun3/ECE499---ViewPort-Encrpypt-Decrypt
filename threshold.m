function [outThreshold] = threshold(inputImage)
%Function to identify the thresholding values to be used
%Purpose is to find what RGB level the percieved grid is 
%which may vary between screens and cameras

[rows columns depth] = size(inputImage);

outThreshold = inputImage;


end

