function [ y ] = bin2dec( x )
% ��������תΪʮ������
%   x  ��������
%   y  ʮ������
L = length(x);
y = (L-1:-1:0);
y = 2.^y;
y = x*y';
end
