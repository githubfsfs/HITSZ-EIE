function [pe0,pe_HM,pe_CONV,pe_block,pe_conv,pe_random] = exp4_ber(N,snr)
%--------v4----------%
% data:2021/6/7
% clear all;close all
% N = 10000;
M = round(rand(1,N));
lenx = length(M);
%% �����
% ��7��4������������������
Ig = eye(4);
lens = 4;lenm = 3;
lenn = lens+lenm;
[C_HM,H] = HM74_encode(M);%�������������

%% ��֯
% ����
m = 7;n = 4;%�ֿ齻֯����
B = 4; M0 = 7; 
N = 28;
% ��7��4�����齻֯
[C_HM_BLOCK,zero_block] = GroupBlockInterleave(C_HM,m,n);
% ��4��7�������֯
% C_HM_RE = reshape(C_HM,1,[]);
C_HM_CONV = ConvInterleave(C_HM,B,M0);
% �����֯
[C_HM_RANDOM,rule,zero_random] = GroupRandomInterleave(C_HM,N);

%% �ڱ���
% ��2��1��3���������
C_CONV0= Conv_213(M);% δ��֯����
C_HM_RANDOM_CONV = Conv_213(C_HM_RANDOM);%������������
C_HM_CONV_CONV = Conv_213(C_HM_CONV);
C_HM_BLOCK_CONV = Conv_213(C_HM_BLOCK);

%% BPSK����
 % ����Ϊ1��-1��˫�������У���������
 T_HM = C_HM*2-1;       %������������
 T_CONV =  C_CONV0*2-1;%�����������
 T0 = M*2-1;            %δ��������
% ��֯���н��е���
T_HM_RANDOM_CONV = C_HM_RANDOM_CONV*2-1;
T_HM_CONV_CONV = C_HM_CONV_CONV*2-1;
T_HM_BLOCK_CONV = C_HM_BLOCK_CONV*2-1;

%% AWGN�ŵ�����
%  snr = 0:4;
%  for z = 1:length(snr)
     % δ�������м�����
     R0 = AWGNchannel(T0,snr );
     R_HM = AWGNchannel(T_HM,snr );
     R_CONV0 = AWGNchannel(T_CONV,snr );   
     % ��֯���м�����
     R_HM_CONV_CONV = AWGNchannel(T_HM_CONV_CONV,snr );
     R_HM_BLOCK_CONV = AWGNchannel(T_HM_BLOCK_CONV,snr );
     R_HM_RANDOM_CONV = AWGNchannel(T_HM_RANDOM_CONV,snr );

%% BPSK���
     %δ�������������
     Re0 = deBPSK(R0);
     Re_HM = deBPSK(R_HM);
     Re_CONV = deBPSK(R_CONV0);
     Rdm_HM_RANDOM_CONV = deBPSK(R_HM_RANDOM_CONV);
     Rdm_HM_CONV_CONV = deBPSK(R_HM_CONV_CONV);
     Rdm_HM_BLOCK_CONV = deBPSK(R_HM_BLOCK_CONV);

%% �����루������룩
   % ������
    % ���������
    g0 = [1 0 1];%����ʸ��
    g1 = [1 1 1];
    g = [g0;g1];%����ʸ������
    Rde_CONV0 = conv_decode(g,1,Re_CONV);%����������,decode
    Rde_HM_CONV = conv_decode(g,1,Rdm_HM_CONV_CONV);%����������
    Rde_HM_RANDOM = conv_decode(g,1,Rdm_HM_RANDOM_CONV);%����������
    Rde_HM_BLOCK = conv_decode(g,1,Rdm_HM_BLOCK_CONV);%����������

%% ȥ��֯��
    % �����֯ȥ��֯
    Rdedi_HM_RANDOM = GroupdeRandomInterleave(Rde_HM_RANDOM,rule,N,zero_random);

    % �����֯ȥ��֯
    Rdedi_HM_CONV = deConvInterleave(Rde_HM_CONV,B,M0);

    % �ֿ齻֯ȥ��֯
    Rdedi_HM_BLOCK = GroupdeBlockInterleave(Rde_HM_BLOCK,m,n,zero_block); %decoded & deinterleaved  GroupdeBlockInterleave(Rde_HM_BLOCK,m,n)

%% ����������
    % Ԥ����(����)
    Rdedi_HM_CONV = reshape(Rdedi_HM_CONV,7,[])';
    Rdedi_HM_RANDOM = reshape(Rdedi_HM_RANDOM,7,[])';
    Rdedi_HM_BLOCK = reshape(Rdedi_HM_BLOCK,7,[])';

    % ����������
    Me_HM = HM74_decode(Re_HM,H,lenx);
    Me_CONV = HM74_decode(Rdedi_HM_CONV,H,lenx);
    Me_RANDOM = HM74_decode(Rdedi_HM_RANDOM,H,lenx);
    Me_BLOCK = HM74_decode(Rdedi_HM_BLOCK,H,lenx);

%% �����ʼ���
    % δ��������������  
    index = find(Re0 ~= M);
    error_len = length(index);
    pe0  = error_len/lenx;

    % �����������  
    index_CONV = find(Rde_CONV0(1:length(M)) ~= M);
    error_len = length(index_CONV);
    pe_CONV  = error_len/lenx;

    % ������������  
    index_HM = find(Me_HM ~= M);
    error_len = length(index_HM);
    pe_HM  = error_len/lenx;

    % ���齻֯Me_HM_BLOCK
    index0 = find(Me_BLOCK(1:length(M)) ~= M);
    error_len0 = length(index0);
    pe_block  = error_len0/lenx;
    % �����֯
    index0 = find(Me_CONV(1:length(M)) ~= M);
    error_len0 = length(index0);
    pe_conv  = error_len0/lenx;
    
    % �����֯
    index0 = find(Me_RANDOM ~= M);
    error_len0 = length(index0);
    pe_random  = error_len0/lenx;
end

