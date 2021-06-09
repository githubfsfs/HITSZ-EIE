clear all;close all
N = 1000000;
M = round(rand(1,N));
lenx = length(M);
m = 7;n = 4;%分块交织参数
%% 外编码
% （7，4）汉明编码块参数设置
Ig = eye(4);
lens = 4;lenm = 3;
lenn = lens+lenm;

 [C_HM,H] = HM74_encode(M);%汉明码编码序列
 [rhm,chm] = size( C_HM );
 
%% 交织
% （7，4）分组交织
Ce_HM_BLOCK = GroupBlockInterleave(C_HM,7,4);
% （4，7）卷积交织
C_HM_RE = reshape(C_HM,1,[]);
C_HM_CONV = ConvInterleave(C_HM_RE,4,7);
% 随机交织
N = 28;
[C_HM_RANDOM,rulebook] = GroupRandomInterleave(C_HM,N);

%% 内编码
% （2，1，3）卷积编码
C_CONV0= Conv_213(M);% 未交织序列
C_HM_RANDOM_CONV = Conv_213(C_HM_RANDOM);%卷积码编码序列
C_HM_CONV_CONV = Conv_213(C_HM_CONV);
C_HM_BLOCK_CONV = Conv_213(Ce_HM_BLOCK);

%% BPSK调制
 % 调制为1，-1（双极性序列），并发射
 T_HM = C_HM*2-1;       %汉明码编码调制
 T_CONV =  C_CONV0*2-1;%卷积码编码调制
 T0 = M*2-1;            %未调制序列
% 交织序列进行调制
T_HM_RANDOM_CONV = C_HM_RANDOM_CONV*2-1;
T_HM_CONV_CONV = C_HM_CONV_CONV*2-1;
T_HM_BLOCK_CONV = C_HM_BLOCK_CONV*2-1;

%% AWGN信道传输
 snr = 0:4;
 for z = 1:length(snr)
     % 未编码序列加噪声
     R0 = AWGNchannel(T0,snr(z));
     R_HM = AWGNchannel(T_HM,snr(z));
     R_CONV0 = AWGNchannel(T_CONV,snr(z));   
     % 交织序列加噪声
     R_HM_CONV_CONV = AWGNchannel(T_HM_CONV_CONV,snr(z));
     R_HM_BLOCK_CONV = AWGNchannel(T_HM_BLOCK_CONV,snr(z));
     R_HM_RANDOM_CONV = AWGNchannel(T_HM_RANDOM_CONV,snr(z));

%% BPSK解调
     %未经过编码的序列
     Re0 = zeros(size(R0));
     Re0(R0>0) = 1;
     Re0(R0<=0) = 0;
     
     %汉明码编码序列
     Re_HM = zeros(size(R_HM));
     Re_HM(R_HM>0) = 1;
     Re_HM(R_HM<=0) = 0;

     %卷积码编码序列
     Re_CONV = zeros(size(R_CONV0));
     Re_CONV(R_CONV0>0) = 1;
     Re_CONV(R_CONV0<=0) = 0;     
     
     % 随机交织
     Rdm_HM_RANDOM_CONV = zeros(size(R_HM_RANDOM_CONV));%demodulation
     Rdm_HM_RANDOM_CONV(R_HM_RANDOM_CONV>0) = 1;
     Rdm_HM_RANDOM_CONV(R_HM_RANDOM_CONV<=0) = 0;
     % 卷积交织
     Rdm_HM_CONV_CONV = zeros(size(R_HM_CONV_CONV));
     Rdm_HM_CONV_CONV(R_HM_CONV_CONV>0) = 1;
     Rdm_HM_CONV_CONV(R_HM_CONV_CONV<=0) = 0;
     % 分组交织
     Rdm_HM_BLOCK_CONV = zeros(size(R_HM_BLOCK_CONV));
     Rdm_HM_BLOCK_CONV(R_HM_BLOCK_CONV>0) = 1;
     Rdm_HM_BLOCK_CONV(R_HM_BLOCK_CONV<=0) = 0;

%% 内译码（卷积译码）
   % 内译码
    % 卷积码译码
    g0 = [1 0 1];%生成矢量
    g1 = [1 1 1];
    g = [g0;g1];%生成矢量矩阵
    Rde_HM_CONV0 = conv_decode(g,1,[Re_CONV,zeros(1,4)]);%译码后的序列,decode
    Rde_HM_CONV = conv_decode(g,1,Rdm_HM_CONV_CONV);%译码后的序列
    Rde_HM_RANDOM = conv_decode(g,1,Rdm_HM_RANDOM_CONV);%译码后的序列
    Rde_HM_BLOCK = conv_decode(g,1,Rdm_HM_BLOCK_CONV);%译码后的序列

%% 去交织器
    % 随机交织去交织
    Rdedi_HM_RANDOM = GroupdeRandomInterleave(Rde_HM_RANDOM,rulebook,N);

    % 卷积交织去交织
    Rdedi_HM_CONV = deConvInterleave(Rde_HM_CONV,4,7);

    % 分块交织去交织
    Rdedi_HM_BLOCK = GroupdeBlockInterleave(Rde_HM_BLOCK,m,n); %decoded & deinterleaved  GroupdeBlockInterleave(Rde_HM_BLOCK,m,n)

%% 汉明码译码
    % 预处理
    Rdedi_HM_CONV_pre = Preprocess_HM_decoded(Rdedi_HM_CONV,rhm);
    Rdedi_HM_RANDOM_pre = Preprocess_HM_decoded(Rdedi_HM_RANDOM,rhm);
    Rdedi_HM_BLOCK_pre = Preprocess_HM_decoded(Rdedi_HM_BLOCK,rhm);

    % 汉明码译码
    Me_HM = HM74_decode(Re_HM,H,lenx);
    Me_CONV = HM74_decode(Rdedi_HM_CONV_pre,H,lenx);
    Me_RANDOM = HM74_decode(Rdedi_HM_RANDOM_pre,H,lenx);
    Me_BLOCK = HM74_decode(Rdedi_HM_BLOCK_pre,H,lenx);

%% 误码率计算
    % 未编码序列误码率  
    index = find(Re0 ~= M);
    error_len = length(index);
    pe0(z) = error_len/lenx;

    % 卷积码误码率  
    index_CONV = find(Rde_HM_CONV0(1:length(M)) ~= M);
    error_len = length(index_CONV);
    pe_CONV(z) = error_len/lenx;

    % 汉明码误码率  
    index_HM = find(Me_HM ~= M);
    error_len = length(index_HM);
    pe_HM(z) = error_len/lenx;

    % 未编码序列误码率  
    % 分组交织Me_HM_BLOCK
    index0 = find(Me_BLOCK(1:length(M)) ~= M);
    error_len0 = length(index0);
    pe_block(z) = error_len0/lenx;
    % 卷积交织
    index0 = find(Me_CONV(1:length(M)) ~= M);
    error_len0 = length(index0);
    pe_conv(z) = error_len0/lenx;
    
    % 随机交织
    index0 = find(Me_RANDOM ~= M);
    error_len0 = length(index0);
    pe_random(z) = error_len0/lenx;
    
 end
 figure, semilogy(snr,pe0,snr,pe_HM,snr,pe_CONV,snr,pe_block,snr,pe_conv,snr,pe_random),grid on
axis([0 4 -inf inf])
 legend('未编码序列','汉明码编码','卷积码编码','分组交织','卷积交织','随机交织')