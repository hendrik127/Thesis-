function FF6 = F6(x)

T=6;
%total social cost
CSL=0.2+0.45+0.75;
%distance of the supplier i from the factory di

d=[744, 564, 644, 432,159,95];%,81,286,186,186,186,186,186,1094,336,336,336,370,370];(this was the remainder in the reference paper)

%distance between factory and distribution center dpj
    
dp=[212; 640];

%dDjk Distance between distribution center j from customer k


dD=[7 4.3 0 0; 0 0 42.1 21];

%ai Unit cost of carrying raw materials from supplier i to factory in period t
a=[697 589 639 602 320 90];% 205 450 371 371 371 371 371 805 475 476 476 476 476];
%bb Unit cost of carrying product from factory to distribution center j in period
bb=[371 639];
%gamma Unit cost of carrying product from distribution center j to customer k in period t
gamma=0.00003;
%inflaction rate
lambda=0.02;
%Ce Cost of CO2 emissions
Ce=0.09;
%et Amount of greenhouse gases (GHG) emissions from fuel per unit consumed
et=0.1008414;
%CSL External (Social & environmental) cost of transportation
%G Required fuel volume per trip
G=75;
%Vr Weight of raw material r
Vr=10;%in the reference paper it appears 10 in the text and 1 in the Table
%vector depending on lambda
ll=zeros(T,1);
ll(1)=1;
for i=2:T
    ll(i)=(1+lambda)^(i-1);
end

B=[x(1) x(2) x(3) x(4) x(5) x(6);
    x(7) x(8) x(9) x(10) x(11) x(12);
    x(13) x(14) x(15) x(16) x(17) x(18);
    x(19) x(20) x(21) x(22) x(23) x(24);
    x(25) x(26) x(27) x(28) x(29) x(30); 
    x(31) x(32) x(33) x(34) x(35) x(36)]; 

XPD=[x(37) x(38) x(39) x(40) x(41) x(42);
 x(43) x(44) x(45) x(46) x(47) x(48)];

%total transportation cost


F6a = Vr*a*diag(d)*B*ll +bb*diag(dp)*XPD*ll;
m=2;

XDC1=[ x(55) x(56) x(57) x(58) x(59) x(60);
       x(61) x(62) x(63) x(64) x(65) x(66);
       x(67) x(68) x(69) x(70) x(71) x(72);
       x(73) x(74) x(75) x(76) x(77) x(78);];

XDC2=[x(79) x(80) x(81) x(82) x(83) x(84); 
      x(85) x(86) x(87) x(88) x(89) x(90);
      x(91) x(92) x(93) x(94) x(95) x(96);
      x(97) x(98) x(99) x(100) x(101) x(102);];
gam=0.00003;
gm=gam*ones(1,m);

F6b= gm*dD*(XDC1+XDC2)*ll;


FF6 = (1 + CSL + G*et*Ce)*(F6a + F6b);




