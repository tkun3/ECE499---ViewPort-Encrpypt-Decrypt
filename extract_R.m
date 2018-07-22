%Function Used to extract the data inside of the green grid in order to
%decode and process as necessary for the purpose of encryption / decryption
%Written by: Takuma Pimlott, James Wong
%CENG 499

function [outImage] = extract(inputImage, rowCount, colCount, outThreshold)

%Extract blocks from the grid
%1)Takes in parameters of the original input image
%2)rowCount is the number of horizontal pseudo pixels
%3)colCount is the number of vertical pseudo pixels

[rows columns depth] = size(inputImage);

%Find the thresholding values to use
%RGB Method
R = outThreshold(1);
G = outThreshold(2) - 6;
B = outThreshold(3);

%LAB COLOR METHOD
Aavg = outThreshold(1);
Bavg = outThreshold(2);


%Scan the image row by row pixels and recreate the cell contents in cells

z = 1;

%colIncrements = round(rows/(2*colCount));
%rowIncrements = round(columns/(2*rowCount));

rowIncrements = round(rows/(2*rowCount));
colIncrements = round(columns/(2*colCount));


tempOut = cell(1,0);

firstIncrement = round((rows/rowCount)/2.5);


rowFirst = 1;
colFirst = 1;

%Set the Z pixel size ie pseudo pixel z*z size
z = rows/(2*rowCount);
step = round(z*0.49);

AvgStepL = step;
AvgStepR = step;
AvgStepT = step;
AvgStepB = step;




%Find ranges for each pseudo pixel
for i = rowIncrements:(rowIncrements*2):rows
    
   for j = colIncrements:(colIncrements*2):columns

       %find horizontal bounds
       %find left bound
       

       
       dec = AvgStepL;
       AvgStepL = 0;
       X1 = i;
       while inputImage(i-dec,j,2) < G %&& inputImage(i-dec,j,1) > R && inputImage(i-dec,j,3) > B
           dec = dec + 1;
           X1 = i - dec;
           AvgStepL = AvgStepL + 1;
       end
       AvgStepL = AvgStepL + step - 1; 
       
       X1 = X1 + 1;

       %find right bound
       inc = AvgStepR;
       AvgStepR = 0;
       X2 = i;
       while inputImage(i+inc,j,2) < G %&& inputImage(i+inc,j,1) > R && inputImage(i+inc,j,3) > B
           inc = inc + 1;
           X2 = i + inc;
           AvgStepR = AvgStepR + 1;
       end
       AvgStepR = AvgStepR + step - 1;
       X2 = X2 - 1;
       
       %horizontal range will be from X1 to X2;



       %find vertical bounds
       %find top bound
       dec = AvgStepT;
       AvgStepT = 0;
       Y1 = j;
       while inputImage(i,j-dec,2) < G %&& inputImage(i,j-dec,1) > R && inputImage(i,j-dec,3) > B
           dec = dec + 1;
           Y1 = j - dec;
           AvgStepT = AvgStepT + 1;
       end
       AvgStepT = AvgStepT + step - 1;
       Y1 = Y1 + 1;

       %find bottom bound
       inc = AvgStepB;
       AvgStepB = 0;
       Y2 = j;
       while inputImage(i,j+inc,2) < G %&& inputImage(i,j+inc,1) > R && inputImage(i,j+inc,3) > B
           inc = inc + 1;
           Y2 = j + inc;
           AvgStepB = AvgStepB + 1;
       end
       AvgStepB = AvgStepB + step - 1;
       Y2 = Y2 - 1;
       
       r = inputImage(X1:X2, Y1:Y2,1);
       g = inputImage(X1:X2, Y1:Y2,2);
       b = inputImage(X1:X2, Y1:Y2,3);
       pseudoPixel = cat(3, r, g, b);
       tempOut{end+1} = pseudoPixel;
       
       
   end
end




%output image is equal to some kind of cell
outImage =  tempOut;

end

