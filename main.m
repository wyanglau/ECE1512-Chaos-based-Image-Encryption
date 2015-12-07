close all;
clear all;
I1 = imread('lena.bmp');
I2 = imread('cameraman.tif');
I3 = imread('Football.jpg');
I4 = imread('Rice.tif');
Is=cell(1,4);
Is{1} = I1;
Is{2} = I2;
Is{3}=I3(1:256,1:256);
Is{4}=I4;

for i = 1:1
    I = Is(i);
    I = cell2mat(I);
   
tic;
% hist_src= generateHistogram(I);
% x = [1:1:256];


%I= rgb2gray(I);

I = im2double(I);
[M,N] = size(I);
M=M-mod(M,8);
N=N-mod(N,8);
I=I(1:M,1:N);
I_src = I;

key  = 0.66;
wrong_key  = 0.6600000000000001;

%%encryption
I = I*255-128;
%original_dct = DCT(I,0);
 original_dct=dct(I);
original_dct= round (original_dct*0.5);


encrypted= encrypt(original_dct,key);
 wrong_encrypted = encrypt(original_dct,wrong_key);
%encrypted = invDCT(encrypted);
%wrong_encrypted=invDCT(wrong_encrypted);
% encrypted = idct(encrypted);
% wrong_encrypted=idct(wrong_encrypted);

%%--test store--
% imwrite(encrypted,'tst.bmp','bmp');
% encrypted = imread('tst.bmp');
% encrypted = im2double(encrypted);
%%--test end


% 
% %draw the correlation between different keys
% right = encrypted(:,1:(M),1); 
% wrong = wrong_encrypted(:,1:(M),1);
% randIndex = randperm(numel(right));
% randIndex = randIndex(1:199);
% right = right(randIndex);
% wrong=wrong(randIndex);
% r_right_wrong = corrcoef(right,wrong);
% scatter(right(:),wrong(:)),title('Correlation of key1 = 0.66, key2=0.6600000000000001, r=-0.0583');
% 
% % 
% %draw histogram
%  normalize_encrypted = mapminmax(encrypted,0,1);
%  [counts,binLocations] = imhist(normalize_encrypted);
%  %figure, stem(binLocations,counts);
% hist_enc= generateHistogram(abs(round(encrypted)));
% %subplot(1,2,2),bar(x,hist_enc),title('Histogram of encrypted');
% %figure,imshow(encrypted);

%%decryption----------

% %%---add noise

[encrypted_norm,settings]=mapminmax(encrypted,0,1);
%en_reverse = mapminmax.reverse(encrypted_after_noise,settings);
 encrypted_after_noise = imnoise(encrypted_norm,'salt & pepper');
 encrypted_after_noise = mapminmax.reverse(encrypted_after_noise,settings);

% %%------add noise end

%dec_dct = DCT(encrypted_after_noise);
% dec_dct=dct(encrypted);
dec_after_SCAMBLED = decrypt(encrypted,key);
dec_after_SCAMBLED = dec_after_SCAMBLED/0.5;
decreption_result = idct(dec_after_SCAMBLED);
%decreption_result = invDCT(dec_after_SCAMBLED);
%% test --
% test = idct(original_dct/0.5);
% test= (test+128)/255;
% test_readEncrypted = imread('tst.jpg');
% %test_readEncrypted= im2double(test_readEncrypted);
  [I_src_norm,settings]=mapminmax(original_dct,0,1);
   I_src_afternoise = imnoise(I_src_norm,'gaussian');
    I_src_afternoise = mapminmax.reverse(I_src_afternoise,settings);
    I_src_afternoise= I_src_afternoise/0.5
    I_src_afternoise =idct(I_src_afternoise);
      I_src_afternoise =  (I_src_afternoise+128)/255;

%figure, imshow(I_src_afternoise);
% subplot(1,2,1),subimage(test),title('1');
% 
% subplot(1,2,2),subimage(I_src_afternoise),title('2');

%% test - end
% decreption_result=idct(dec_after_SCAMBLED);

 
decreption_result= (decreption_result+128)/255;
%decreption_result=filter2(fspecial('average',3),decreption_result);


