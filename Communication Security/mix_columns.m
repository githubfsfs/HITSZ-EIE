function state_out = mix_columns(state_in,MC_mat)
% 函数功能：实现列混淆
% 输入参数：
%       state_in：待进行列混淆的矩阵
%       MC_mat：列混淆变换矩阵
% 输出参数：
%       state_out：列混淆后的矩阵
    mod_pol = bin2dec('100011011');
    for col = 1:4
        for row = 1:4
            temp = 0;
            for inner = 1:4     % 对矩阵中的元素逐个相乘，
                prod = poly_mult(...
                        MC_mat(row,inner),...
                        state_in(inner,col),...
                        mod_pol);
                %利用定义好的多项式乘法与取余函数，依照矩阵乘法对逐个元素进行相乘
                %由于取余，可保证结果小于设定的mod_pol
                temp = bitxor(temp,prod);%对结果累计异或（等效于求和），得到行向量与列向量点乘后的结果
            end
            state_out(row,col) = temp;
        end
    end
end


