clear all;close all
N = 100000;
M = round(rand(1,N));
lenx = length(M);
%% �����
    %% ��7��4������������������
Ig = eye(4);
lens = 4;lenm = 3;
lenn = lens+lenm;

 [C_HM,H] = BlockCode(M);%�������������
 [rhm,chm] = size( C_HM );
 
%% ��֯
    %% ��7��4�����齻֯
% ��δ�������н��н�֯
Ce_HM_BLOCK = BlockInterleave(C_HM,7,4);
BlockInterleave(C_HM_block,7,4);
size_of_block = 28;
len_hm = length(C_HM(:));
num_of_block = fix(len_hm/size_of_block);%�����Ϸֿ���
mod_of_block = mod(len_hm,size_of_block);%�޷�����ʱ��������Ϊ0
Ce_HM_BLOCK = zeros(1,num_of_block*size_of_block );
% ����
C_HM_RE = reshape(C_HM,1,[]);% ����
C_HM_ZE = C_HM_RE;
if mod_of_block ~= 0 %���������Ϊ0������Ҫ����
    Ce_HM_BLOCK = zeros(1,(num_of_block+1)*size_of_block );
    C_HM_ZE = [C_HM_ZE,zeros(1,length(Ce_HM_BLOCK(:))-length(C_HM_RE(:)))];
    num_of_block = num_of_block+1;
end
% �ֿ齻֯
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
    %% ��4��7�������֯
C_CONV_I = ConvInterleave1(C_HM_RE,4,7);
    %% �����֯
N = 28;
% num_of_block = fix(lenx/N)
% mod_of_block = mod(lenx,N);
C_RANDOM_I = zeros(size(C_HM_ZE));
% ����
% C_HM_ZE = M;
rulebook = zeros(num_of_block,N);
for k = 1:num_of_block
     C_HM_block =  C_HM_ZE(1+(k-1)*N : N+(k-1)*N);
    [Ce,rule] = RandomInterleave(C_HM_block,N);
    rulebook(k,:) = rule;
    C_RANDOM_I(1+(k-1)*N : N+(k-1)*N) = Ce;
end

%% �ڱ���
    %% ��2��1��3���������
C_CONV0= Conv_213(M);
C_RANDOM= Conv_213(C_RANDOM_I);%������������
C_CONV= Conv_213(C_CONV_I);
C_BLOCK= Conv_213(Ce_HM_BLOCK);
    %% BPSK����
 % ����Ϊ1��-1��˫�������У���������
 T_HM = C_HM*2-1;%������������
 T_CONV0 =  C_CONV0*2-1;%�����������
 T0 = M*2-1;%δ��������
% δ�������н��е���
T_RANDOM = C_RANDOM*2-1;
T_CONV = C_CONV*2-1;
T_BLOCK = C_BLOCK*2-1;

% �������н��е���

 % SNR��Χ
 snr = 0:4;
 for z = 1:length(snr)
     %% ������
     % δ�������м�����
        %�����֯
     noise0 = randn(size(T_RANDOM));
     T0_mean = mean(T_RANDOM);
     T0power = sum((T_RANDOM-T0_mean).^2)/length(T_RANDOM);%�����źŵĹ���
     noise_var0 = T0power*10^(-snr(z)/10);%��������
     noise0 = sqrt(noise_var0)/std(noise0).*noise0;%��������
     R_RANDOM = T_RANDOM + noise0;%δ��������

        %�����֯
     noise0 = randn(size(T_CONV));
     T0_mean = mean(T_CONV);
     T0power = sum((T_CONV-T0_mean).^2)/length(T_CONV);%�����źŵĹ���
     noise_var0 = T0power*10^(-snr(z)/10);%��������
     noise0 = sqrt(noise_var0)/std(noise0).*noise0;%��������
     R_CONV = T_CONV + noise0;%δ��������
 
        %���齻֯
     noise0 = randn(size(T_BLOCK));
     T0_mean = mean(T_BLOCK);
     T0power = sum((T_BLOCK-T0_mean).^2)/length(T_BLOCK);%�����źŵĹ���
     noise_var0 = T0power*10^(-snr(z)/10);%��������
     noise0 = sqrt(noise_var0)/std(noise0).*noise0;%��������
     R_BLOCK = T_BLOCK + noise0;%δ��������
