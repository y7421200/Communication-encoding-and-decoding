%小作业：卷积码的译码-序列译码
%作者：袁方星
%复旦大学通信科学与工程系
%通信工程专业
%% 堆栈译码算法的仿真
%进行一个（3，1）卷积码的编码和译码
clear;
clc;

%进行二进制加性高斯白噪声信道仿真
%构造一个长度为10000的随机二进制序列

dataIn = randi([0 1],10,1);
tPoly = poly2trellis(3,[7 5 4]);
code = convenc(dataIn, tPoly);
%为了在相同复杂度下进行维特比译码和堆栈译码的比较，回溯深度设置为5
%即堆栈译码中堆栈的大小，并将维特比算法的判决方式设置为硬判决。
decodedvit = vitdec(code,tPoly,5,'cont','hard');
decodedstk = mystackdec(code, tPoly, 10, 5);
decodedstk = decodedstk';
d = 0;
for i = 1 : length(dataIn)
    if (decoded(i) ~= dataIn(i))
        d = d+1;
    end  
end      

