%Function Used to extract the data inside of the green grid in order to
%decode and process as necessary for the purpose of encryption / decryption
%Written by: Takuma Pimlott
%CENG 499

function [outImage] = extract(inputImage, rowCount, colCount)

%Extract blocks from the grid
%1)Takes in parameters of the original input image
%2)rowCount is the number of horizontal pseudo pixels
%3)colCount is the number of vertical pseudo pixels

[rows columns depth] = size(inputImage);

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


%Find ranges for each pseudo pixel
for i = rowIncrements:(rowIncrements*2):rows
    
   for j = colIncrements:(colIncrements*2):columns

       %find horizontal bounds
       %find left bound
       dec = 1;
       X1 = i;
       while inputImage(i-dec,j,2) < 254 %&& inputImage(i,j-firstIncrement,2) < 254 && inputImage(i,j+firstIncrement,2) < 254
           dec = dec + 1;
           X1 = i - dec;
       end

       %find right bound
       inc = 1;
       X2 = i;
       while inputImage(i+inc,j,2) < 254 %&& inputImage(i,j-firstIncrement,2) < 254 && inputImage(i,j+firstIncrement,2) < 254
           inc = inc + 1;
           X2 = i + inc;
       end
       
       %horizontal range will be from X1 to X2;



       %find vertical bounds
       %find top bound
       dec = 1;
       Y1 = j;
       while inputImage(i,j-dec,2) < 254 %&& inputImage(i-firstIncrement,j,2) < 254 && inputImage(i+firstIncrement,j,2) < 254
           dec = dec + 1;
           Y1 = j - dec;
       end

       %find bottom bound
       inc = 1;
       Y2 = j;
       while inputImage(i,j+inc,2) < 254 %&& inputImage(i-firstIncrement,j,2) < 254 && inputImage(i+firstIncrement,j,2) < 254
           inc = inc + 1;
           Y2 = j + inc;
       end
       
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

