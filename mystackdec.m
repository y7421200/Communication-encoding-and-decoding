function [ decoded ] = mystackdec( code, trellis, tau, stacksize)
%作者：袁方星
%复旦大学通信科学与工程系
%堆栈译码的代码，主要解决（1，m）二进制编码的卷积码译码，其余方式
%暂未尝试。
%code为经过编码的信息，trellis是matlab中自带卷积码编码器的结构体，tau
%是分块译码每块中的信息位数，stacksize是指定的堆栈容量。
    L = length(code);
    bit_input = log2(trellis.numInputSymbols);
    bit_output = log2(trellis.numOutputSymbols);
    reshapecode = reshape(code, bit_output, L/bit_output);
    reshapecode = reshapecode';
    nextstates = trellis.nextStates;
    outputs = trellis.outputs;
    decoded = zeros(1, L/bit_output);
    %将收到的信息分块按tau分块译码
    for step = 1 : tau  : L/bit_output - tau + 1
        now_in = reshapecode(step : step + tau - 1 , :);
        %初始化堆栈,堆栈要比规定的堆栈大小多一个存储空间
        for j = 1:stacksize+1
            stack(j).metric = -inf;
            stack(j).path = [];
            stack(j).state = 0;
        end
        stack(1).metric = 0;
        %对分块信息中的tau个码进行译码
        while (length(stack(1).path)<tau) 
            %当栈顶保存的节点路径超过规定的路径长度，退出循环
            i = length(stack(1).path)+1;
            temp = now_in(i,:);
            %将当前待处理的码转换成10进制
            dec_in = barr2dec(temp);
            %计算选择0，1不同分支输出和输入码字的汉明距离
            d_0 = hamdistdec(dec_in, outputs(stack(1).state+1, 1));
            d_1 = hamdistdec(dec_in, outputs(stack(1).state+1, 2));
            %新建两个堆栈，保存分支节点信息
            stack_new_0.metric = stack(1).metric + 1 - 2 * d_0;
            stack_new_0.path = [stack(1).path;0];
            stack_new_0.state = nextstates(stack(1).state+1, 1);
            stack_new_1.metric = stack(1).metric + 1 - 2 * d_1;
            stack_new_1.path = [stack(1).path;1];
            stack_new_1.state = nextstates(stack(1).state+1, 2);
            %将两个分支压进栈中，并删除上一级分支
            stack(1) = stack_new_0;
            stack = mypush(stack_new_1, stack);
            %进行堆栈内节点度量的排序
            [sortedmetric, index] = sort([stack.metric], 'descend');
            stack = stack(index(:));
        end
        decoded(step : step + tau - 1) = stack(1).path;
    end
end

