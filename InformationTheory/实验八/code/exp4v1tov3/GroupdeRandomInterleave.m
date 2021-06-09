function [Cde] = GroupdeRandomInterleave(Ce,rule,N,zero_random)
%UNTITLED4 此处显示有关此函数的摘要
    len = length(Ce);
    nb = fix(len/N);
    Cde = zeros(size(Ce));
    % R_HM_block = 0;
    for k = 1:nb
        R_block = Ce(1+(k-1)*N : N+(k-1)*N);
        temp = deRandomInterleave(R_block,rule);
        Cde(1+(k-1)*N : N+(k-1)*N) = temp;
    end
    Cde = Cde(1:end-zero_random);
end

function [Cde] = deRandomInterleave(Ce,rule)
    Cde = zeros(size(Ce));
    for k = 1:length(Ce)
        Cde(rule(k)) = Ce(k);
    end
end
