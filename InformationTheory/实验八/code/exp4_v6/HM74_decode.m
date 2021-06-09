%% ------v3---------%
function [Rde] = HM74_decode(Ce_pre,H,lenx)
    lenn = 7;lens = 4;%信息占的列数和总列数
    HT = H';% H的转置矩阵
    lenb = size(Ce_pre,1);%分组码的块数
%     Ce_pre = reshape(Ce_pre,7,[])';
    error = zeros(lenb,lenn);
    S = rem(Ce_pre*HT,2);%伴随式

    for j = 1:lenb
        for i = 1:lenn
            if S(j,:) == HT(i,:) %即出错的位置
                error(j,i) = 1;%错误位点
    %             break
            end
        end
    end
    Ee= error;%估计的错误图样
    Rc = rem(Ce_pre+error,2);%经过纠错后的接收序列

    Meb = Rc(:,1:lens);%译码序列，即去掉监督码元即可 
    Me = reshape(Meb',1,[]);%化为一串
    zero_num = (lenx/lens-fix(lenx/lens))*lens;
    %补零的个数
    Rde = Me(1:end-zero_num);
end

%-------v1--------%
% function [Rde] = HM74_decode(Ce_pre,H,lenx)
% %UNTITLED3 此处显示有关此函数的摘要
% %   此处显示详细说明
%     lenn = 7;lens = 4;%信息占的列数和总列数
%     HT = H';% H的转置矩阵
%     lenb = size(Ce_pre,1);%分组码的块数
%     error = zeros(lenb,lenn);
%     S = rem(Ce_pre*HT,2);%伴随式
% 
%     for j = 1:lenb
%         for i = 1:lenn
%             if S(j,:) == HT(i,:) %即出错的位置
%                 error(j,i) = 1;%错误位点
%     %             break
%             end
%         end
%     end
%     Ee= error;%估计的错误图样
%     Rc = rem(Ce_pre+error,2);%经过纠错后的接收序列
% 
%     Meb = Rc(:,1:lens);%译码序列，即去掉监督码元即可 
%     Me = reshape(Meb',1,[]);%化为一串
%     zero_num = (lenx/lens-fix(lenx/lens))*lens;
%     %补零的个数
%     Rde = Me(1:end-zero_num);
% end



%-------v2--------%
% % 误码率太高了
%     lenn = 7;lens = 4;%信息占的列数和总列数
%     HT = H';% H的转置矩阵
%     error = zeros(1,lenn);
%     Rde = [];
%     for k = 1:length(Ce_pre)/7
%         Ri = Ce_pre(k*7-6 : k*7);
%         Si = mod(Ri*HT,2);
%         %错误图像
%         for i = 1:lenn
%             if Si == HT(i,:) %即出错的位置
%                 error(i) = 1;%错误位点
%             end
%         end    
%         Ci = rem(Ri+error , 2);
%         Ci = Ci(1:4);
%         Rde = [Rde Ci];
%     end
%     zero_num = (lenx/lens-fix(lenx/lens))*lens;
%     %补零的个数
%     Rde = Rde(1:end-zero_num);
% end