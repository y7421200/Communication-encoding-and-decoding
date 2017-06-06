function [ d ] = hamdistdec( x, y )
%作者:袁方星
%复旦大学通信科学与工程系
%计算两个十进制数的二进制汉明距离
    xb = (dec2bin(x)=='1');
    yb = (dec2bin(y)=='1');
    L = max(length(xb),length(yb));
    temp = zeros(L,1);
    temp(L-length(xb)+1:length(temp)) = xb;
    xb = temp;
    temp = zeros(L,1);
    temp(L-length(yb)+1:length(temp)) = yb;
    yb = temp;
    d = 0;
    for i = 1:L
        if (xb(i) ~= yb(i))
            d = d + 1;
        end
    end
end

