function [C,H] = HM74_encode(M)
    Ig = eye(4);
    lens = 4;lenm = 3;
    % lenn = lens+lenm;
    P = [1 1 0
         1 0 1;
         0 1 1;
         1 1 1];
     G = [Ig,P];
    [lens,lenn] = size(G);%ÿ�δ�������Ϣ���鳤��lens �Լ�ӳ����볤lenn
    lenm = lenn - lens;%�ල���볤
    lenx = length(M);
    x = M;
    % �ж����ɵ�������еĸ����Ƿ���4���������������в������
    if mod(lenx,lens) == 0
        %���û������
        signal = reshape(x,lens,fix(lenx/lens));%Ҫ��֤�Ǳ����������
    else %��lens��������������
        x = [x,zeros(1,(lenx/lens-fix(lenx/lens))*lens)];
        lenx = length(x);
        signal = reshape(x,lens,fix(lenx/lens));
    end
    R = signal';
    P = G(:,lens+1:end);
    Ih = eye(lenm);
    H = [P',Ih];%�������
    C = rem(R*G,2);%��������
end

% %% %--------V2--------%
% function [C,H] = HM74_encode(M)
%     Ig = eye(4);
%     lens = 4;lenm = 3;
%     P = [1 1 0
%          1 0 1;
%          0 1 1;
%          1 1 1];
%      G = [Ig,P];
%     [lens,lenn] = size(G);%ÿ�δ�������Ϣ���鳤��lens �Լ�ӳ����볤lenn
%     lenm = lenn - lens;%�ල���볤
%     P = G(:,lens+1:end);
%     Ih = eye(lenm);
%     H = [P',Ih];%�������
%     lenx = length(M);
%     x = M;
%     C = [];
%     % �ж����ɵ�������еĸ����Ƿ���4���������������в������
%     if mod(lenx,lens) ~= 0 %����
%         x = [x,zeros(1,(lenx/lens-fix(lenx/lens))*lens)];
%         lenx = length(x);
%     end
% 
%     for i = 1:length(x)/4
%         temp  = x(4*i-3 : 4*i);
%         Ci = mod(temp*G,2);
%         C = [C Ci];
%     end
% end

%% %--------V1--------%
% %% (7,4)����
% Ig = eye(4);
% lens = 4;lenm = 3;
% % lenn = lens+lenm;
% P = [1 1 0
%      1 0 1;
%      0 1 1;
%      1 1 1];
%  G = [Ig,P];
% [lens,lenn] = size(G);%ÿ�δ�������Ϣ���鳤��lens �Լ�ӳ����볤lenn
% lenm = lenn - lens;%�ල���볤
% lenx = length(M);
% x = M;
% disp('���������У�')
% disp(x);
% figure,subplot(321),stairs(x)
% axis([1 length(x) -0.5 1.5])
% title('��������')

% %% �ж����ɵ�������еĸ����Ƿ���4���������������в������
% if mod(lenx,lens) == 0
%     %���û������
%     signal = reshape(x,lens,fix(lenx/lens));%Ҫ��֤�Ǳ����������
% else %��lens��������������
%     x = [x,zeros(1,(lenx/lens-fix(lenx/lens))*lens)];
%     lenx = length(x);
%     signal = reshape(x,lens,fix(lenx/lens));
% end
% R = signal';
% P = G(:,lens+1:end);
% Ih = eye(lenm);
% H = [P',Ih];%�������
% C = rem(R*G,2);%��������
% disp('���ɾ���G:');disp(G);
% disp('У�����H:');disp(H);
% disp('����C:');disp(C);

% ���������룬˳��д�ģ�������V1�ɺ��ӡ�
% %% BPSK����
% %% BPSK����

% %% ����
% %����ͼ��
% E = zeros(size(C,1),lenn);%����ͼ��
% E(1,1) = 1;E(1,2) = 1;E(3,3) = 1;
% R = rem(E+C,2);%���յ�����
% S = rem(R*H',2);%����ʽ
% 
% %% �ҳ������λ��
% HT = H';% H��ת�þ���
% lenb = size(S,1);%������Ŀ���
% error = zeros(lenb,lenn);
% for j = 1:lenb
%     for i = 1:lenn
%         if S(j,:) == HT(i,:) %�������λ��
%             error(j,i) = 1;%����λ��
% %             break
%         end
%     end
% end
% Ee = error;%���ƵĴ���ͼ��
% 
% 
% % disp(['��',num2str(error),'λ���ִ���'])
% Rc = rem(R+Ee,2);%��������Ľ�������
% Md = Rc(:,1:lens);%�������У���ȥ���ල��Ԫ����
% 
% %% �����ʾ
% % disp(['������Ϣ����Ϊ��',num2str(M)])
% % fprintf('�� %i λ���ִ���\n�����������Ϊ��',error)
% % disp(num2str(Rc))
% % disp(['������Ϣ����Ϊ��',num2str(Md)])

