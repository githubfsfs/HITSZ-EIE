function [Cde] = GroupdeConvInterleave(Ce,B,M)
% function��ʵ�֣�B,M�������֯����
% input:
%   C:original code
%   B:number of branch
%   M:number of shift register every unit
% output:
%   Ce:encoded code
% auther:Cheng Junlan
% vision & data:v1----2021.5.31
len = length(Ce);
% �ָ����ǰ�ľ����
R = fliplr(reshape(Ce,B,[]));

% ��Ч��Ϣ�ĸ���
ze = B*(B-1)*M;
max_delay = (B-1)*M;% ����ӳ�λ��
lene = len - ze;%��Ч��Ϣ�ĳ���
flag = mod(lene,B);%��Ч��Ϣ��ÿ�еĸ����Ƿ���ȣ������ȣ���ô����Ϊ0������Ϊ��0ֵ

% ȡ����Ч��Ϣ
if flag == 0 %��Ч��Ϣ��ÿ�е�����һ��
    C_per_row = lene/B;%ÿ����Ч��Ϣ�ĳ���
    C_eff = zeros(B,C_per_row);% ��Ч��Ϣ����
    for k = 1:B
        C_eff(k,:) = R(k,max_delay+1-(k-1)*M : max_delay+1-(k-1)*M+C_per_row-1);   
    end    
else
    C_per_row = fix(lene/B);%ÿ����Ч��Ϣ����̳���
    C_eff = zeors(B,C_per_row+1);% ��Ч��Ϣ����
    for k = 1:B
        if k <= mod
            C_eff(k,:) = R(k,max_delay-(k-1)*M : max_delay-(k-1)*M+C_per_row-1+1);
        else
            C_eff(k,2:end) = R(k,max_delay+1-(k-1)*M : max_delay+1-(k-1)*M+C_per_row-1);
        end
    end
end
Cde_eff = reshape(fliplr(C_eff),1,[]);%���ų�һ��
Cde = Cde_eff(1:lene);%ȥ���ڽ�������в�����

end
