function [Re] = deBPSK(R)
% BPSK½âÂëº¯Êý
     Re = R;
     Re(R>0) = 1;
     Re(R<=0) = 0;   
end

