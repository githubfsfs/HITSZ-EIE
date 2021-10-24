function [w_out] = round_shift(w_in,direction,step)
% 函数功能：现密钥wj向量向左或者向右移指定字节，若无输入方向，则默认向左循环位移。
% 备注：由于每一位是[0~256]的十进制数组成，对应一个字节的长度（8位二进制数）。故该函数将wj循环左移8比特。
if nargin==1
    w_out = w_in([2 3 4 1]);    % 如果不输入direction，则默认循环左移
elseif nargin==2                % 如果不输入位移步数step，默认只位移一位
    if strcmp(direction,'left') % 左移
        w_out = w_in([2 3 4 1]);
    else
        w_out = w_in([4 1 2 3]);
    end
else 
	w_out = w_in;
    if strcmp(direction,'left') % 循环左移
        while(step)             % 循环移位，直至步数step降到0
            w_out = w_out([2 3 4 1]);
            step = step-1;
        end
    else                        % 循环右移
        while(step)
            w_out = w_out([4 1 2 3]);
            step = step-1;
        end
    end
end

end

