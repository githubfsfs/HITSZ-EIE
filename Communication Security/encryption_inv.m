function plaintext = encryption_inv(ciphertext,w,Sbox_inv,MC_mat_inv)
% 函数功能：实现AES解密
% 输入参数：
%       ciphertext：密文
%       w：密钥
%       Sbox_inv：逆S盒
%       MC_mat_inv：用于逆列混淆变换的矩阵
% 输出参数：
%       plaintext：解密后的明文
    state = reshape(ciphertext,4,4);%将密文进行重排
    %% 第一轮解密（对应第十轮加密）
    round_key = (w(41:44,:))'%密钥，根据图示需要转置后再异或
    state = bitxor(state,round_key);%轮密钥加
    state = cycle (state, 'right');%逆行移位
    state =  Sbox_inv(state + 1);%逆字节替换
    %% 二~十轮解密（对应第九~一轮加密）
    for i = 9:-1:1
        round_key = (w((1:4)+4*i,:))';%取出每一轮对应的圆常数
        state = bitxor(state,round_key);%逆轮密钥加
        state = mix_columns(state,MC_mat_inv);%逆列混淆
        state = cycle (state, 'right');%逆行移位
      	state =  Sbox_inv(state + 1);%逆字节替换
    end
    %% 轮密钥加（对应AES加密的预轮密钥加）
    round_key = (w(1:4,:))';%取出每一轮对应的圆常数
    state = bitxor(state,round_key);%逆轮密钥加
    plaintext = reshape(state,1,16);
end
