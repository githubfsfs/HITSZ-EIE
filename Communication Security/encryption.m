function ciphertext = encryption(plaintext,w,Sbox,MC_mat)
% 函数功能：实现加密
% 输入参数：
%       plaintext：明文
%       w：密钥
%       Sbox：S盒
%       MC_mat：用于列混淆变换的矩阵
% 输出参数：
%       ciphertext：密文
    state = reshape(plaintext,4,4);%将明文进行重排
%% 预轮密钥加
    round_key = (w(1:4,:))'%密钥，根据图示需要转置后再异或
    state = bitxor(state,round_key);%轮密钥加
    
%% 一~九轮加密
    for i = 1:9
        state =  Sbox(state + 1);%字节替换
        state = cycle (state, 'left')%行移位
        state = mix_columns(state,MC_mat)%列混淆
        round_key = (w((1:4)+4*i,:))'%取出每一轮对应的圆常数
        state = bitxor(state,round_key)%轮密钥加
    end
    %% 第十轮，没有列混淆
    state = Sbox(state + 1);%字节替换
   	state = cycle (state, 'left');%行移位
    round_key = (w(41:44,:))';%取出最后一轮对应的圆常数
  	state = bitxor(state,round_key);%轮密钥加
    ciphertext = reshape(state,1,16);
end
