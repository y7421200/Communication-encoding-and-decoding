function [ decnum ] = barr2dec( binarry )
%作者：袁方星
%复旦大学通信科学与工程系
%将二进制数组转化为十进制
    L = length(binarry);
    p = 0;
    decnum = 0;
    for i = L:-1:1
       decnum =decnum + binarry(i)*(2^p);
       p = p + 1;
    end
end

