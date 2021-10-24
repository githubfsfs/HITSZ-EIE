function w = key_expansion(key_init,Sbox,rcon)
% 函数功能：实现对密钥的扩展，将原本4×4的密钥矩阵扩展为44×4
% 输入参数：
%       key_init：初始的32位密钥
%       Sbox：S盒
%       rcon：圆常数
% 输出参数：
%       w：扩展后的密钥
    w = (reshape(key_init,4,4))';       % 按行填入，第i行代表wi
    for i = 5:44
        temp = w(i-1,:);                % 提取上一行的密钥
        if mod(i,4)==1                  % 如果对4的余数为1，则对w_(i-1)进行g变换，得到temp=g(w_(i-1))
            temp = round_shift(temp);   % 进行向左循环位移一字节
            temp = Sbox(temp+1);        % 进行S盒替换，由于MATLAB索引值要＞0，故需要temp+1。
            r = rcon(floor((i-1)/4),:); % 提取每一轮的圆常数
            temp = bitxor(temp,r);
        end
        w(i,:) = bitxor(w(i-4,:),temp)  % w_i = w_i-4?w_i-1 或者 w_i = w_i-4?g(w_i-1)
    end
end

