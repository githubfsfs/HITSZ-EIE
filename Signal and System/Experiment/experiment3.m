sys = tf([1 2],[1 2 1])     %产生系统函数
t = 0:0.1:10;               %步长
y = exp(-2.*t);             %输入信号y
lsim(sys,y,t)               %令输入信号为y，与系统函数sys卷积
hold on  
q = lsim(sys,y,t)             
plot(t,y)
plot(t,q)
legend('input data','filtered data')
