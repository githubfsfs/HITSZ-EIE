
%% AES加解密的测试
% 初始化
[Sbox,Sbox_inv,w,poly_mat,poly_mat_inv] = init;
% 设置明文
plaintext_hex = {'00' '11' '22' '33' '44' '55' '66' '77'...
                 '88' '99' 'aa' 'bb' 'cc' 'dd' 'ee' 'ff'};
plaintext = hex2dec(plaintext_hex);% 十六进制转二进制
% 加密
ciphertext = encryption(plaintext,w,Sbox,poly_mat);
% 解密
re_plaintext = encryption_inv(ciphertext,w,Sbox_inv,poly_mat_inv);
% 怎么用表格呈现？
fprintf('明文为：');
disp(plaintext')
fprintf('密文为：');
disp(ciphertext)
fprintf('解密文为：');
disp(re_plaintext)

%% 循环移位测试
ma = 1:4;
mas = repmat(ma,4,1)
% ma1 = reshape(ma,4,4)';
out = cycle(mas,'left')
%% 多项式乘法及取余测试
% 正确的输出结果为207
% a = dec2bin(87);b = dec2bin(163);poly_mod = dec2bin(283)
[ab_moded,ab] = poly_mult(87,163,283)

%% S盒与逆S盒测试
[Sbox,Sbox_inv] = Sbox_gen;
Sbox_hex = cellstr(dec2hex(Sbox,2));
Sbox_mat = reshape(Sbox_hex,16,16)

Sbox_inv_hex = cellstr(dec2hex(Sbox_inv,2));
Sbox_inv_mat = reshape(Sbox_inv_hex,16,16)
Sbox.*Sbox_inv

%% 行移位的两种算法对比测试
% 方法一（以左移为例）
matrix_in = [   99  9   205 186
                202 83  96  112
                183 208 224 225
                4   81  231 140];
col = (0:5:15)';% 左移
row = 0:4:12;
cols = repmat(col,1,4);
rows = repmat(row,4,1);
mat = mod(rows + cols,16)+1;%要+1否？
matrix_out1 = matrix_in(mat);

% 方法二
matrix_out2(1,:) = matrix_in(1,:);
for i = 2:4
    matrix_out2(i,:) = round_shift(matrix_in(i,:),'left',i-1);
end
fprintf('方法一得到的输出矩阵：\n');
disp(matrix_out1)
fprintf('方法二得到的输出矩阵：\n');
disp(matrix_out2)

%% 列混淆用多项式生成测试
[MC_mat,MC_mat_inv] = MC_mat_gen