function F3 = F3(x)
T=6;
hj = [0.011 0.011];
I=[x(103) x(104) x(105) x(106) x(107) x(108);
    x(109) x(110) x(111) x(112) x(113) x(114);];

ll=zeros(T,1);
    ll(1)=1;
    for i=2:T
        ll(i)=(1+0.02)^(i-1);
    end

F3 = hj * I * ll;