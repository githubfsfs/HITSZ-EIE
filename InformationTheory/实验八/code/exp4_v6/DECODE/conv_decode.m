function [ decode_output ] = conv_decode( g,k,decode_input )
% (n,k,L)���Viterbi������
%   g              n������ʸ�������γɵľ���:g = [g1;g2;...;gn]
%   k              ����λ��
%   decode_input    ��������

% Լ������N
N = size(g,2);
% �������λ��n
n = size(g,1);
% ����ͼ��״̬��
number_of_states = 2^(k*(N-1));
% �������
input = zeros(number_of_states);
% ״̬ת�ƾ���
nextstate = zeros(number_of_states,2^k);
% �������
output = zeros(number_of_states,2^k);
%%%% �Ը���״̬�������㣬�õ��������״̬ת�ƾ������������ %%%%
for s = 0:number_of_states-1    
    %��ǰһʱ��״̬����һʱ��״̬֮��ĸ���֧·��������
    for t = 0:2^k-1         
        % next_state_function���������ƴ�����ת������һ״̬����ǰʱ�̱���������
        [next_state,memory_contents] = next_state_function(s,t,N,k);
        % �������±�ʾ��ǰ״̬s0,s1,s2����
        % �������ұ�ʾ��һ״̬s0,s1,s2����
        % ����Ϊ����֧·���
        input(s+1,next_state+1) = t;                %�������
        % ����֧·�������
        branch_output = rem(memory_contents*g',2); 
        % �������±�ʾ��ǰ״̬s0,s1,s2����
        % ��������Ϊ����֧·���0,1,2����
        % ����Ϊ��һʱ��״̬s
        nextstate(s+1,t+1) = next_state;            %״̬ת�ƾ���
        % �������±�ʾ��ǰ״̬s0,s1,s2����
        % �������ұ�ʾ����֧·���0,1,2����
        % ����Ϊ��Ӧ��֧�������
        output(s+1,t+1) = bin2dec(branch_output);	%�������
    end
end
%%%%%%%%%%%%% ��ʼ���룬�õ��Ҵ�״̬���� %%%%%%%%%%%%%
% ״̬��������
% ��һ��Ϊ��ǰʱ�̸�״̬��·������
% �ڶ���Ϊ��һʱ�̸�״̬��·�������������º��״̬������
state_metric = zeros(number_of_states,2);
% �������
depth_of_trellis = length(decode_input)/n;
% depth_of_trellis = round(length(decode_input)/n);
decode_input_matrix = reshape(decode_input,n,depth_of_trellis);
% �Ҵ�״̬����
survivor_state = zeros(number_of_states,depth_of_trellis+1);
% ����״̬�ĳ�ʼ·������
for i =1:N-1
    % ����ͼ��ȫ��״̬������ֱ������״̬����·������
    for s = 0:2^(k*(N-i)):number_of_states-1
        %��ǰһʱ��״̬����һʱ��״̬֮��ĸ�����֧��������
        for t = 0:2^k-1
            % ��֧����
            branch_metric = 0;
            % ������֧�ı�������Զ�������ʽ��ʾ
            bin_output = dec2bin(output(s+1,t+1),n);
            for j = 1:n
                % ��֧�����ļ���
                branch_metric = branch_metric + metric_hard(decode_input_matrix(j,i),bin_output(j));
            end
            % ����״̬·������ֵ�ĸ���
            % ��һʱ��·������=��ǰʱ��·������+��֧����
            state_metric(nextstate(s+1,t+1)+1,2) = state_metric(s+1,1) + branch_metric;
            % �Ҵ�·���Ĵ洢
            % һά�����ʾ��һʱ��״̬
            % ��ά�����ʾ��״̬������ͼ�е���λ��
            % ����Ϊ��ǰʱ��״̬
            survivor_state(nextstate(s+1,t+1)+1,i+1) = s;
        end
    end
    % ������״̬���һ��·������ֵ�����
    % ״̬���������һ�У���ǰ״̬·��������
    % ��ڶ��У���һ״̬·���������Ի�
    % ������һʱ�̼�����������
    state_metric = state_metric(:,2:-1:1);
end
% ����״̬��·����������
for i = N:depth_of_trellis-(N-1)
    % ��¼ĳһ״̬��·�������Ƿ���¹�
    flag = zeros(1,number_of_states);
    for s = 0:number_of_states-1
       for t = 0:2^k-1
           branch_metric = 0;
           bin_output = dec2bin(output(s+1,t+1),n);
           for j = 1:n
              branch_metric = branch_metric + metric_hard(decode_input_matrix(j,i),bin_output(j));
           end
           % ��ĳ״̬��·������δ������
           % ��һ�θ��º��·���������ڱ��θ��µ�·������
           % ����и�״̬·������ֵ�ĸ���
           if((state_metric(nextstate(s+1,t+1)+1,2)>state_metric(s+1,1)+branch_metric) || flag(nextstate(s+1,t+1)+1) == 0)
               state_metric(nextstate(s+1,t+1)+1,2) = state_metric(s+1,1)+ branch_metric;
               survivor_state(nextstate(s+1,t+1)+1,i+1) = s;
               % һ�θ��º�flag��Ϊ1
               flag(nextstate(s+1,t+1)+1) = 1;
           end
       end 
    end
    state_metric = state_metric(:,2:-1:1);
end
% ��β���룺����ͼ�ع�ȫ��״̬
for i = depth_of_trellis-(N-1)+1:depth_of_trellis
flag = zeros(1,number_of_states);
%��һ���ش�����״̬��
    last_stop_states = number_of_states/(2^((i-depth_of_trellis+N-2)*k));   
    % ����ͼ�ϵĸ���·�����Ҫ�ص�ͬһ��ȫ��״̬
    for s = 0:last_stop_states-1
        branch_metric = 0;
        bin_output = dec2bin(output(s+1,1),n);
        for j = 1:n
           branch_metric = branch_metric+ metric_hard(decode_input_matrix(j,i),bin_output(j));
        end
        if((state_metric(nextstate(s+1,1)+1,2) > state_metric(s+1,1)+branch_metric) || flag(nextstate(s+1,1)+1) == 0)
            state_metric(nextstate(s+1,1)+1,2) = state_metric(s+1,1)+ branch_metric;
            survivor_state(nextstate(s+1,1)+1,i+1) = s;
            flag(nextstate(s+1,1)+1) = 1;
        end
    end
    state_metric = state_metric(:,2:-1:1);
end
%%%%%% �����Ҵ�״̬����ʼ����ǰ���ݣ��õ�������� %%%%%%%
sequence = zeros(1,depth_of_trellis+1);
% ����ǰ����
for i = 1:depth_of_trellis
   sequence(1,depth_of_trellis+1-i) = survivor_state(sequence(1,depth_of_trellis+2-i)+1,depth_of_trellis+2-i);
end
% �������
decode_output_matrix = zeros(k,depth_of_trellis-N);
for i = 1:depth_of_trellis-N
    % ���������õ�����֧·���
    dec_decode_output = input(sequence(1,i)+1,sequence(1,i+1)+1);
    % ��֧·���תΪ��������Ԫ����Ϊ��Ӧ���������
    bin_decode_output = dec2bin(dec_decode_output,k);
    % ��ÿһ��֧��������������������������
    decode_output_matrix(:,i) = bin_decode_output(k:-1:1)';
end
% �������������������
decode_output = reshape(decode_output_matrix,1,k*(depth_of_trellis-N));
end
