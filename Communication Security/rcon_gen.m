function rcon = rcon_gen()
% �������ܣ�����Բ����rcon
    mod_pol = bin2dec('100011011');
    rcon(1) = 1;
    for i = 2:10
        rcon(i) = poly_mult(rcon(i-1),2,mod_pol);%���������һλԲ����
    end
    rcon = [rcon(:),zeros(10,3)];%�ں��油��������
end

