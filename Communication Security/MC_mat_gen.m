function [MC_mat,MC_mat_inv] = MC_mat_gen()
% 函数功能：生成用于列混淆的多项式矩阵

% 逆列混淆矩阵的构造
row_hex = {'02' '03' '01' '01'};    % 第一行
row = hex2dec(row_hex)';            % 转置后才是行向量
rows = repmat(row,4,1);             % 复制第一行，生成4×4矩阵
MC_mat = cycle(rows,'right');     % 向右循环移位

% 逆列混淆矩阵的构造
row_inv_hex = {'0e' '0b' '0d' '09'};% 与列混淆矩阵第一行点乘，乘积为1
row_inv = hex2dec(row_inv_hex)';
rows_inv = repmat(row_inv,4,1);
MC_mat_inv = cycle(rows_inv,'right');%向右循环移位
end

