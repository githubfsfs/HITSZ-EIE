function [C,H] = HM74_encode(M)
    Ig = eye(4);
    lens = 4;lenm = 3;
    % lenn = lens+lenm;
    P = [1 1 0
         1 0 1;
         0 1 1;
         1 1 1];
     G = [Ig,P];
    [lens,lenn] = size(G);%每段待编码消息码组长度lens 以及映射后码长lenn
    lenm = lenn - lens;%监督码码长
    lenx = length(M);
    x = M;
    % 判断生成的随机序列的个数是否是4的整数倍，并进行补零操作
    if mod(lenx,lens) == 0
        %如果没有余数
        signal = reshape(x,lens,fix(lenx/lens));%要保证是编码的整数倍
    else %非lens的整数倍，补零
        x = [x,zeros(1,(lenx/lens-fix(lenx/lens))*lens)];
        lenx = length(x);
        signal = reshape(x,lens,fix(lenx/lens));
    end
    R = signal';
    P = G(:,lens+1:end);
    Ih = eye(lenm);
    H = [P',Ih];%检验矩阵
    C = rem(R*G,2);%发送码组
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
%     [lens,lenn] = size(G);%每段待编码消息码组长度lens 以及映射后码长lenn
%     lenm = lenn - lens;%监督码码长
%     P = G(:,lens+1:end);
%     Ih = eye(lenm);
%     H = [P',Ih];%检验矩阵
%     lenx = length(M);
%     x = M;
%     C = [];
%     % 判断生成的随机序列的个数是否是4的整数倍，并进行补零操作
%     if mod(lenx,lens) ~= 0 %补零
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
% %% (7,4)理论
% Ig = eye(4);
% lens = 4;lenm = 3;
% % lenn = lens+lenm;
% P = [1 1 0
%      1 0 1;
%      0 1 1;
%      1 1 1];
%  G = [Ig,P];
% [lens,lenn] = size(G);%每段待编码消息码组长度lens 以及映射后码长lenn
% lenm = lenn - lens;%监督码码长
% lenx = length(M);
% x = M;
% disp('待编码序列：')
% disp(x);
% figure,subplot(321),stairs(x)
% axis([1 length(x) -0.5 1.5])
% title('编码序列')

% %% 判断生成的随机序列的个数是否是4的整数倍，并进行补零操作
% if mod(lenx,lens) == 0
%     %如果没有余数
%     signal = reshape(x,lens,fix(lenx/lens));%要保证是编码的整数倍
% else %非lens的整数倍，补零
%     x = [x,zeros(1,(lenx/lens-fix(lenx/lens))*lens)];
%     lenx = length(x);
%     signal = reshape(x,lens,fix(lenx/lens));
% end
% R = signal';
% P = G(:,lens+1:end);
% Ih = eye(lenm);
% H = [P',Ih];%检验矩阵
% C = rem(R*G,2);%发送码组
% disp('生成矩阵G:');disp(G);
% disp('校验矩阵H:');disp(H);
% disp('码字C:');disp(C);

% 下面是译码，顺便写的，如需用V1可忽视。
% %% BPSK调制
% %% BPSK译码

% %% 译码
% %错误图样
% E = zeros(size(C,1),lenn);%错误图样
% E(1,1) = 1;E(1,2) = 1;E(3,3) = 1;
% R = rem(E+C,2);%接收到码组
% S = rem(R*H',2);%伴随式
% 
% %% 找出出错的位置
% HT = H';% H的转置矩阵
% lenb = size(S,1);%分组码的块数
% error = zeros(lenb,lenn);
% for j = 1:lenb
%     for i = 1:lenn
%         if S(j,:) == HT(i,:) %即出错的位置
%             error(j,i) = 1;%错误位点
% %             break
%         end
%     end
% end
% Ee = error;%估计的错误图样
% 
% 
% % disp(['第',num2str(error),'位出现错误'])
% Rc = rem(R+Ee,2);%经过纠错的接收序列
% Md = Rc(:,1:lens);%译码序列，即去掉监督码元即可
% 
% %% 结果显示
% % disp(['发送消息序列为：',num2str(M)])
% % fprintf('第 %i 位出现错误\n改正后的序列为：',error)
% % disp(num2str(Rc))
% % disp(['译码消息序列为：',num2str(Md)])

