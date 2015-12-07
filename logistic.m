clear all;
N=128;
M=128;
%%1. Generate basic Logistic Array
K=M*N;
u=4;
x(1)=0.66;
for i=1:K-1
    x(i+1)=u*x(i)-u*x(i)^2;
end

%%2. Generate symbolize matrix S
y(1) = 0.25; % This key is weak. But not important
key=5;
for i = 1:K-1
    y(i+1) = cos(key*(acosd(y(i))));
end

for i= 1:K-1
    if(x(i)<y(i))
        S(i) = -1;
    else
        S(i)=1;
    end
end



%%3. Retrieve the first M/8 * N/8 elements
L = x(1:(M/8)*(N/8));
[L_s,H] = sort(L,'descend'); % H can be used as scrambling array.

%ScambledDCT=uint8(zeros(M/8,N/8));
% for i= 1: M*N
%     Scambled(i) = I(H(i));
% end;

%%4. Generate transformation matirx P
x=double(mod(round(x*10^14), 256) + 1);
K1 = 1;
for i=1: (M)
    for j= 1: (N)
        P(i,j) = x(K1);
        K1=K1+1;
    end
end





disp('fiKish');