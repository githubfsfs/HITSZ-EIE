function Sbox_inv = Sbox_inversion(Sbox)
% �������ܣ�����S���ӵ���
    for i = 1:256
        Sbox_inv(Sbox(i)+1) = i-1;
    end
end

