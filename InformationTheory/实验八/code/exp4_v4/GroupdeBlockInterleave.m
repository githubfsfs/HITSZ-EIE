function Cde = GroupdeBlockInterleave(Ce,m,n,zero_block)
% function：实现（m,n）分组解交织编码
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
% % function：实现（m,n）分组交织编码
% % aim:分散突发错误
% % input:
% %   C:original code
% %   m:number of rows
% %   n:number of column
% % output:
% %   Ce:encoded code
% % assumption:
% %   默认输入序列Ce是无需补零的
% % auther:Cheng Junlan
% % vision & data:v1----2021.5.31
% % vision & data:v1----2021.6.5
%     sb = m*n;% size of block
%     lenr = length(Ce);
%     nb = fix(lenr/sb);%num_of_block,能够整除
%     Cde = zeros(size(Ce));% 解交织序列
%     % 分块解交织
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


