function [ab_moded,ab] = poly_mult(a,b,poly_mod)
% 实现多项式相乘取余的操作，（a·b）mod poly_mod，对于AES来说，实现在GF(2^8)内的乘法运算。
% 步骤：将多项式乘法拆解成位移相乘与异或的操作
% 输入参数：
%     a：十进制乘数1
%     b：十进制乘数2
%     poly_mod：该有限域乘法的本原多项式。
% 输出参数：
%     ab：ab的乘积
%     ab_moded：ab取模后的余数
% 备注：由于是在GF(2^8)中进行乘法运算，则乘数都必然小于2^8，即对应的二进制数的位数小于等于8位，
%       这也是为什么i=1：8。同时由于乘积的二进制位数小于16位，故i从16开始
    ab = 0;
    temp = 0;
    for i = 1:8
        if bitget(a,i)% 从低位开始取(a对应二进制数的右侧)，如果该位为1，则进入循环（相当于1·b=b），否则跳过（相当于0·b=0）
            temp = bitshift(b,i-1); % 左移i-1位，空位补零
            ab = bitxor(ab,temp);
%             ab_bin = dec2bin(ab);   % 转换成二进制用于检验是否正确
        end
    end
    % 如果发生溢出，进行多项式相除取余操作
    ab_moded = ab;  % 取余后的值
    for i = 16:-1:9 % 从高位开始取，仅
        if bitget(ab_moded,i)% 如果ab小于等于8位，则ab_moded=ab
            temp = bitshift(poly_mod,i-9);
            ab_moded = bitxor(ab_moded,temp);
%             ab_moded_bin = dec2bin(ab_moded);
        end
    end
end

