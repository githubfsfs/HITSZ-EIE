function [w_out] = round_shift(w_in,direction,step)
% �������ܣ�����Կwj�����������������ָ���ֽڣ��������뷽����Ĭ������ѭ��λ�ơ�
% ��ע������ÿһλ��[0~256]��ʮ��������ɣ���Ӧһ���ֽڵĳ��ȣ�8λ�������������ʸú�����wjѭ������8���ء�
if nargin==1
    w_out = w_in([2 3 4 1]);    % ���������direction����Ĭ��ѭ������
elseif nargin==2                % ���������λ�Ʋ���step��Ĭ��ֻλ��һλ
    if strcmp(direction,'left') % ����
        w_out = w_in([2 3 4 1]);
    else
        w_out = w_in([4 1 2 3]);
    end
else 
	w_out = w_in;
    if strcmp(direction,'left') % ѭ������
        while(step)             % ѭ����λ��ֱ������step����0
            w_out = w_out([2 3 4 1]);
            step = step-1;
        end
    else                        % ѭ������
        while(step)
            w_out = w_out([4 1 2 3]);
            step = step-1;
        end
    end
end

end

