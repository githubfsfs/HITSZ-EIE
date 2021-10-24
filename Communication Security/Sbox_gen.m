function [Sbox,Sbox_inv] = Sbox_gen
% function [Sbox] = Sbox_gen
% ����һ����������S�м���S��
% ����ԭ��μ���������
    mod_pol = bin2dec('100011011');%�趨����ȡ���ֵ
    inverse(1) = 0;
    for i = 1:255
        inverse(i+1) = find_inverse(i,mod_pol);%�ҵ�256��ÿ�������棬�����1��ʼ����Ϊ�Ѿ������˵�һ����0����Ϊ0��
    end
    for i = 1:256
        Sbox(i) = aff_trans(inverse(i));%����ֵ���з���任
    end
    Sbox_inv = Sbox_inversion(Sbox);
end

