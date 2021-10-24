function [Sbox,Sbox_inv] = Sbox_gen
% function [Sbox] = Sbox_gen
% 根据一定规则生成S盒及逆S盒
% 生成原理参见网络资料
    mod_pol = bin2dec('100011011');%设定用于取余的值
    inverse(1) = 0;
    for i = 1:255
        inverse(i+1) = find_inverse(i,mod_pol);%找到256内每个数的逆，这里从1开始是因为已经定义了第一个数0的逆为0。
    end
    for i = 1:256
        Sbox(i) = aff_trans(inverse(i));%对逆值进行仿射变换
    end
    Sbox_inv = Sbox_inversion(Sbox);
end

