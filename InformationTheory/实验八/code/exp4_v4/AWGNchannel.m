function [R] = AWGNchannel(M,SNR)
% ��ԭ�źŵĻ����ϼ��ϸ�˹������
   Eb_N0 = 10 ^ (SNR / 10);%���������
   sigma = sqrt(1 / (2 * Eb_N0));
   R = M + sigma .* randn(size(M));
end

%-------�汾2--------%
% function [R] = AWGNchannel(M,SNR)
% % ��ԭ�źŵĻ����ϼ��ϸ�˹������
%    Eb_N0 = 10 ^ (SNR / 10);%���������
%    sigma = sqrt(1 / (2 * Eb_N0));
%    R = M + sigma .* randn(size(M));
% end
%-------�汾1--------%
%  noise0 = randn(size(T_HM_RANDOM_CONV));
%  T0_mean = mean(T_HM_RANDOM_CONV);
%  T0power = sum((T_HM_RANDOM_CONV-T0_mean).^2)/length(T_HM_RANDOM_CONV);%�����źŵĹ���
%  noise_var0 = T0power*10^(-snr(z)/10);%��������
%  noise0 = sqrt(noise_var0)/std(noise0).*noise0;%��������
%  R_RANDOM = T_HM_RANDOM_CONV + noise0;%δ��������

