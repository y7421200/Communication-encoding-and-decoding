function [ new_stack ] = mypush(stack_unit, stack )
%���ߣ�Ԭ����
%������ѧͨ�ſ�ѧ�빤��ϵ
%��ջ��push����
    new_stack = circshift(stack, 1);
    new_stack(1) = stack_unit;
end

