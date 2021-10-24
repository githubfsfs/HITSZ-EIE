function [Sbox,Sbox_inv,w,MC_mat,MC_mat_inv] = init()
% 初始化函数，产生S盒与逆S盒，圆常数rcon，密钥key，用于列混淆中的多项式矩阵
%S盒与逆S盒的生成
[Sbox,Sbox_inv] = Sbox_gen;

%圆常数生成
rcon = rcon_gen;

%密钥的生成与扩展
key_init_hex = {'00' '01' '02' '03' '04' '05' '06' '07'...
                '08' '09' '0a' '0b' '0c' '0d' '0e' '0f'};
key_init = hex2dec(key_init_hex);
w = key_expansion(key_init,Sbox,rcon);

%用于列混淆的矩阵及其逆矩阵的生成
[MC_mat,MC_mat_inv] = MC_mat_gen;   % MC为MixColumns的简写，表示用于列混淆的矩阵的生成
end

