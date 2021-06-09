function Md = BlockCodeCorrect(G,R)
%UNTITLED2 此处显示有关此函数的摘要
%% (7,4)理论
[lens,lenn] = size(G)%每段待编码消息码组长度lens 以及映射后码长lenn
lenm = lenn - lens%监督码码长
P = G(:,lens+1:end)
Ih = eye(lenm)
H = [P',Ih]%检验矩阵
HT = H';% H的转置矩阵

%% 找出出错的位置
S = rem(R*H',2);%伴随式
lenb = size(S,1);%分组码的块数
error = zeros(lenb,lenn);
for j = 1:lenb
    for i = 1:lenn
        if S(j,:) == HT(i,:) %即出错的位置
            error(j,i) = 1%错误位点
%             break
        end
    end
end
Ee = error%估计的错误图样


% disp(['第',num2str(error),'位出现错误'])
Rc = rem(R+Ee,2)%经过纠错的接收序列
Md = Rc(:,1:lens)%译码序列，即去掉监督码元即可
Md = reshape(Md',1,[]);%
end

