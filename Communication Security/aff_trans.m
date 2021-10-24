function out = aff_trans(in)
% 函数功能：实现仿射变换
% 参考资料：维基百科https://en.wikipedia.org/wiki/Rijndael_S-box
    mod_pol = bin2dec('100000001');% (257)10
    mult_pol = bin2dec('00011111');% (31)10
    add_pol = bin2dec('01100011');
    temp = poly_mult(in,mult_pol,mod_pol);
    out = bitxor(temp,add_pol);
end

