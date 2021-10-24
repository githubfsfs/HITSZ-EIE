function matrix_out = cycle(matrix_in,direction)
%   实现输入矩阵第n行向左或者向右移动n字节
%% 做法一，比较巧妙，参照网上的资料
% if strcmp(direction,'left')
%     col = (0:5:15)';% 左移
% else
%     col = (16:-3:7)';% 右移
% end
% row = 0:4:12;
% cols = repmat(col,1,4);
% rows = repmat(row,4,1);
% mat = mod(rows + cols,16)+1;%要+1否？
% matrix_out = matrix_in(mat);

%% 做法二，易于理解
matrix_out = zeros(size(matrix_in));
matrix_out(1,:) = matrix_in(1,:);
if strcmp(direction,'left')
    for i = 2:4
        matrix_out(i,:) = round_shift(matrix_in(i,:),'left',i-1)
    end
else
    for i = 2:4
        matrix_out(i,:) = round_shift(matrix_in(i,:),'right',i-1)
    end
end
end
