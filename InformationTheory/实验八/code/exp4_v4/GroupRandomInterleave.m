function [C_RANDOM,rule,zero_random] = GroupRandomInterleave(C,N)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
    len = length(C(:));% 
    nb = fix(len/N);% num_of_block 理论上分块数
    mb = mod(len,N);% mod_of_block 无法整除时，余数不为0
    C_RANDOM = zeros(1,nb*N );
    % 重排
    C_ZE = reshape(C,1,[]);% 重排
    rule = randperm(N);% 所有分块使用同种编码规则
    % 补零
    zero_random = 0;%补零个数
    if mb ~= 0 %如果余数不为0，则需要补零 
        C_RANDOM = zeros(1,(nb+1)*N);
        C_ZE = [C_ZE,zeros(1 , N-mb)];%补零
        zero_random = N-mb;%补零个数
        nb = nb+1;%此时block的数目增加1
    end
    % 分块进行随机交织
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