% 
%      noise0 = randn(size(T0));
%      T0_mean = mean(T0);
%      T0power = sum((T0-T0_mean).^2)/length(T0);%�����źŵĹ���
%      noise_var0 = T0power*10^(-snr(z)/10);%��������
%      noise0 = sqrt(noise_var0)/std(noise0).*noise0;%��������
%      R0 = T0 + noise0;%δ��������

     % �������������     
     noise = randn(size(T_HM));
     T_mean = mean(T_HM);
     Tpower = sum((T_HM-T_mean).^2)/length(T_HM);%�����źŵĹ���
     noise_var = Tpower*10^(-snr(z)/10);%��������
     noise = sqrt(noise_var/2)/std(noise).*noise;%��������
     R_HM = T_HM+noise;
     
     % ������������    
     noise = randn(size(T_CONV0));
     T_mean = mean(T_CONV0);
     Tpower = sum((T_CONV0-T_mean).^2)/length(T_CONV0);%�����źŵĹ���
     noise_var = Tpower*10^(-snr(z)/10);%��������
     noise = sqrt(noise_var/2)/std(noise).*noise;%��������
     R_CONV0 = T_CONV0+noise;     
     
%      R = awgn(T,snr(z));%�����ź�,��ʵ���������
   %% BPSK���
     %δ�������������
        % �����֯
     Re_RANDOM_I = zeros(size(R_RANDOM));
     Re_RANDOM_I(R_RANDOM>0) = 1;
     Re_RANDOM_I(R_RANDOM<=0) = 0;
        % �����֯
     Re_CONV_I = zeros(size(R_CONV));
     Re_CONV_I(R_CONV>0) = 1;
     Re_CONV_I(R_CONV<=0) = 0;
        % ���齻֯
     Re_BLOCK_I = zeros(size(R_BLOCK));
     Re_BLOCK_I(R_BLOCK>0) = 1;
     Re_BLOCK_I(R_BLOCK<=0) = 0;

%      Re0 = zeros(size(R0));
%      Re0(R0>0) = 1;
%      Re0(R0<=0) = 0;
     
     %�������������
     Re_HM = zeros(size(R_HM));
     Re_HM(R_HM>0) = 1;
     Re_HM(R_HM<=0) = 0;

     %�������������
     Re_CONV = zeros(size(R_CONV0));
     Re_CONV(R_CONV0>0) = 1;
     Re_CONV(R_CONV0<=0) = 0;     
    
   %% �ŵ�����
   % ������
    % ���������
    g0 = [1 0 1];%����ʸ��
    g1 = [1 1 1];
    g = [g0;g1];%����ʸ������
    Me_CONV = conv_decode(g,1,[Re_CONV,zeros(1,4)]);%����������
    Me_CONV_I = conv_decode(g,1,Re_CONV_I);%����������
    Me_RANDOM_I = conv_decode(g,1,Re_RANDOM_I);%����������
    Me_BLOCK_I = conv_decode(g,1,Re_BLOCK_I);%����������
    
%     Me_CONV = Me_CONV(Me_CONV);%����������

%% ȥ��֯��
lenr = length(Me_RANDOM_I);
num_of_block = fix(lenr/N);%�ܹ�����
% mod_of_block = mod(lenr,N);
% C_RANDOM_I = zeros(size(C_HM_ZE));
% ����
% C_HM_ZE = M;

    % �����֯ȥ��֯
