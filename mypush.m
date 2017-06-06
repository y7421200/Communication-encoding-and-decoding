function [ new_stack ] = mypush(stack_unit, stack )
%作者：袁方星
%复旦大学通信科学与工程系
%堆栈的push操作
    new_stack = circshift(stack, 1);
    new_stack(1) = stack_unit;
end