%%batch draw images
% subplot(4,3,(i-1)*3+1),subimage(I_src),title('input');
% subplot(4,3,(i-1)*3+2),subimage(encrypted),title('encrypted');
% subplot(4,3,(i-1)*3+3),subimage(decreption_result),title('decrypted');

subplot(1,2,1),subimage(I_src),title('input');
subplot(1,2,2),subimage(decreption_result),title('decrypted');




%% batch draw histograms
% subplot(4,3,(i-1)*3+1),subimage(I_src),title('input');
% [counts,binLocations] = imhist(I_src);
% subplot(4,3,(i-1)*3+2),bar(binLocations,counts),title('original') ;
% [encrypted_norm,settings]=mapminmax(encrypted,0,1);
% [counts,binLocations] = imhist(encrypted_norm);
% subplot(4,3,(i-1)*3+3),bar(binLocations,counts),title('encrypted') ;




% %draw correalation index
% % %original
% x_src = I_src(:,1:(M-1),1); 
% y_src = I_src(:,2:(M),1);
% randIndex = randperm(numel(x_src));
% randIndex = randIndex(1:200);
% x_src_1 = x_src(randIndex);
% y_src_1 = y_src(randIndex);
% r_xy_src_1 = corrcoef(x_src_1,y_src_1);
% subplot(3,2,1),scatter(x_src_1(:),y_src_1(:)),title('original horizontal');
% 
% %1.horizontal
% x1 = encrypted(:,1:(M-1),1); 
% y1 = encrypted(:,2:(M),1);
% randIndex_x1 = randperm(numel(x1));
% randIndex_x1 = randIndex_x1(1:200);
% x1 = x1(randIndex_x1);
% y1 = y1(randIndex_x1);
% r_xy1 = corrcoef(x1,y1);
% subplot(3,2,2),scatter(x1(:),y1(:)),title('encrypted horizontal');
% 
% % %2. vertical
% x_src = I_src(1:N-1,:,1);
% y_src = I_src(2:N,:,1);
% randIndex = randperm(numel(x_src));
% randIndex = randIndex(1:200);
% x_src_1 = x_src(randIndex);
% y_src_1 = y_src(randIndex);
% r_xy_src_2 = corrcoef(x_src_1,y_src_1);
% subplot(3,2,3),scatter(x_src_1(:),y_src_1(:)),title('vertical');
% 
% 
% x2 = encrypted(1:N-1,:,1);
% y2 = encrypted(2:N,:,1);
% randIndex = randperm(numel(x2));
% randIndex = randIndex(1:200);
% x2 = x2(randIndex);
% y2 = y2(randIndex);
% r_xy2 = corrcoef(x2,y2);
% subplot(3,2,4),scatter(x2(:),y2(:)),title('vertical');
% 
% % 
% % %3. diagnal
% x_src = I_src(1:N-1,1:M-1,1);
% y_src = I_src(2:N,2:M,1); 
% randIndex = randperm(numel(x_src));
% randIndex = randIndex(1:200);
% x_src_1 = x_src(randIndex);
% y_src_1 = y_src(randIndex);
% r_xy_src_3 = corrcoef(x_src_1,y_src_1);
% subplot(3,2,5),scatter(x_src_1(:),y_src_1(:)),title('diagnal');
% 
% 
% x3 = encrypted(1:N-1,1:M-1,1);
% y3 = encrypted(2:N,2:M,1); 
% randIndex = randperm(numel(x3));
% randIndex = randIndex(1:200);
% x3 = x3(randIndex);
% y3 = y3(randIndex);
% r_xy3 = corrcoef(x3,y3);
% subplot(3,2,6),scatter(x3(:),y3(:)),title('diagnal');

% 
% % %4. random select 100 colums
% 
% % randIndex = randperm(numel(x1));
% % randIndex = randIndex(1:100);
% % xRand = x1(randIndex);
% % yRand = y1(randIndex);
% % r_xy4 = corrcoef(xRand,yRand);
% % %scatter(xRand(:),yRand(:));
% % 
toc;
disp([i,num2str(toc)]);



end

