%С��ҵ������������-��������
%���ߣ�Ԭ����
%������ѧͨ�ſ�ѧ�빤��ϵ
%ͨ�Ź���רҵ
%% ��ջ�����㷨�ķ���
%����һ����3��1�������ı��������
clear;
clc;

%���ж����Ƽ��Ը�˹�������ŵ�����
%����һ������Ϊ10000���������������

dataIn = randi([0 1],10,1);
tPoly = poly2trellis(3,[7 5 4]);
code = convenc(dataIn, tPoly);
%Ϊ������ͬ���Ӷ��½���ά�ر�����Ͷ�ջ����ıȽϣ������������Ϊ5
%����ջ�����ж�ջ�Ĵ�С������ά�ر��㷨���о���ʽ����ΪӲ�о���
decodedvit = vitdec(code,tPoly,5,'cont','hard');
decodedstk = mystackdec(code, tPoly, 10, 5);
decodedstk = decodedstk';
d = 0;
for i = 1 : length(dataIn)
    if (decoded(i) ~= dataIn(i))
        d = d+1;
    end  
end      

