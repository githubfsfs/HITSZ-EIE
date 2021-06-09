function [ next_state,memory_contents ] = next_state_function( current_state,input,L,k )
%��n,k,L������,�Ĵ�����һʱ��״̬��ת����ǰʱ������
%   current_state    ��ǰ�Ĵ���״̬(DEC)
%   input            �������루DEC��������֧���
%   L                Լ������
%   k                ����λ��
%   next_state       ��һʱ�̼Ĵ���״̬(DEC)
%   memory_contents  ��ǰʱ�̼Ĵ������ݣ�BIN��
bin_current_state = dec2bin(current_state,k*(L-1));
bin_input = dec2bin(input,k);
bin_next_state = [bin_input,bin_current_state(1:k*(L-2))];
next_state = bin2dec(bin_next_state);
memory_contents = [bin_input,bin_current_state];
end

