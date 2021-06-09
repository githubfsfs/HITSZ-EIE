function [Cde] = GroupdeConvInterleave(Ce,B,M)
% function：实现（B,M）卷积交织编码
% input:
%   C:original code
%   B:number of branch
%   M:number of shift register every unit
% output:
%   Ce:encoded code
% auther:Cheng Junlan
% vision & data:v1----2021.5.31
len = length(Ce);
% 恢复输出前的卷积块
R = fliplr(reshape(Ce,B,[]));

% 无效信息的个数
ze = B*(B-1)*M;
max_delay = (B-1)*M;% 最长的延迟位数
lene = len - ze;%有效信息的长度
flag = mod(lene,B);%有效信息在每行的个数是否相等？如果相等，那么余数为0，否则为非0值

% 取出有效信息
if flag == 0 %有效信息在每行的数量一致
    C_per_row = lene/B;%每行有效信息的长度
    C_eff = zeros(B,C_per_row);% 有效信息矩阵
    for k = 1:B
        C_eff(k,:) = R(k,max_delay+1-(k-1)*M : max_delay+1-(k-1)*M+C_per_row-1);   
    end    
else
    C_per_row = fix(lene/B);%每行有效信息的最短长度
    C_eff = zeors(B,C_per_row+1);% 有效信息矩阵
    for k = 1:B
        if k <= mod
            C_eff(k,:) = R(k,max_delay-(k-1)*M : max_delay-(k-1)*M+C_per_row-1+1);
        else
            C_eff(k,2:end) = R(k,max_delay+1-(k-1)*M : max_delay+1-(k-1)*M+C_per_row-1);
        end
    end
end
Cde_eff = reshape(fliplr(C_eff),1,[]);%重排成一行
Cde = Cde_eff(1:lene);%去掉在解码过程中补的零

end
