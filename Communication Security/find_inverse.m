function inv = find_inverse(in,mod_pol)
% �������ܣ������ض�������mod_pol����2^8�ķ�Χ�ڣ��ҵ��������in���棬ʹ֮���� mod(in��in^(-1) , mod_pol)=1���������ȡ�ࣩ
    for i = 1:255
        prodcut = poly_mult(in,i,mod_pol);
        if prodcut == 1
            inv = i;
            break
        end
    end
end

