function plaintext = encryption_inv(ciphertext,w,Sbox_inv,MC_mat_inv)
% �������ܣ�ʵ��AES����
% ���������
%       ciphertext������
%       w����Կ
%       Sbox_inv����S��
%       MC_mat_inv���������л����任�ľ���
% ���������
%       plaintext�����ܺ������
    state = reshape(ciphertext,4,4);%�����Ľ�������
    %% ��һ�ֽ��ܣ���Ӧ��ʮ�ּ��ܣ�
    round_key = (w(41:44,:))'%��Կ������ͼʾ��Ҫת�ú������
    state = bitxor(state,round_key);%����Կ��
    state = cycle (state, 'right');%������λ
    state =  Sbox_inv(state + 1);%���ֽ��滻
    %% ��~ʮ�ֽ��ܣ���Ӧ�ھ�~һ�ּ��ܣ�
    for i = 9:-1:1
        round_key = (w((1:4)+4*i,:))';%ȡ��ÿһ�ֶ�Ӧ��Բ����
        state = bitxor(state,round_key);%������Կ��
        state = mix_columns(state,MC_mat_inv);%���л���
        state = cycle (state, 'right');%������λ
      	state =  Sbox_inv(state + 1);%���ֽ��滻
    end
    %% ����Կ�ӣ���ӦAES���ܵ�Ԥ����Կ�ӣ�
    round_key = (w(1:4,:))';%ȡ��ÿһ�ֶ�Ӧ��Բ����
    state = bitxor(state,round_key);%������Կ��
    plaintext = reshape(state,1,16);
end
