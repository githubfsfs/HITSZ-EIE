function [C_RANDOM,rule,zero_random] = GroupRandomInterleave(C,N)
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    len = length(C(:));% 
    nb = fix(len/N);% num_of_block �����Ϸֿ���
    mb = mod(len,N);% mod_of_block �޷�����ʱ��������Ϊ0
    C_RANDOM = zeros(1,nb*N );
    % ����
    C_ZE = reshape(C,1,[]);% ����
    rule = randperm(N);% ���зֿ�ʹ��ͬ�ֱ������
    % ����
    zero_random = 0;%�������
    if mb ~= 0 %���������Ϊ0������Ҫ���� 
        C_RANDOM = zeros(1,(nb+1)*N);
        C_ZE = [C_ZE,zeros(1 , N-mb)];%����
        zero_random = N-mb;%�������
        nb = nb+1;%��ʱblock����Ŀ����1
    end
    % �ֿ���������֯
    for k = 1:nb
         C_HM_block =  C_ZE(1+(k-1)*N : N+(k-1)*N);
        Ce = RandomInterleave(C_HM_block,N,rule);
        C_RANDOM(1+(k-1)*N : N+(k-1)*N) = Ce;
    end
end
function Ce = RandomInterleave(C,N,rule)
    len = length(C);
    C = [C,zeros(1,N-len)];
    Ce = C(rule);
end