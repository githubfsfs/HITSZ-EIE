function [Re] = deBPSK(R)
% BPSK���뺯��
     Re = R;
     Re(R>0) = 1;
     Re(R<=0) = 0;   
end

