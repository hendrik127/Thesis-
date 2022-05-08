function F7 = F7(x)
s=6;
T=6;
P0 = 2.4;
CP =  [0.011 0.0116 0.0116 0.011 0.0112 0.0113 ];
kp=200;
P=[x(185) x(186) x(187) x(188) x(189) x(190)];
CP0=0.15;
lambda=0.02;
ll=zeros(T,1);
ll(1)=1;
for i=2:T
    ll(i)=(1+lambda)^(i-1);
end



k1 = diag(-1*kp*(P-P0));

k2= diag( P/P0 - CP/CP0);

%             
F7 = s  * P  * ( k1 * k2  ) * ll;