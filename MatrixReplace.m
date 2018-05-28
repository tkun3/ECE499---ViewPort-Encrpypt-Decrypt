function A = MatrixReplace(A,B)
    [p,q] = size(B); 
    A(end-p+1:end, end-q+1:end) = B; 
end