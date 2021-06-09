function Ce_pre = Preprocess_HM_decoded(Ce,H)
%   7,4汉明码解码前的预处理，包括去掉交织时补的零，以及必要的补零
%   rhm：汉明码编码后的尺寸

%     Ce = Ce(1:rhm*7);%去掉交织添加的0
    mod0 = mod(length(Ce),7);
    Ce_pre = Ce;
    % 补零
    if mod0 ~= 0
        temp = fix(length(Ce)/7)+1;
        temp1 = mod(length(Ce),temp);%多出来的个数
        Ce_pre = [Ce,zeros(1,temp-temp1)];
    end
    Ce_pre = reshape(Ce_pre,[],7);
end

