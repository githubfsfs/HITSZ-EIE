function [MC_mat,MC_mat_inv] = MC_mat_gen()
% �������ܣ����������л����Ķ���ʽ����

% ���л�������Ĺ���
row_hex = {'02' '03' '01' '01'};    % ��һ��
row = hex2dec(row_hex)';            % ת�ú����������
rows = repmat(row,4,1);             % ���Ƶ�һ�У�����4��4����
MC_mat = cycle(rows,'right');     % ����ѭ����λ

% ���л�������Ĺ���
row_inv_hex = {'0e' '0b' '0d' '09'};% ���л��������һ�е�ˣ��˻�Ϊ1
row_inv = hex2dec(row_inv_hex)';
rows_inv = repmat(row_inv,4,1);
MC_mat_inv = cycle(rows_inv,'right');%����ѭ����λ
end

