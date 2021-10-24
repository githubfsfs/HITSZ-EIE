function state_out = mix_columns(state_in,MC_mat)
% �������ܣ�ʵ���л���
% ���������
%       state_in���������л����ľ���
%       MC_mat���л����任����
% ���������
%       state_out���л�����ľ���
    mod_pol = bin2dec('100011011');
    for col = 1:4
        for row = 1:4
            temp = 0;
            for inner = 1:4     % �Ծ����е�Ԫ�������ˣ�
                prod = poly_mult(...
                        MC_mat(row,inner),...
                        state_in(inner,col),...
                        mod_pol);
                %���ö���õĶ���ʽ�˷���ȡ�ຯ�������վ���˷������Ԫ�ؽ������
                %����ȡ�࣬�ɱ�֤���С���趨��mod_pol
                temp = bitxor(temp,prod);%�Խ���ۼ���򣨵�Ч����ͣ����õ�����������������˺�Ľ��
            end
            state_out(row,col) = temp;
        end
    end
end


