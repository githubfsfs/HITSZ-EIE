function [] = demo()
% 函数功能：对设定的明文进行AES加密，并解密
% 初始化
[Sbox,Sbox_inv,w,poly_mat,poly_mat_inv] = init;
% 设定明文
plaintext_hex = {'00' '11' '22' '33' '44' '55' '66' '77'...
                 '88' '99' 'aa' 'bb' 'cc' 'dd' 'ee' 'ff'};
plaintext = hex2dec(plaintext_hex);
% 加密
ciphertext = encryption(plaintext,w,Sbox,poly_mat);
% 解密
re_plaintext = encryption_inv(ciphertext,w,Sbox_inv,poly_mat_inv);
% 输出
fprintf('明文为：');
disp(plaintext')
fprintf('密文为：');
disp(ciphertext)
fprintf('解密文为：');
disp(re_plaintext)
end

