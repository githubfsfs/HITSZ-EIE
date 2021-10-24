function [Sbox,Sbox_inv,w,MC_mat,MC_mat_inv] = init()
% ��ʼ������������S������S�У�Բ����rcon����Կkey�������л����еĶ���ʽ����
%S������S�е�����
[Sbox,Sbox_inv] = Sbox_gen;

%Բ��������
rcon = rcon_gen;

%��Կ����������չ
key_init_hex = {'00' '01' '02' '03' '04' '05' '06' '07'...
                '08' '09' '0a' '0b' '0c' '0d' '0e' '0f'};
key_init = hex2dec(key_init_hex);
w = key_expansion(key_init,Sbox,rcon);

%�����л����ľ���������������
[MC_mat,MC_mat_inv] = MC_mat_gen;   % MCΪMixColumns�ļ�д����ʾ�����л����ľ��������
end

