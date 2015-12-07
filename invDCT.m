function [ image ] = invDCT( DCT )
T = dctmtx(8);
invdct = @(block_struct) T' * block_struct.data * T;
image = blockproc(DCT,[8 8],invdct);
end

