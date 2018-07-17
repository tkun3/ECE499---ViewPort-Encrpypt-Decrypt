%Decryption Function to reconstruct the original image
%Random state is manually set though can be replaced with a key like system
%Written by Takuma Pimlott
%CENG 499

function [outImage] = decrypt(inputImage,x, y)

%-----------SET RANDOM STATE------
%RANDOM STATE of decrypter must be matching the encrypter
%This rand state will be used as the decryption "key"

xPreHash = zeros([1 x]);
yPreHash = zeros([1 y]);

for i = 1:1:x
    xPreHash(i) = i;
end

for i = 1:1:y
    yPreHash(i) = i;
end


[m1,n1] = size(xPreHash) ;
[m2,n2] = size(yPreHash) ;

rng(1);
idx = randperm(n1) ;
xHash = xPreHash;
xHash(1,idx) = xPreHash(1,:);

rng(1);
idy = randperm(n2) ;
yHash = yPreHash;
yHash(1,idy) = yPreHash(1,:);


blockXY = reshape(inputImage, [x,y]);


%Blocks Decrypted
%blockRd = cell(x,y);
%blockGd = cell(x,y);
%blockBd = cell(x,y);

%Blocks Encrypted
%blockRe = cell(x,y);
%blockGe = cell(x,y);
%blockBe = cell(x,y);

blockXYd = cell(x,y);

for i = 1:1:x
   for j = 1:1:y
        
       % blockRd{xHash(i),yHash(j)} = blockRe{i,j};

      %  blockGd{xHash(i),yHash(j)} = blockGe{i,j};

       % blockBd{xHash(i),yHash(j)} = blockBe{i,j};
       
       blockXYd{xHash(i),yHash(j)} = blockXY{i,j};
        
   end
  
end

outputConverted = cell2mat(blockXYd);


outImage = outputConverted;

end

