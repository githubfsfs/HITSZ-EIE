function Md = BlockCodeCorrect(G,R)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%% (7,4)����
[lens,lenn] = size(G)%ÿ�δ�������Ϣ���鳤��lens �Լ�ӳ����볤lenn
lenm = lenn - lens%�ල���볤
P = G(:,lens+1:end)
Ih = eye(lenm)
H = [P',Ih]%�������
HT = H';% H��ת�þ���

%% �ҳ������λ��
S = rem(R*H',2);%����ʽ
lenb = size(S,1);%������Ŀ���
error = zeros(lenb,lenn);
for j = 1:lenb
    for i = 1:lenn
        if S(j,:) == HT(i,:) %�������λ��
            error(j,i) = 1%����λ��
%             break
        end
    end
end
Ee = error%���ƵĴ���ͼ��


% disp(['��',num2str(error),'λ���ִ���'])
Rc = rem(R+Ee,2)%��������Ľ�������
Md = Rc(:,1:lens)%�������У���ȥ���ල��Ԫ����
Md = reshape(Md',1,[]);%
end

