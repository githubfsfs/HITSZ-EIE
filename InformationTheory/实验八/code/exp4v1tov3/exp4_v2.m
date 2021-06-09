clear all;close all
N = 100000;
M = round(rand(1,N));
lenx = length(M);
%% 外编码
    %% （7，4）汉明编码块参数设置
Ig = eye(4);
lens = 4;lenm = 3;
lenn = lens+lenm;

 [C_HM,H] = BlockCode(M);%汉明码编码序列
 [rhm,chm] = size( C_HM );
 
%% 交织
    %% （7，4）分组交织
% 对未编码序列进行交织
Ce_HM_BLOCK = BlockInterleave(C_HM,7,4);
BlockInterleave(C_HM_block,7,4);
size_of_block = 28;
len_hm = length(C_HM(:));
num_of_block = fix(len_hm/size_of_block);%理论上分块数
mod_of_block = mod(len_hm,size_of_block);%无法整除时，余数不为0
Ce_HM_BLOCK = zeros(1,num_of_block*size_of_block );
% 补零
C_HM_RE = reshape(C_HM,1,[]);% 重排
C_HM_ZE = C_HM_RE;
if mod_of_block ~= 0 %如果余数不为0，则需要补零
    Ce_HM_BLOCK = zeros(1,(num_of_block+1)*size_of_block );
    C_HM_ZE = [C_HM_ZE,zeros(1,length(Ce_HM_BLOCK(:))-length(C_HM_RE(:)))];
    num_of_block = num_of_block+1;
end
% 分块交织
for k = 1:num_of_block
     C_HM_block =  C_HM_ZE(1+(k-1)*size_of_block : size_of_block+(k-1)*size_of_block);
    Ce = BlockInterleave(C_HM_block,7,4);
    Ce_HM_BLOCK(1+(k-1)*size_of_block : size_of_block+(k-1)*size_of_block) = Ce;
end
% if mod ~= 0
%     C_HM_block =  C_HM_ZE(num_of_block*size_of_block+1:end);
%     Ce = BlockInterleave(C_HM_block,7,4)
%     C_BLOCK_I(num_of_block*size_of_block+1:end) = Ce;
% end
    %% （4，7）卷积交织
C_CONV_I = ConvInterleave1(C_HM_RE,4,7);
    %% 随机交织
N = 28;
% num_of_block = fix(lenx/N)
% mod_of_block = mod(lenx,N);
C_RANDOM_I = zeros(size(C_HM_ZE));
% 补零
% C_HM_ZE = M;
rulebook = zeros(num_of_block,N);
for k = 1:num_of_block
     C_HM_block =  C_HM_ZE(1+(k-1)*N : N+(k-1)*N);
    [Ce,rule] = RandomInterleave(C_HM_block,N);
    rulebook(k,:) = rule;
    C_RANDOM_I(1+(k-1)*N : N+(k-1)*N) = Ce;
end

%% 内编码
    %% （2，1，3）卷积编码
C_CONV0= Conv_213(M);
C_RANDOM= Conv_213(C_RANDOM_I);%卷积码编码序列
C_CONV= Conv_213(C_CONV_I);
C_BLOCK= Conv_213(Ce_HM_BLOCK);
    %% BPSK调制
 % 调制为1，-1（双极性序列），并发射
 T_HM = C_HM*2-1;%汉明码编码调制
 T_CONV0 =  C_CONV0*2-1;%卷积码编码调制
 T0 = M*2-1;%未调制序列
% 未编码序列进行调制
T_RANDOM = C_RANDOM*2-1;
T_CONV = C_CONV*2-1;
T_BLOCK = C_BLOCK*2-1;

