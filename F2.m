function F2 = F2(x)

XP = [x(37) x(38) x(39) x(40) x(41) x(42)];

T=6;
CMT = 0.04;
ll=zeros(T,1);
    ll(1)=1;
    for i=2:T
        ll(i)=(1+0.02)^(i-1);
    end

F2 = XP * ll * CMT;