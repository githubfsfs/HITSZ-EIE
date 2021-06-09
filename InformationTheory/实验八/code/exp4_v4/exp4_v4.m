%--------v5----------%
% data:2021/6/7
clear all;close all
iter = 100;
N = 10;
snr = 0:4;

ber = zeros(length(snr),iter,6);
h = waitbar(0, 'iterations', ...
            'Name', 'BER simulation');
for k = 1:iter
    for snri = 0:4
        [a,b,c,d,e,f] = exp4_ber(N,snri);
        ber(snri+1,k,:) = [a,b,c,d,e,f];
    end
   waitbar(k / iter);
end

close(h)
pe = zeros(6,length(snr));

figure;
for k = 1:6
    pe(k,:) = mean(ber(:,:,k),2);
    semilogy(snr,pe(k,:),'o-');hold on
end
grid on;axis([0 4 10E-6 1])
% figure,semilogy(snr,pe(1,:),snr,pe(2,:),snr,pe(3,:),snr,pe(4,:),snr,pe(5,:),snr,pe(6,:))
 legend('未编码序列','汉明码编码','卷积码编码','分组交织','卷积交织','随机交织')
