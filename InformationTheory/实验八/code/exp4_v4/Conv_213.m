function [c] = Conv_213(M)
% ʵ�֣�2��1��3�������
% M����Ϣ����
% M = [1 0 1 1 ];
g0 = [1 0 1];%����ʸ��
g1 = [1 1 1];
% c = ones(1,2*length(M)); 
M = [M,zeros(1,3)];
c0 = conv(M,g0);
c1 = conv(M,g1);
len =  length(c0);
%% ��֯
c(1:2:2*len-1) = c0;
c(2:2:2*len) = c1;
c = mod(c,2);
c = c(1:end-4);
% while (c(end-1) ~= 0 || c(end) ~= 0)
% M = [M,0];
% c = Conv_213(M);
% end
end

%% ����������
% % �����״̬ת�ƹ�ϵ
% M = [0 1 0 0 ]
% S_now = [0 0];
% for i = 1:length(M)
%     ci0 = xor(S_now(1),M(i))
%     ci1 = xor(xor(S_now(1),M(i)),S_now(2))
%     S_now = [(S_now(2)),(M(i))]%��һ״̬
%     S_now_str = [num2str(S_now(2)),num2str(M(i))]%��һ״̬
%     S{i} = S_now_str
%     c_str{i} = [num2str(ci0),num2str(ci1)]
% end

