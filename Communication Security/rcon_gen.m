function rcon = rcon_gen()
% 函数功能：生成圆常数rcon
    mod_pol = bin2dec('100011011');
    rcon(1) = 1;
    for i = 2:10
        rcon(i) = poly_mult(rcon(i-1),2,mod_pol);%迭代算出下一位圆常数
    end
    rcon = [rcon(:),zeros(10,3)];%在后面补三列零行
end

