function Ce_pre = Preprocess_HM_decoded(Ce,H)
%   7,4���������ǰ��Ԥ��������ȥ����֯ʱ�����㣬�Լ���Ҫ�Ĳ���
%   rhm������������ĳߴ�

%     Ce = Ce(1:rhm*7);%ȥ����֯��ӵ�0
    mod0 = mod(length(Ce),7);
    Ce_pre = Ce;
    % ����
    if mod0 ~= 0
        temp = fix(length(Ce)/7)+1;
        temp1 = mod(length(Ce),temp);%������ĸ���
        Ce_pre = [Ce,zeros(1,temp-temp1)];
    end
    Ce_pre = reshape(Ce_pre,[],7);
end

