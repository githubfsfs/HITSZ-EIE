% 180210316     �̾���

sys = tf([1 2],[1 2 1])     %����ϵͳ����
t = 0:0.1:10;               %����
y = exp(-2.*t);             %�����ź�y
lsim(sys,y,t)               %�������ź�Ϊy����ϵͳ����sys���
hold on  
q = lsim(sys,y,t)             
plot(t,y)
plot(t,q)
legend('input data','filtered data')