% 编码序列进行调制

 % SNR范围
 snr = 0:4;
 for z = 1:length(snr)
     %% 加噪声
     % 未编码序列加噪声
        %随机交织
     noise0 = randn(size(T_RANDOM));
     T0_mean = mean(T_RANDOM);
     T0power = sum((T_RANDOM-T0_mean).^2)/length(T_RANDOM);%发送信号的功率
     noise_var0 = T0power*10^(-snr(z)/10);%噪声功率
     noise0 = sqrt(noise_var0)/std(noise0).*noise0;%期望噪声
     R_RANDOM = T_RANDOM + noise0;%未经过编码

        %卷积交织
     noise0 = randn(size(T_CONV));
     T0_mean = mean(T_CONV);
     T0power = sum((T_CONV-T0_mean).^2)/length(T_CONV);%发送信号的功率
     noise_var0 = T0power*10^(-snr(z)/10);%噪声功率
     noise0 = sqrt(noise_var0)/std(noise0).*noise0;%期望噪声
     R_CONV = T_CONV + noise0;%未经过编码
 
        %分组交织
     noise0 = randn(size(T_BLOCK));
     T0_mean = mean(T_BLOCK);
     T0power = sum((T_BLOCK-T0_mean).^2)/length(T_BLOCK);%发送信号的功率
     noise_var0 = T0power*10^(-snr(z)/10);%噪声功率
     noise0 = sqrt(noise_var0)/std(noise0).*noise0;%期望噪声
     R_BLOCK = T_BLOCK + noise0;%未经过编码
% 
%      noise0 = randn(size(T0));
%      T0_mean = mean(T0);
%      T0power = sum((T0-T0_mean).^2)/length(T0);%发送信号的功率
%      noise_var0 = T0power*10^(-snr(z)/10);%噪声功率
%      noise0 = sqrt(noise_var0)/std(noise0).*noise0;%期望噪声
%      R0 = T0 + noise0;%未经过编码

     % 汉明码编码序列     
     noise = randn(size(T_HM));
     T_mean = mean(T_HM);
     Tpower = sum((T_HM-T_mean).^2)/length(T_HM);%发送信号的功率
     noise_var = Tpower*10^(-snr(z)/10);%噪声功率
     noise = sqrt(noise_var/2)/std(noise).*noise;%期望噪声
     R_HM = T_HM+noise;
     
     % 卷积码编码序列    
     noise = randn(size(T_CONV0));
     T_mean = mean(T_CONV0);
     Tpower = sum((T_CONV0-T_mean).^2)/length(T_CONV0);%发送信号的功率
     noise_var = Tpower*10^(-snr(z)/10);%噪声功率
     noise = sqrt(noise_var/2)/std(noise).*noise;%期望噪声
     R_CONV0 = T_CONV0+noise;     
     
%      R = awgn(T,snr(z));%接收信号,其实可以用这个
   %% BPSK解调
     %未经过编码的序列
        % 随机交织
     Re_RANDOM_I = zeros(size(R_RANDOM));
     Re_RANDOM_I(R_RANDOM>0) = 1;
     Re_RANDOM_I(R_RANDOM<=0) = 0;
        % 卷积交织
     Re_CONV_I = zeros(size(R_CONV));
     Re_CONV_I(R_CONV>0) = 1;
     Re_CONV_I(R_CONV<=0) = 0;
        % 分组交织
     Re_BLOCK_I = zeros(size(R_BLOCK));
     Re_BLOCK_I(R_BLOCK>0) = 1;
     Re_BLOCK_I(R_BLOCK<=0) = 0;

%      Re0 = zeros(size(R0));
%      Re0(R0>0) = 1;
%      Re0(R0<=0) = 0;
     
     %汉明码编码序列
     Re_HM = zeros(size(R_HM));
     Re_HM(R_HM>0) = 1;
     Re_HM(R_HM<=0) = 0;

     %汉明码编码序列
     Re_CONV = zeros(size(R_CONV0));
     Re_CONV(R_CONV0>0) = 1;
     Re_CONV(R_CONV0<=0) = 0;     
    
   %% 信道译码
   % 内译码
    % 卷积码译码
    g0 = [1 0 1];%生成矢量
    g1 = [1 1 1];
    g = [g0;g1];%生成矢量矩阵
    Me_CONV = conv_decode(g,1,[Re_CONV,zeros(1,4)]);%译码后的序列
    Me_CONV_I = conv_decode(g,1,Re_CONV_I);%译码后的序列
    Me_RANDOM_I = conv_decode(g,1,Re_RANDOM_I);%译码后的序列
    Me_BLOCK_I = conv_decode(g,1,Re_BLOCK_I);%译码后的序列
    
