%Function which normalizes the size of cells inside a cell array.
%Especially important after extracting the image since some cells may be of 
%differing size and prevent decryption. 
%Written by: James Wong, Takuma Pimlott
function [outIm] = normalization(inputImage)

% Get most common dimensions of cell contents
comX = mode(cellfun('size', inputImage,1));
comY = mode(cellfun('size', inputImage,2));

%reshImg = reshape(inputImage, [x, y]);
[~, y, ~] = size(inputImage);

normCell = cell(1,y);

for i=1:1:y
    cellImg = cell2mat(inputImage(i));
    if isempty(cellImg)
        cellImg = zeros(comX, comY, 3);
    end
    [m, n, ~] = size(cellImg);
    if(m ~= comX)
        if(m > comX)
            cellImg = cellImg(1:comX,:,:);
        elseif(m < comX)
            cellImg(comX,comY,:) = 0;
        end %elseif
    end %if
    
    if(n ~= comY)
        if(n > comY)
            cellImg = cellImg(:,1:comY,:); 
        elseif(n < comY)
            cellImg(comX, comY,:) = 0;
        end%elseif
    end%else
    a = im2double(cellImg);
    b = mat2cell(a,comX, comY, 3);
    normCell(i) = b;%cellImg;
    
end

outIm = normCell;

end

