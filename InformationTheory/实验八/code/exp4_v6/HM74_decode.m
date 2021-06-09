%% ------v3---------%
function [Rde] = HM74_decode(Ce_pre,H,lenx)
    lenn = 7;lens = 4;%��Ϣռ��������������
    HT = H';% H��ת�þ���
    lenb = size(Ce_pre,1);%������Ŀ���
%     Ce_pre = reshape(Ce_pre,7,[])';
    error = zeros(lenb,lenn);
    S = rem(Ce_pre*HT,2);%����ʽ

    for j = 1:lenb
        for i = 1:lenn
            if S(j,:) == HT(i,:) %�������λ��
                error(j,i) = 1;%����λ��
    %             break
            end
        end
    end
    Ee= error;%���ƵĴ���ͼ��
    Rc = rem(Ce_pre+error,2);%���������Ľ�������

    Meb = Rc(:,1:lens);%�������У���ȥ���ල��Ԫ���� 
    Me = reshape(Meb',1,[]);%��Ϊһ��
    zero_num = (lenx/lens-fix(lenx/lens))*lens;
    %����ĸ���
    Rde = Me(1:end-zero_num);
end

%-------v1--------%
% function [Rde] = HM74_decode(Ce_pre,H,lenx)
% %UNTITLED3 �˴���ʾ�йش˺�����ժҪ
% %   �˴���ʾ��ϸ˵��
%     lenn = 7;lens = 4;%��Ϣռ��������������
%     HT = H';% H��ת�þ���
%     lenb = size(Ce_pre,1);%������Ŀ���
%     error = zeros(lenb,lenn);
%     S = rem(Ce_pre*HT,2);%����ʽ
% 
%     for j = 1:lenb
%         for i = 1:lenn
%             if S(j,:) == HT(i,:) %�������λ��
%                 error(j,i) = 1;%����λ��
%     %             break
%             end
%         end
%     end
%     Ee= error;%���ƵĴ���ͼ��
%     Rc = rem(Ce_pre+error,2);%���������Ľ�������
% 
%     Meb = Rc(:,1:lens);%�������У���ȥ���ල��Ԫ���� 
%     Me = reshape(Meb',1,[]);%��Ϊһ��
%     zero_num = (lenx/lens-fix(lenx/lens))*lens;
%     %����ĸ���
%     Rde = Me(1:end-zero_num);
% end



%-------v2--------%
% % ������̫����
%     lenn = 7;lens = 4;%��Ϣռ��������������
%     HT = H';% H��ת�þ���
%     error = zeros(1,lenn);
%     Rde = [];
%     for k = 1:length(Ce_pre)/7
%         Ri = Ce_pre(k*7-6 : k*7);
%         Si = mod(Ri*HT,2);
%         %����ͼ��
%         for i = 1:lenn
%             if Si == HT(i,:) %�������λ��
%                 error(i) = 1;%����λ��
%             end
%         end    
%         Ci = rem(Ri+error , 2);
%         Ci = Ci(1:4);
%         Rde = [Rde Ci];
%     end
%     zero_num = (lenx/lens-fix(lenx/lens))*lens;
%     %����ĸ���
%     Rde = Rde(1:end-zero_num);
% end