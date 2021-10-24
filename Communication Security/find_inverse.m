function inv = find_inverse(in,mod_pol)
% 函数功能：对于特定的余数mod_pol，在2^8的范围内，找到输入参数in的逆，使之满足 mod(in·in^(-1) , mod_pol)=1。（溢出则取余）
    for i = 1:255
        prodcut = poly_mult(in,i,mod_pol);
        if prodcut == 1
            inv = i;
            break
        end
    end
end

