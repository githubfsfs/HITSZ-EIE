function ciphertext = encryption(plaintext,w,Sbox,MC_mat)
% �������ܣ�ʵ�ּ���
% ���������
%       plaintext������
%       w����Կ
%       Sbox��S��
%       MC_mat�������л����任�ľ���
% ���������
%       ciphertext������
    state = reshape(plaintext,4,4);%�����Ľ�������
%% Ԥ����Կ��
    round_key = (w(1:4,:))'%��Կ������ͼʾ��Ҫת�ú������
    state = bitxor(state,round_key);%����Կ��
    
%% һ~���ּ���
    for i = 1:9
        state =  Sbox(state + 1);%�ֽ��滻
        state = cycle (state, 'left')%����λ
        state = mix_columns(state,MC_mat)%�л���
        round_key = (w((1:4)+4*i,:))'%ȡ��ÿһ�ֶ�Ӧ��Բ����
        state = bitxor(state,round_key)%����Կ��
    end
    %% ��ʮ�֣�û���л���
    state = Sbox(state + 1);%�ֽ��滻
   	state = cycle (state, 'left');%����λ
    round_key = (w(41:44,:))';%ȡ�����һ�ֶ�Ӧ��Բ����
  	state = bitxor(state,round_key);%����Կ��
    ciphertext = reshape(state,1,16);
end
