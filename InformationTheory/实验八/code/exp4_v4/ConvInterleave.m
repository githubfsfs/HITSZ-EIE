function [Ce] = ConvInterleave(C,B,M)
% function��ʵ�֣�B,M�������֯����
% input:
%   C:original code
%   B:number of branch
%   M:number of shift register every unit
% output:
%   Ce:encoded code
% auther:Cheng Junlan
% vision & data:v1----2021.6.3

%%��������
% disp('��֯ǰ');
% disp(C);
len = (B-1)*M*B+length(C);%��֯���г���=�������г���+ʱ�ӳ��ȣ������֯ʱ��ΪM*B*(B-1)��
Ce = zeros(1,len);
%%��ʼ��֯
for i=1:length(C)
    group = mod(i-1,B);   %��Ҫ�ƶ�����/������
    delay = group*B*M+i;
    Ce(delay) = C(i);
end
%  disp('��֯��');
% disp(Ce);  
end

%------�汾1���������Ҹ��ӶȽϸߣ�-----%
% % vision & data:v1----2021.5.31
% len = length(C);
% 
% Cz  = [C,zeros(1,B-(len/B-fix(len/B))*B)];%����������
% % R = zeros(B,fix(length(C)/B)+(B-1)*M)
% R = zeros(B,fix(length(Cz)/B)+(B-1)*M);%����������+���ڼĴ�����������ʱ��
% 
% Ci = fliplr(reshape(Cz,B,[]));%�������
% [~,n] = size(Ci);
% for k = 1:B
% R(k,end-(k-1)*M+1-n:end-(k-1)*M) = Ci(k,:)
% end
%  % ��������㣬��ô������ᱻ��������Ч��Ϣ�������������ô��������һ����0��
%  % ��ʵ����������Ӧ��Ϊ������Ч����Ϣ��������Ҫȥ�����ڲ�������Ķ�ġ����С�
% if length(C)~=length(Cz)
%     R = R(:,2:end)%��һ��ȫ��0
% end
% Ce = reshape(fliplr(R),1,[])
