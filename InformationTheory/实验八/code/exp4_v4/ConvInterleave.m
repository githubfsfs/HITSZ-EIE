function [Ce] = ConvInterleave(C,B,M)
% function：实现（B,M）卷积交织编码
% input:
%   C:original code
%   B:number of branch
%   M:number of shift register every unit
% output:
%   Ce:encoded code
% auther:Cheng Junlan
% vision & data:v1----2021.6.3

%%输入序列
% disp('交织前');
% disp(C);
len = (B-1)*M*B+length(C);%交织序列长度=输入序列长度+时延长度（卷积交织时延为M*B*(B-1)）
Ce = zeros(1,len);
%%开始交织
for i=1:length(C)
    group = mod(i-1,B);   %需要移动的组/周期数
    delay = group*B*M+i;
    Ce(delay) = C(i);
end
%  disp('交织后');
% disp(Ce);  
end

%------版本1（理解错误且复杂度较高）-----%
% % vision & data:v1----2021.5.31
% len = length(C);
% 
% Cz  = [C,zeros(1,B-(len/B-fix(len/B))*B)];%补零后的序列
% % R = zeros(B,fix(length(C)/B)+(B-1)*M)
% R = zeros(B,fix(length(Cz)/B)+(B-1)*M);%补零后的列数+由于寄存器带来的延时列
% 
% Ci = fliplr(reshape(Cz,B,[]));%输入矩阵
% [~,n] = size(Ci);
% for k = 1:B
% R(k,end-(k-1)*M+1-n:end-(k-1)*M) = Ci(k,:)
% end
%  % 如果补过零，那么补的零会被当做“有效信息”进行输出，那么最后输出的一定是0，
%  % 但实际上最后输出应该为真正有效的信息，所以需要去掉由于补零带来的多的“零列”
% if length(C)~=length(Cz)
%     R = R(:,2:end)%第一列全是0
% end
% Ce = reshape(fliplr(R),1,[])