%     Me_CONV = Me_CONV(Me_CONV);%译码后的序列

%% 去交织器
lenr = length(Me_RANDOM_I);
num_of_block = fix(lenr/N);%能够整除
% mod_of_block = mod(lenr,N);
% C_RANDOM_I = zeros(size(C_HM_ZE));
% 补零
% C_HM_ZE = M;

    % 随机交织去交织
Me_RANDOM = zeros(size(Me_RANDOM_I));
% R_HM_block = 0;
for k = 1:num_of_block
    R_HM_block = Me_RANDOM_I(1+(k-1)*N : N+(k-1)*N);
    temp = deRandomInterleave(R_HM_block,rulebook(k,:));
    Me_RANDOM(1+(k-1)*N : N+(k-1)*N) = temp;
end
    
    % 卷积交织去交织
Me_CONV = deConvInterleave1(C_HM_RE,Me_CONV_I,4,7);

    % 分块交织去交织
Me_BLOCK = zeros(size(Me_BLOCK_I));
for k = 1:num_of_block
    R_HM_block = Me_BLOCK_I(1+(k-1)*N : N+(k-1)*N);
    temp = deBlockInterleave(R_HM_block,7,4);
    Me_BLOCK(1+(k-1)*N : N+(k-1)*N) = temp;
