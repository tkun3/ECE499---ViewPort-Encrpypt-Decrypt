function [outImage] = crop(inputImage)
%CROP function used as preprocessing step to remove all non-green
%pixels surrounding the image


[rows columns depth] = size(inputImage);


xmin = 0;
xmax = 0;
ymin = 0;
ymax = 0;

R = 120;
G = 220;
B = 120;


%find left x
for j = 1:columns - 1
    
    r = inputImage(round(rows/3.7),j,1);
    g = inputImage(round(rows/3.7),j,2);
    b = inputImage(round(rows/3.7),j,3);
    
    if(r <= R && g >= G && b <= B)
        xmin = j;
        break
    end
    
end


%find right x

for j = columns:-1:1
    
    r = inputImage(round(rows/2),j,1);
    g = inputImage(round(rows/2),j,2);
    b = inputImage(round(rows/2),j,3);
    
    if(r <= R && g >= G && b <= B)
        xmax = j;
        break
    end
    
end


%find top y

for i = 1:rows-1
    
    r = inputImage(i,round(columns/2),1);
    g = inputImage(i,round(columns/2),2);
    b = inputImage(i,round(columns/2),3);
    
    if(r <= R && g >= G && b <= B)
        ymin = i;
        break
    end
    
end


%find bottom y

for i = rows:-1:1
    
    r = inputImage(i,round(columns/2),1);
    g = inputImage(i,round(columns/2),2);
    b = inputImage(i,round(columns/2),3);
    
    if(r <= R && g >= G && b <= B)
        ymax = i;
        break
    end
    
end

%[xmin ymin width height]
rect = [xmin ymin xmax-xmin ymax-ymin]



outImage = imcrop(inputImage,rect);

%figure('Name','Input Image')
%imshow(inputImage);

%figure('Name','Output Image')
%imshow(outImage);



end

