function [R] = AWGNchannel(M,SNR)
% 在原信号的基础上加上高斯白噪声
   Eb_N0 = 10 ^ (SNR / 10);%线性信噪比
   sigma = sqrt(1 / (2 * Eb_N0));
   R = M + sigma .* randn(size(M));
end

%-------版本2--------%
% function [R] = AWGNchannel(M,SNR)
% % 在原信号的基础上加上高斯白噪声
%    Eb_N0 = 10 ^ (SNR / 10);%线性信噪比
%    sigma = sqrt(1 / (2 * Eb_N0));
%    R = M + sigma .* randn(size(M));
% end
%-------版本1--------%
%  noise0 = randn(size(T_HM_RANDOM_CONV));
%  T0_mean = mean(T_HM_RANDOM_CONV);
%  T0power = sum((T_HM_RANDOM_CONV-T0_mean).^2)/length(T_HM_RANDOM_CONV);%发送信号的功率
%  noise_var0 = T0power*10^(-snr(z)/10);%噪声功率
%  noise0 = sqrt(noise_var0)/std(noise0).*noise0;%期望噪声
%  R_RANDOM = T_HM_RANDOM_CONV + noise0;%未经过编码