Me_RANDOM = zeros(size(Me_RANDOM_I));
% R_HM_block = 0;
for k = 1:num_of_block
    R_HM_block = Me_RANDOM_I(1+(k-1)*N : N+(k-1)*N);
    temp = deRandomInterleave(R_HM_block,rulebook(k,:));
    Me_RANDOM(1+(k-1)*N : N+(k-1)*N) = temp;
end
    
    % �����֯ȥ��֯
Me_CONV = deConvInterleave1(C_HM_RE,Me_CONV_I,4,7);

    % �ֿ齻֯ȥ��֯
Me_BLOCK = zeros(size(Me_BLOCK_I));
for k = 1:num_of_block
    R_HM_block = Me_BLOCK_I(1+(k-1)*N : N+(k-1)*N);
    temp = deBlockInterleave(R_HM_block,7,4);
    Me_BLOCK(1+(k-1)*N : N+(k-1)*N) = temp;
end

    %% ����������
    % ����
    Me_RANDOM = Me_RANDOM(1:rhm*7);%ȥ����֯��ӵ�0
    mod0 = mod(length(Me_RANDOM),7);
    if mod0 ~= 0
        temp = fix(length(Me_RANDOM)/7)+1;
        temp1 = mod(length(Me_RANDOM),temp);%������ĸ���
        Me_RANDOM = [Me_RANDOM,zeros(1,temp-temp1)];
    end

    Me_BLOCK = Me_BLOCK(1:rhm*7);%ȥ����֯��ӵ�0
    mod0 = mod(length(Me_BLOCK),7);
    if mod0 ~= 0
        temp = fix(length(Me_BLOCK)/7)+1;
        temp1 = mod(length(Me_BLOCK),temp);%������ĸ���
        Me_BLOCK = [Me_BLOCK,zeros(1,temp-temp1)];
    end
    
    Me_CONV = Me_CONV(1:rhm*7);%ȥ����֯��ӵ�0
    mod0 = mod(length(Me_CONV),7);
    if mod0 ~= 0
        temp = fix(length(Me_CONV)/7)+1;
        temp1 = mod(length(Me_CONV),temp);%������ĸ���
        Me_CONV = [Me_CONV,zeros(1,temp-temp1)];
    end
    
    Me_CONV_de = reshape(Me_CONV,[],7);
    Me_RANDOM_de = reshape(Me_RANDOM,[],7);
    Me_BLOCK_de = reshape(Me_BLOCK,[],7);

    HT = H';% H��ת�þ���
    lenb = size(Me_CONV_de,1);%������Ŀ���
    error_HM_CONV = zeros(lenb,lenn);
    S = rem(Me_CONV_de*HT,2);%����ʽ

    for j = 1:lenb
        for i = 1:lenn
            if S(j,:) == HT(i,:) %�������λ��
                error_HM_CONV(j,i) = 1;%����λ��
    %             break
            end
        end
    end
    Ee_HM_CONV = error_HM_CONV;%���ƵĴ���ͼ��
    Rc_HM_CONV = rem(Me_CONV_de+Ee_HM_CONV,2);%���������Ľ�������

    Meb = Rc_HM_CONV(:,1:lens);%�������У���ȥ���ල��Ԫ���� 
    Me = reshape(Meb',1,[]);%��Ϊһ��
    zero_num = (lenx/lens-fix(lenx/lens))*lens;
    %����ĸ���
    Me_HM_CONV = Me(1:end-zero_num);

    %% �����֯
    lenb = size(Me_RANDOM_de,1);%������Ŀ���
    error_HM_RANDOM = zeros(lenb,lenn);
    S = rem(Me_RANDOM_de*HT,2);%����ʽ

    for j = 1:lenb
        for i = 1:lenn
            if S(j,:) == HT(i,:) %�������λ��
                error_HM_RANDOM(j,i) = 1;%����λ��
    %             break
            end
        end
    end
    Ee_HM_RANDOM = error_HM_RANDOM;%���ƵĴ���ͼ��
    Rc_HM_RANDOM = rem(Me_RANDOM_de+Ee_HM_RANDOM,2);%���������Ľ�������

    Meb = Rc_HM_RANDOM(:,1:lens);%�������У���ȥ���ල��Ԫ���� 
    Me = reshape(Meb',1,[]);%��Ϊһ��
    zero_num = (lenx/lens-fix(lenx/lens))*lens;
    %����ĸ���
    Me_HM_RANDOM = Me(1:end-zero_num);

    
    %% BLOCK
    
    % �����֯
    lenb = size(Me_BLOCK_de,1);%������Ŀ���
    error_HM_BLOCK = zeros(lenb,lenn);
    S = rem(Me_BLOCK_de*HT,2);%����ʽ

    for j = 1:lenb
        for i = 1:lenn
            if S(j,:) == HT(i,:) %�������λ��
                error_HM_BLOCK(j,i) = 1;%����λ��
    %             break
            end
        end
    end
    Ee_HM_BLOCK = error_HM_BLOCK;%���ƵĴ���ͼ��
    Rc_HM_BLOCK = rem(Me_BLOCK_de+Ee_HM_BLOCK,2);%���������Ľ�������

    Meb = Rc_HM_BLOCK(:,1:lens);%�������У���ȥ���ල��Ԫ���� 
    Me = reshape(Meb',1,[]);%��Ϊһ��
    zero_num = (lenx/lens-fix(lenx/lens))*lens;
    %����ĸ���
    Me_HM_BLOCK = Me(1:end-zero_num);
    
    %% WITHOUT
    % 
    HT = H';% H��ת�þ���
    lenb = size(Re_HM,1);%������Ŀ���
    error_HM = zeros(lenb,lenn);
    S = rem(Re_HM*HT,2);%����ʽ

    for j = 1:lenb
        for i = 1:lenn
            if S(j,:) == HT(i,:) %�������λ��
                error_HM(j,i) = 1;%����λ��
    %             break
            end
        end
    end
    Ee_HM = error_HM;%���ƵĴ���ͼ��
    Rc_HM = rem(Re_HM+Ee_HM,2);%���������Ľ�������

    % 1
    Meb = Rc_HM(:,1:lens);%�������У���ȥ���ල��Ԫ���� 
    Me = reshape(Meb',1,[]);%��Ϊһ��
    zero_num = (lenx/lens-fix(lenx/lens))*lens;
    %����ĸ���
    Me_HM = Me(1:end-zero_num);

    % ��֯



%% �����ʼ���
    % �����������  
    
    index_CONV = find(Me_CONV(1:length(M)) ~= M);
    error_len = length(index_CONV);
    pe_CONV(z) = error_len/lenx;
    

    % ������������  
    index_HM = find(Me_HM ~= M);
    error_len = length(index_HM);
    pe_HM(z) = error_len/lenx;

    % δ��������������  
    % ���齻֯Me_HM_BLOCK
    index0 = find(Me_HM_BLOCK(1:length(M)) ~= M);
    error_len0 = length(index0);
    pe_block(z) = error_len0/lenx;
    % �����֯
    index0 = find(Me_HM_CONV(1:length(M)) ~= M);
    error_len0 = length(index0);
    pe_conv(z) = error_len0/lenx;
    
    % �����֯
    index0 = find(Me_HM_RANDOM ~= M);
    error_len0 = length(index0);
    pe_random(z) = error_len0/lenx;
    
%     Me_con = Re(:,1:lens);
%     Me_con = reshape(Me_con',1,[]);%��Ϊһ��
%     zero_num = (lenx/lens-fix(lenx/lens))*lens;
%     %����ĸ���
%     Me_con = Me_con(1:end-zero_num);
%     index = find(Me_con ~= M);
%     error_len = length(index);
%     pe1(z) = error_len/lenx;
 end
 figure, semilogy(snr,pe_block,snr,pe_conv,snr,pe_random),grid on
 legend('���齻֯','�����֯','�����֯')