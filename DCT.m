
function [ B ] = DCT( I, type)
T = dctmtx(8);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[8 8],dct);


mask = [1   1   1   1   1   1   0   0
        1   1   1   1   1   0   0   0
        1   1   1   1   0   0   0   0
        1   1   1   0   0   0   0   0
        1   1   0   0   0   0   0   0
        1   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];
 B2 = blockproc(B,[8 8],@(block_struct) mask .* block_struct.data);

 if (type == 1)
     B=B2;
 end

end

