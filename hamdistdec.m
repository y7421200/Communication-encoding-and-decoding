function [ d ] = hamdistdec( x, y )
%����:Ԭ����
%������ѧͨ�ſ�ѧ�빤��ϵ
%��������ʮ�������Ķ����ƺ�������
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

