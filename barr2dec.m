function [ decnum ] = barr2dec( binarry )
%���ߣ�Ԭ����
%������ѧͨ�ſ�ѧ�빤��ϵ
%������������ת��Ϊʮ����
    L = length(binarry);
    p = 0;
    decnum = 0;
    for i = L:-1:1
       decnum =decnum + binarry(i)*(2^p);
       p = p + 1;
    end
end

