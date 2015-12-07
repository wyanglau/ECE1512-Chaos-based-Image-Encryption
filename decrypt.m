function [ dec_after_SCAMBLED ] = decrypt( dec_dct,key )
%%decryption
[M,N] = size(dec_dct);
[H,S,P] = genTransMatrix(M,N,key);

dec_dct = round(dec_dct./S);
dec_after_xor=bitxor(P,abs(dec_dct));
for i  = 1:M
    for j = 1:N
        dec_after_xor(i,j) = bitxor(abs(dec_dct(i,j)),P(i,j));
      
        if(dec_dct(i,j)<0)
            dec_after_xor(i,j)=-dec_after_xor(i,j);
        end
    end
end


dec_BLOCK = mat2cell(dec_after_xor,ones(M/8,1)*8,ones(N/8,1)*8);
BLOCKsize = size(dec_BLOCK);
dec_SCAMBLED = cell(BLOCKsize);
%%reverse scambling
for i = 1:length(H)
    dec_SCAMBLED(H(i)) = dec_BLOCK(i); % resume blocks
end
dec_after_SCAMBLED = cell2mat(dec_SCAMBLED);


end

