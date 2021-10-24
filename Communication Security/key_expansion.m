function w = key_expansion(key_init,Sbox,rcon)
% �������ܣ�ʵ�ֶ���Կ����չ����ԭ��4��4����Կ������չΪ44��4
% ���������
%       key_init����ʼ��32λ��Կ
%       Sbox��S��
%       rcon��Բ����
% ���������
%       w����չ�����Կ
    w = (reshape(key_init,4,4))';       % �������룬��i�д���wi
    for i = 5:44
        temp = w(i-1,:);                % ��ȡ��һ�е���Կ
        if mod(i,4)==1                  % �����4������Ϊ1�����w_(i-1)����g�任���õ�temp=g(w_(i-1))
            temp = round_shift(temp);   % ��������ѭ��λ��һ�ֽ�
            temp = Sbox(temp+1);        % ����S���滻������MATLAB����ֵҪ��0������Ҫtemp+1��
            r = rcon(floor((i-1)/4),:); % ��ȡÿһ�ֵ�Բ����
            temp = bitxor(temp,r);
        end
        w(i,:) = bitxor(w(i-4,:),temp)  % w_i = w_i-4?w_i-1 ���� w_i = w_i-4?g(w_i-1)
    end
end