end

    %% 汉明码译码
    % 补零
    Me_RANDOM = Me_RANDOM(1:rhm*7);%去掉交织添加的0
    mod0 = mod(length(Me_RANDOM),7);
    if mod0 ~= 0
        temp = fix(length(Me_RANDOM)/7)+1;
        temp1 = mod(length(Me_RANDOM),temp);%多出来的个数
        Me_RANDOM = [Me_RANDOM,zeros(1,temp-temp1)];
    end

    Me_BLOCK = Me_BLOCK(1:rhm*7);%去掉交织添加的0
    mod0 = mod(length(Me_BLOCK),7);
    if mod0 ~= 0
        temp = fix(length(Me_BLOCK)/7)+1;
        temp1 = mod(length(Me_BLOCK),temp);%多出来的个数
        Me_BLOCK = [Me_BLOCK,zeros(1,temp-temp1)];
    end
    
    Me_CONV = Me_CONV(1:rhm*7);%去掉交织添加的0
    mod0 = mod(length(Me_CONV),7);
    if mod0 ~= 0
        temp = fix(length(Me_CONV)/7)+1;
        temp1 = mod(length(Me_CONV),temp);%多出来的个数
        Me_CONV = [Me_CONV,zeros(1,temp-temp1)];
    end
    
    Me_CONV_de = reshape(Me_CONV,[],7);
    Me_RANDOM_de = reshape(Me_RANDOM,[],7);
    Me_BLOCK_de = reshape(Me_BLOCK,[],7);

    HT = H';% H的转置矩阵
    lenb = size(Me_CONV_de,1);%分组码的块数
    error_HM_CONV = zeros(lenb,lenn);
    S = rem(Me_CONV_de*HT,2);%伴随式

    for j = 1:lenb
        for i = 1:lenn
            if S(j,:) == HT(i,:) %即出错的位置
                error_HM_CONV(j,i) = 1;%错误位点
    %             break
            end
        end
    end
    Ee_HM_CONV = error_HM_CONV;%估计的错误图样
    Rc_HM_CONV = rem(Me_CONV_de+Ee_HM_CONV,2);%经过纠错后的接收序列

    Meb = Rc_HM_CONV(:,1:lens);%译码序列，即去掉监督码元即可 
    Me = reshape(Meb',1,[]);%化为一串
    zero_num = (lenx/lens-fix(lenx/lens))*lens;
    %补零的个数
    Me_HM_CONV = Me(1:end-zero_num);

    %% 随机交织
    lenb = size(Me_RANDOM_de,1);%分组码的块数
    error_HM_RANDOM = zeros(lenb,lenn);
    S = rem(Me_RANDOM_de*HT,2);%伴随式

    for j = 1:lenb
        for i = 1:lenn
            if S(j,:) == HT(i,:) %即出错的位置
                error_HM_RANDOM(j,i) = 1;%错误位点
    %             break
            end
        end
    end
    Ee_HM_RANDOM = error_HM_RANDOM;%估计的错误图样
    Rc_HM_RANDOM = rem(Me_RANDOM_de+Ee_HM_RANDOM,2);%经过纠错后的接收序列

    Meb = Rc_HM_RANDOM(:,1:lens);%译码序列，即去掉监督码元即可 
    Me = reshape(Meb',1,[]);%化为一串
    zero_num = (lenx/lens-fix(lenx/lens))*lens;
    %补零的个数
    Me_HM_RANDOM = Me(1:end-zero_num);

    
    %% BLOCK
    
    % 随机交织
    lenb = size(Me_BLOCK_de,1);%分组码的块数
    error_HM_BLOCK = zeros(lenb,lenn);
    S = rem(Me_BLOCK_de*HT,2);%伴随式

    for j = 1:lenb
        for i = 1:lenn
            if S(j,:) == HT(i,:) %即出错的位置
                error_HM_BLOCK(j,i) = 1;%错误位点
    %             break
            end
        end
    end
    Ee_HM_BLOCK = error_HM_BLOCK;%估计的错误图样
    Rc_HM_BLOCK = rem(Me_BLOCK_de+Ee_HM_BLOCK,2);%经过纠错后的接收序列

    Meb = Rc_HM_BLOCK(:,1:lens);%译码序列，即去掉监督码元即可 
    Me = reshape(Meb',1,[]);%化为一串
    zero_num = (lenx/lens-fix(lenx/lens))*lens;
    %补零的个数
    Me_HM_BLOCK = Me(1:end-zero_num);
    
    %% WITHOUT
    % 
    HT = H';% H的转置矩阵
    lenb = size(Re_HM,1);%分组码的块数
    error_HM = zeros(lenb,lenn);
    S = rem(Re_HM*HT,2);%伴随式

    for j = 1:lenb
        for i = 1:lenn
            if S(j,:) == HT(i,:) %即出错的位置
                error_HM(j,i) = 1;%错误位点
    %             break
            end
        end
    end
    Ee_HM = error_HM;%估计的错误图样
    Rc_HM = rem(Re_HM+Ee_HM,2);%经过纠错后的接收序列

    % 1
    Meb = Rc_HM(:,1:lens);%译码序列，即去掉监督码元即可 
    Me = reshape(Meb',1,[]);%化为一串
    zero_num = (lenx/lens-fix(lenx/lens))*lens;
    %补零的个数
    Me_HM = Me(1:end-zero_num);

    % 交织



%% 误码率计算
    % 卷积码误码率  
    
    index_CONV = find(Me_CONV(1:length(M)) ~= M);
    error_len = length(index_CONV);
    pe_CONV(z) = error_len/lenx;
    

    % 汉明码误码率  
    index_HM = find(Me_HM ~= M);
    error_len = length(index_HM);
    pe_HM(z) = error_len/lenx;

    % 未编码序列误码率  
    % 分组交织Me_HM_BLOCK
    index0 = find(Me_HM_BLOCK(1:length(M)) ~= M);
    error_len0 = length(index0);
    pe_block(z) = error_len0/lenx;
    % 卷积交织
    index0 = find(Me_HM_CONV(1:length(M)) ~= M);
    error_len0 = length(index0);
    pe_conv(z) = error_len0/lenx;
    
    % 随机交织
    index0 = find(Me_HM_RANDOM ~= M);
    error_len0 = length(index0);
    pe_random(z) = error_len0/lenx;
    
%     Me_con = Re(:,1:lens);
%     Me_con = reshape(Me_con',1,[]);%化为一串
%     zero_num = (lenx/lens-fix(lenx/lens))*lens;
%     %补零的个数
%     Me_con = Me_con(1:end-zero_num);
%     index = find(Me_con ~= M);
%     error_len = length(index);
%     pe1(z) = error_len/lenx;
 end
 figure, semilogy(snr,pe_block,snr,pe_conv,snr,pe_random),grid on
 legend('分组交织','卷积交织','随机交织')