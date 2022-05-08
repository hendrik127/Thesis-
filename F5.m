function F5 = F5(x)
T=6;
k0=10;
kdp= 2.3; %don't know this
ll=zeros(T,1);
    ll(1)=1;
    for i=2:T
        ll(i)=(1+0.02)^(i-1);
    end

CENG = 0.01;
XP = [x(37) x(38) x(39) x(40) x(41) x(42)];

F5= CENG * (k0 + kdp) * XP * ll;