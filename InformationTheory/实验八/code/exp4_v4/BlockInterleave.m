function [Ce] = BlockInterleave(C,m,n)
% function��ʵ�֣�m,n�����齻֯����
% aim:��ɢͻ������
% input:
%   C:original code
%   m:number of rows
%   n:number of column
% output:
%   Ce:encoded code
% auther:Cheng Junlan
% vision & data:v1----2021.5.31
% problem:������кܴ�ԶԶ����m,n����ô��Ӧ��ȷ��n����ӦΪ����������������������죿
if nargin == 1
    m = 4;
    n = 3;
end
%% ����
% rem = mod(length(C),n);%����
% if rem ~= 0
%     C  = [C,zeros(1,n-rem)];
% end
Cz  = [C,zeros(1,m*n-length(C))];%����������

R = reshape(Cz,n,[])';
Ce = reshape(R,1,[]);
end

