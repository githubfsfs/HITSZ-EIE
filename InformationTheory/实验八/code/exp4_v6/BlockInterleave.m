function [Ce] = BlockInterleave(C,m,n)
% function：实现（m,n）分组交织编码
% aim:分散突发错误
% input:
%   C:original code
%   m:number of rows
%   n:number of column
% output:
%   Ce:encoded code
% auther:Cheng Junlan
% vision & data:v1----2021.5.31
% problem:如果序列很大，远远大于m,n那怎么办应该确定n先吗？应为按行填，则行数可以无限延伸？
if nargin == 1
    m = 4;
    n = 3;
end
%% 补零
% rem = mod(length(C),n);%余数
% if rem ~= 0
%     C  = [C,zeros(1,n-rem)];
% end
Cz  = [C,zeros(1,m*n-length(C))];%补零后的序列

R = reshape(Cz,n,[])';
Ce = reshape(R,1,[]);
end

