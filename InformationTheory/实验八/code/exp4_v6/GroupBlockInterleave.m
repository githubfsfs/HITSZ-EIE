function [C_BLOCK,zero_block] = GroupBlockInterleave(C,m,n)
%  �κα�����û��ð������˼
% �ֿ�
    sb = m*n;% size_of_block
    len = length(C(:));% 
    nb = fix(len/sb);% num_of_block �����Ϸֿ���
    mb = mod(len,sb);% mod_of_block �޷�����ʱ��������Ϊ0
    C_BLOCK = zeros(1,nb*sb );
    % ����
    C_ZE = reshape(C',[],1)';% ����
    % ����
    zero_block = 0;%�������
    if mb ~= 0 %���������Ϊ0������Ҫ���� 
        C_BLOCK = zeros(1,(nb+1)*sb);
        C_ZE = [C_ZE,zeros(1 ,sb-mb)];%����
        zero_block = sb-mb;%�������
        nb = nb+1;%��ʱblock����Ŀ����1
    end
    % �ֿ齻֯
    for k = 1:nb
         C_HM_block =  C_ZE(1+(k-1)*sb : sb+(k-1)*sb);
        Ce = BlockInterleave(C_HM_block,m,n);%ÿ����з���
        C_BLOCK(1+(k-1)*sb : sb+(k-1)*sb) = Ce;
    end
    
    function [Ce] = BlockInterleave(C,m,n)
    %     Cz  = [C,zeros(1,m*n-length(C))];%���������У��ڷֿ�ǰ�Ѿ������˲���
        R = reshape(C,n,m)';
        Ce = reshape(R,1,[]);
    end    
end

%% -------v2-------%
% function [C_BLOCK,zero_block] = GroupBlockInterleave(C,m,n)
% %  �κα�����û��ð������˼
% % �ֿ�
%    C_BLOCK = []; sz = m * n;
%    if mod(length(C), sz) ~= 0
%       zero_block = sz - mod(length(C), sz);
%       C = [C zeros(1, zero_block)];
%    else
%       zero_block = 0;
%    end
%    
%    for i = 1: sz: length(C)-1 % �ֿ�
%       c = C(i: i+sz-1);
%       C_BLOCK = [C_BLOCK interleaver(c)];% 
%    end
%    
%    function co = interleaver(ci)
%       R  = reshape(ci, n, m);
%       co = reshape(R', 1, sz);
%    end
% end


%-----v1-----%
% function [C_BLOCK,zero_block] = GroupBlockInterleave(C,m,n)
% %  �κα�����û��ð������˼
% % �ֿ�
%     sb = m*n;% size_of_block
%     len = length(C(:));% 
%     nb = fix(len/sb);% num_of_block �����Ϸֿ���
%     mb = mod(len,sb);% mod_of_block �޷�����ʱ��������Ϊ0
%     C_BLOCK = zeros(1,nb*sb );
%     % ����
%     C_ZE = reshape(C,1,[]);% ����
%     % ����
%     zero_block = 0;%�������
%     if mb ~= 0 %���������Ϊ0������Ҫ���� 
%         C_BLOCK = zeros(1,(nb+1)*sb);
%         C_ZE = [C_ZE,zeros(1 ,sb-mb)];%����
%         zero_block = sb-mb;%�������
%         nb = nb+1;%��ʱblock����Ŀ����1
%     end
%     % �ֿ齻֯
%     for k = 1:nb
%          C_HM_block =  C_ZE(1+(k-1)*sb : sb+(k-1)*sb);
%         Ce = BlockInterleave(C_HM_block,m,n);%ÿ����з���
%         C_BLOCK(1+(k-1)*sb : sb+(k-1)*sb) = Ce;
%     end
%     
%     function [Ce] = BlockInterleave(C,m,n)
%     %     Cz  = [C,zeros(1,m*n-length(C))];%���������У��ڷֿ�ǰ�Ѿ������˲���
%         R = reshape(C,n,m)';
%         Ce = reshape(R,1,[]);
%     end    
% end
