function [Cde] = deConvInterleave(Ce,B,M)
% function��ʵ�֣�B,M�������֯����
% input:
%   C:original code
%   B:number of branch
%   M:number of shift register every unit
% output:
%   Ce:encoded code
% auther:Cheng Junlan
    % vision & data:v1----2021.5.31
    len = length(Ce)-B*(B-1)*M;%��Ч��Ϣ����
    for i=1:len
        col = mod(i-1,B);
        index = col*B*M+i;
        Cde(1,i) = Ce(1,index);
    end
end
