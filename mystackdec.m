function [ decoded ] = mystackdec( code, trellis, tau, stacksize)
%���ߣ�Ԭ����
%������ѧͨ�ſ�ѧ�빤��ϵ
%��ջ����Ĵ��룬��Ҫ�����1��m�������Ʊ���ľ�������룬���෽ʽ
%��δ���ԡ�
%codeΪ�����������Ϣ��trellis��matlab���Դ������������Ľṹ�壬tau
%�Ƿֿ�����ÿ���е���Ϣλ����stacksize��ָ���Ķ�ջ������
    L = length(code);
    bit_input = log2(trellis.numInputSymbols);
    bit_output = log2(trellis.numOutputSymbols);
    reshapecode = reshape(code, bit_output, L/bit_output);
    reshapecode = reshapecode';
    nextstates = trellis.nextStates;
    outputs = trellis.outputs;
    decoded = zeros(1, L/bit_output);
    %���յ�����Ϣ�ֿ鰴tau�ֿ�����
    for step = 1 : tau  : L/bit_output - tau + 1
        now_in = reshapecode(step : step + tau - 1 , :);
        %��ʼ����ջ,��ջҪ�ȹ涨�Ķ�ջ��С��һ���洢�ռ�
        for j = 1:stacksize+1
            stack(j).metric = -inf;
            stack(j).path = [];
            stack(j).state = 0;
        end
        stack(1).metric = 0;
        %�Էֿ���Ϣ�е�tau�����������
        while (length(stack(1).path)<tau) 
            %��ջ������Ľڵ�·�������涨��·�����ȣ��˳�ѭ��
            i = length(stack(1).path)+1;
            temp = now_in(i,:);
            %����ǰ���������ת����10����
            dec_in = barr2dec(temp);
            %����ѡ��0��1��ͬ��֧������������ֵĺ�������
            d_0 = hamdistdec(dec_in, outputs(stack(1).state+1, 1));
            d_1 = hamdistdec(dec_in, outputs(stack(1).state+1, 2));
            %�½�������ջ�������֧�ڵ���Ϣ
            stack_new_0.metric = stack(1).metric + 1 - 2 * d_0;
            stack_new_0.path = [stack(1).path;0];
            stack_new_0.state = nextstates(stack(1).state+1, 1);
            stack_new_1.metric = stack(1).metric + 1 - 2 * d_1;
            stack_new_1.path = [stack(1).path;1];
            stack_new_1.state = nextstates(stack(1).state+1, 2);
            %��������֧ѹ��ջ�У���ɾ����һ����֧
            stack(1) = stack_new_0;
            stack = mypush(stack_new_1, stack);
            %���ж�ջ�ڽڵ����������
            [sortedmetric, index] = sort([stack.metric], 'descend');
            stack = stack(index(:));
        end
        decoded(step : step + tau - 1) = stack(1).path;
    end
end

