function [ab_moded,ab] = poly_mult(a,b,poly_mod)
% ʵ�ֶ���ʽ���ȡ��Ĳ�������a��b��mod poly_mod������AES��˵��ʵ����GF(2^8)�ڵĳ˷����㡣
% ���裺������ʽ�˷�����λ����������Ĳ���
% ���������
%     a��ʮ���Ƴ���1
%     b��ʮ���Ƴ���2
%     poly_mod����������˷��ı�ԭ����ʽ��
% ���������
%     ab��ab�ĳ˻�
%     ab_moded��abȡģ�������
% ��ע����������GF(2^8)�н��г˷����㣬���������ȻС��2^8������Ӧ�Ķ���������λ��С�ڵ���8λ��
%       ��Ҳ��Ϊʲôi=1��8��ͬʱ���ڳ˻��Ķ�����λ��С��16λ����i��16��ʼ
    ab = 0;
    temp = 0;
    for i = 1:8
        if bitget(a,i)% �ӵ�λ��ʼȡ(a��Ӧ�����������Ҳ�)�������λΪ1�������ѭ�����൱��1��b=b���������������൱��0��b=0��
            temp = bitshift(b,i-1); % ����i-1λ����λ����
            ab = bitxor(ab,temp);
%             ab_bin = dec2bin(ab);   % ת���ɶ��������ڼ����Ƿ���ȷ
        end
    end
    % ���������������ж���ʽ���ȡ�����
    ab_moded = ab;  % ȡ����ֵ
    for i = 16:-1:9 % �Ӹ�λ��ʼȡ����
        if bitget(ab_moded,i)% ���abС�ڵ���8λ����ab_moded=ab
            temp = bitshift(poly_mod,i-9);
            ab_moded = bitxor(ab_moded,temp);
%             ab_moded_bin = dec2bin(ab_moded);
        end
    end
end

