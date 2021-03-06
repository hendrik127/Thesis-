function F1 = F1(x)
    T=6;
    lambda=0.02;
    CP=[0.011 0.0116 0.0116 0.011 0.0112 0.0113];

    B=[x(1) x(2) x(3) x(4) x(5) x(6);
       x(7) x(8) x(9) x(10) x(11) x(12);
       x(13) x(14) x(15) x(16) x(17) x(18);
       x(19) x(20) x(21) x(22) x(23) x(24);
       x(25) x(26) x(27) x(28) x(29) x(30);
       x(31) x(32) x(33) x(34) x(35) x(36)]; 

    
    ll=zeros(T,1);
    ll(1)=1;
    for i=2:T
        ll(i)=(1+lambda)^(i-1);
    end
    
    F1 = CP * B * ll ;


    
   

    
    
    