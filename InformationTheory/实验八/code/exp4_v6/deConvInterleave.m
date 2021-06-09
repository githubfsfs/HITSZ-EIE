function [Cde] = deConvInterleave(Ce,B,M)
% function：实现（B,M）卷积交织编码
% input:
%   C:original code
%   B:number of branch
%   M:number of shift register every unit
% output:
%   Ce:encoded code
% auther:Cheng Junlan
    % vision & data:v1----2021.5.31
    len = length(Ce)-B*(B-1)*M;%有效信息长度
    for i=1:len
        col = mod(i-1,B);
        index = col*B*M+i;
        Cde(1,i) = Ce(1,index);
    end
end
