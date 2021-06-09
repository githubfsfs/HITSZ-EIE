function [C_BLOCK,zero_block] = GroupBlockInterleave(C,m,n)
%  任何变量名没有冒犯的意思
% 分块
    sb = m*n;% size_of_block
    len = length(C(:));% 
    nb = fix(len/sb);% num_of_block 理论上分块数
    mb = mod(len,sb);% mod_of_block 无法整除时，余数不为0
    C_BLOCK = zeros(1,nb*sb );
    % 重排
    C_ZE = reshape(C',[],1)';% 重排
    % 补零
    zero_block = 0;%补零个数
    if mb ~= 0 %如果余数不为0，则需要补零 
        C_BLOCK = zeros(1,(nb+1)*sb);
        C_ZE = [C_ZE,zeros(1 ,sb-mb)];%补零
        zero_block = sb-mb;%补零个数
        nb = nb+1;%此时block的数目增加1
    end
    % 分块交织
    for k = 1:nb
         C_HM_block =  C_ZE(1+(k-1)*sb : sb+(k-1)*sb);
        Ce = BlockInterleave(C_HM_block,m,n);%每块进行分组
        C_BLOCK(1+(k-1)*sb : sb+(k-1)*sb) = Ce;
    end
    
    function [Ce] = BlockInterleave(C,m,n)
    %     Cz  = [C,zeros(1,m*n-length(C))];%补零后的序列，在分块前已经进行了补零
        R = reshape(C,n,m)';
        Ce = reshape(R,1,[]);
    end    
end

%% -------v2-------%
% function [C_BLOCK,zero_block] = GroupBlockInterleave(C,m,n)
% %  任何变量名没有冒犯的意思
% % 分块
%    C_BLOCK = []; sz = m * n;
%    if mod(length(C), sz) ~= 0
%       zero_block = sz - mod(length(C), sz);
%       C = [C zeros(1, zero_block)];
%    else
%       zero_block = 0;
%    end
%    
%    for i = 1: sz: length(C)-1 % 分块
%       c = C(i: i+sz-1);
%       C_BLOCK = [C_BLOCK interleaver(c)];% 
%    end
%    
%    function co = interleaver(ci)
%       R  = reshape(ci, n, m);
%       co = reshape(R', 1, sz);
%    end
% end


%-----v1-----%
% function [C_BLOCK,zero_block] = GroupBlockInterleave(C,m,n)
% %  任何变量名没有冒犯的意思
% % 分块
%     sb = m*n;% size_of_block
%     len = length(C(:));% 
%     nb = fix(len/sb);% num_of_block 理论上分块数
%     mb = mod(len,sb);% mod_of_block 无法整除时，余数不为0
%     C_BLOCK = zeros(1,nb*sb );
%     % 重排
%     C_ZE = reshape(C,1,[]);% 重排
%     % 补零
%     zero_block = 0;%补零个数
%     if mb ~= 0 %如果余数不为0，则需要补零 
%         C_BLOCK = zeros(1,(nb+1)*sb);
%         C_ZE = [C_ZE,zeros(1 ,sb-mb)];%补零
%         zero_block = sb-mb;%补零个数
%         nb = nb+1;%此时block的数目增加1
%     end
%     % 分块交织
%     for k = 1:nb
%          C_HM_block =  C_ZE(1+(k-1)*sb : sb+(k-1)*sb);
%         Ce = BlockInterleave(C_HM_block,m,n);%每块进行分组
%         C_BLOCK(1+(k-1)*sb : sb+(k-1)*sb) = Ce;
%     end
%     
%     function [Ce] = BlockInterleave(C,m,n)
%     %     Cz  = [C,zeros(1,m*n-length(C))];%补零后的序列，在分块前已经进行了补零
%         R = reshape(C,n,m)';
%         Ce = reshape(R,1,[]);
%     end    
% end
