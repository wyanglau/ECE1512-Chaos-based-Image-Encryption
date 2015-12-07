function [ encrypted_symbolized ] = encrypt( original_dct,key )
[M,N] = size(original_dct);
%%Encryption
[H,S,P] = genTransMatrix(M,N,key);
BLOCK = mat2cell(original_dct,ones(M/8,1)*8,ones(N/8,1)*8);
BLOCKsize = size(BLOCK);
SCAMBLED = cell(BLOCKsize);

for i = 1:length(H)
    SCAMBLED(i) = BLOCK(H(i)); % scambling blocks
end

enc_after_scambling = cell2mat(SCAMBLED);
for i  = 1:M
    for j = 1:N
        encrypted(i,j) = bitxor(abs(enc_after_scambling(i,j)),P(i,j));
        if encrypted(i,j) == 0 
            encrypted(i,j)= enc_after_scambling(i,j);
        end
        if(enc_after_scambling(i,j)<0)
            encrypted(i,j)=-encrypted(i,j);
        end
    end
end

 encrypted_symbolized = S.*encrypted;    

end

