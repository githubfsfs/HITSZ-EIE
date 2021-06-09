function Cde = GroupdeBlockInterleave(Ce,m,n,zero_block)
% function��ʵ�֣�m,n������⽻֯����
   Cde = []; sz = m * n;
   
   for i = 1: sz: length(Ce)-1
      c = Ce(i: i+sz-1);
      Cde = [Cde deinterleaver(c)];
   end

   Cde = Cde(1: length(Cde) - zero_block);
   
   function cde = deinterleaver(ci)
      R  = reshape(ci, m, n);
      cde = reshape(R', 1, sz);
   end
end

% 
% function Cde = GroupdeBlockInterleave(Ce,m,n,zero_block)
% % function��ʵ�֣�m,n�����齻֯����
% % aim:��ɢͻ������
% % input:
% %   C:original code
% %   m:number of rows
% %   n:number of column
% % output:
% %   Ce:encoded code
% % assumption:
% %   Ĭ����������Ce�����貹���
% % auther:Cheng Junlan
% % vision & data:v1----2021.5.31
% % vision & data:v1----2021.6.5
%     sb = m*n;% size of block
%     lenr = length(Ce);
%     nb = fix(lenr/sb);%num_of_block,�ܹ�����
%     Cde = zeros(size(Ce));% �⽻֯����
%     % �ֿ�⽻֯
%     for k = 1:nb
%         C_block = Ce(1+(k-1)*sb : sb+(k-1)*sb);
%         Cde_block = deBlockInterleave(C_block,m,n);
%         Cde(1+(k-1)*sb : sb+(k-1)*sb) = Cde_block;
%     end
%     Cde = Cde(1:end-zero_block);
% end
% 
% function Cde = deBlockInterleave(Ce,m,n)
% R = reshape(Ce,m,n);
% Cde = reshape(R',length(R(:)),[])';
% end


