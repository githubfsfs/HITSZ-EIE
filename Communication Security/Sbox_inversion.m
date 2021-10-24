function Sbox_inv = Sbox_inversion(Sbox)
% 函数功能：生成S盒子的逆
    for i = 1:256
        Sbox_inv(Sbox(i)+1) = i-1;
    end
end

