function [outImage] = extract_B(inputImage, rowCount, colCount)

[rows cols depth] = size(inputImage);

rowIncrement = round(cols/colCount);
colIncrement = rowIncrement;

centerBoxIncrement = round(rows/(2*rowCount));

bias = 1;
step = 1;
variance = 15;

%Currently configured for cube images only
rowScan = cell(1,rowCount);
colScan = cell(1,colCount);


%Pre allocate array here
scannedRow = zeros(rowCount,colCount*2);
scannedCol = zeros(rowCount*2,colCount);


%First grid column (left and right)------------------------------


rowCounter = 1;

for i = centerBoxIncrement:(centerBoxIncrement*2):rows-10
       
       
       colCounter = 1;
    
       %First Left
       sample = double(inputImage(i,1,2));
       inc = 0;
       firstL = 1;
       while abs(double(inputImage(i,1+inc,2))-sample) < variance 
           %sample = inputImage(i,1+inc,2);
           inc = inc + 1;
           firstL = firstL + 1;
       end
       
       firstL = firstL + 1;
       
       %Last Right
       sample = double(inputImage(i,cols,2));
       dec = 0;
       lastR = cols;
       
       while abs(double(inputImage(i,cols-dec,2))-sample) < variance 
           %sample = inputImage(i,1+inc,2);
           dec = dec + 1;
           lastR = lastR - 1;
       end
       
       lastR = lastR - 1;
       
       scannedRow(rowCounter, colCounter) = firstL;
       colCounter = colCounter + 1;
       
       scannedRow(rowCounter, colCount*2) = lastR;

        for j = colIncrement:colIncrement:cols-10


           %find left bound
           sample = double(inputImage(i,j,2));
           dec = step;
           X1 = j;
           while abs(double(inputImage(i,j-dec,2))-sample) < variance 
               dec = dec + 1;
               X1 = X1 - dec;
           end

           X1 = X1 - 2;

           %find right bound
           inc = step;
           X2 = j;
           while abs(double(inputImage(i,j+inc,2)) - sample) < variance 
               inc = inc + 1;
               X2 = X2 + inc;
           end

           X2 = X2 + 2;

           scannedRow(rowCounter,colCounter) = X1;
           colCounter = colCounter + 1;
           scannedRow(rowCounter,colCounter) = X2;
           colCounter = colCounter + 1;
           
        end
    
        rowCounter = rowCounter + 1;
    
end

%Grid column (Top and Bottom)------------------------------

colCounter = 1;
for i = centerBoxIncrement:(centerBoxIncrement*2):rows-10
    
       rowCounter = 1;
    
       %First TOP
       sample = double(inputImage(1,i,2));
       inc = 0;
       firstL = 1;
       while abs(double(inputImage(1+inc,i,2))-sample) < variance 
           inc = inc + 1;
           firstL = firstL + 1;
       end
       
       firstL = firstL - 1;
      
       %Last BOTTOM
       sample = double(inputImage(rows,i,2));
       dec = 0;
       lastR = cols;
       while abs(double(inputImage(rows-dec,i,2))-sample) < variance 
           dec = dec + 1;
           lastR = lastR - 1;
       end
       
       lastR = lastR + 1;
       
       scannedCol(rowCounter,colCounter) = firstL;
       rowCounter = rowCounter + 1;
       
       scannedCol(rowCount*2,colCounter) = lastR;

        for j = rowIncrement:rowIncrement:rows-10


           %Find TOP bound
           sample = double(inputImage(j,i,2));
           dec = step;
           X1 = j;
           while abs(double(inputImage(j-dec,i,2))-sample) < variance 
               dec = dec + 1;
               X1 = X1 - dec;
           end

           X1 = X1 - 2;

           %Find BOTTOM bound
           inc = step;
           X2 = j;
           while abs(double(inputImage(j+inc,i,2)) - sample) < variance 
               inc = inc + 1;
               X2 = X2 + inc;
           end

           X2 = X2 + 2;

           scannedCol(rowCounter, colCounter) = X1;
           rowCounter = rowCounter + 1;
           scannedCol(rowCounter, colCounter) = X2;
           rowCounter = rowCounter + 1;
           
        end
        
        colCounter = colCounter + 1;
        
end

outCell = cell(1,(colCount*rowCount));
cellCount = 1;
%scannedCol = scannedCol';

for i = 0:1:rowCount -1
    
    for j = 0:1:colCount -1
        X1 = scannedRow((i+1),(j*2)+1);
        X2 = scannedRow((i+1),(j*2)+2);
        Y1 = scannedCol((i*2)+1,j+1);
        Y2 = scannedCol((i*2)+2,j+1);
        
       % Z = inputImage(Y1:Y2,X1:X2,:);
       % figure('name','Box1');
       % imshow(Z);
        outCell{1,cellCount} = inputImage(Y1:Y2,X1:X2,:);
        cellCount = cellCount + 1;
    end  
    
    
end

outImage = outCell;


end

