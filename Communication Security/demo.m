function [] = demo()
% �������ܣ����趨�����Ľ���AES���ܣ�������
% ��ʼ��
[Sbox,Sbox_inv,w,poly_mat,poly_mat_inv] = init;
% �趨����
plaintext_hex = {'00' '11' '22' '33' '44' '55' '66' '77'...
                 '88' '99' 'aa' 'bb' 'cc' 'dd' 'ee' 'ff'};
plaintext = hex2dec(plaintext_hex);
% ����
ciphertext = encryption(plaintext,w,Sbox,poly_mat);
% ����
re_plaintext = encryption_inv(ciphertext,w,Sbox_inv,poly_mat_inv);
% ���
fprintf('����Ϊ��');
disp(plaintext')
fprintf('����Ϊ��');
disp(ciphertext)
fprintf('������Ϊ��');
disp(re_plaintext)
end

