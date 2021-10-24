
%% AES�ӽ��ܵĲ���
% ��ʼ��
[Sbox,Sbox_inv,w,poly_mat,poly_mat_inv] = init;
% ��������
plaintext_hex = {'00' '11' '22' '33' '44' '55' '66' '77'...
                 '88' '99' 'aa' 'bb' 'cc' 'dd' 'ee' 'ff'};
plaintext = hex2dec(plaintext_hex);% ʮ������ת������
% ����
ciphertext = encryption(plaintext,w,Sbox,poly_mat);
% ����
re_plaintext = encryption_inv(ciphertext,w,Sbox_inv,poly_mat_inv);
% ��ô�ñ����֣�
fprintf('����Ϊ��');
disp(plaintext')
fprintf('����Ϊ��');
disp(ciphertext)
fprintf('������Ϊ��');
disp(re_plaintext)

%% ѭ����λ����
ma = 1:4;
mas = repmat(ma,4,1)
% ma1 = reshape(ma,4,4)';
out = cycle(mas,'left')
%% ����ʽ�˷���ȡ�����
% ��ȷ��������Ϊ207
% a = dec2bin(87);b = dec2bin(163);poly_mod = dec2bin(283)
[ab_moded,ab] = poly_mult(87,163,283)

%% S������S�в���
[Sbox,Sbox_inv] = Sbox_gen;
Sbox_hex = cellstr(dec2hex(Sbox,2));
Sbox_mat = reshape(Sbox_hex,16,16)

Sbox_inv_hex = cellstr(dec2hex(Sbox_inv,2));
Sbox_inv_mat = reshape(Sbox_inv_hex,16,16)
Sbox.*Sbox_inv

%% ����λ�������㷨�ԱȲ���
% ����һ��������Ϊ����
matrix_in = [   99  9   205 186
                202 83  96  112
                183 208 224 225
                4   81  231 140];
col = (0:5:15)';% ����
row = 0:4:12;
cols = repmat(col,1,4);
rows = repmat(row,4,1);
mat = mod(rows + cols,16)+1;%Ҫ+1��
matrix_out1 = matrix_in(mat);

% ������
matrix_out2(1,:) = matrix_in(1,:);
for i = 2:4
    matrix_out2(i,:) = round_shift(matrix_in(i,:),'left',i-1);
end
fprintf('����һ�õ����������\n');
disp(matrix_out1)
fprintf('�������õ����������\n');
disp(matrix_out2)

%% �л����ö���ʽ���ɲ���
[MC_mat,MC_mat_inv] = MC_mat_gen