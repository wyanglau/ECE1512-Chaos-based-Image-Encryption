function [histogram] = generateHistogram(I)
[M,N] = size(I);
histogram = zeros(1, 256);
for m=1:M
    for n= 1:N
        if(I(m,n)>255)|| (I(m,n)<0)
            continue;
        end
        histogram(I(m,n)+1) =  histogram(I(m,n)+1)+1;
    end
end
end