function [ y ] = dec2bin( x,L )
% ʮ������תΪ��������
%   x  ʮ������
%   y  ��������
%   L  ������������
y = zeros(1,L);
i = 1;
while x>=0 && i<=L
    y(i) = rem(x,2);
    x = (x-y(i))/2;
    i = i+1;
end
y = y(L:-1:1);
end
