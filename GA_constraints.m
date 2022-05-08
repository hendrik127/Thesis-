function [c, ceq] = GA_constraints(x)
s=6; %number of suppliers (19 in the reference paper)
T=6; %time periods (12 in the reference paper)
m=2; %number of distribution centers
n=4; %number of customers
f=1; %number of raw materials


%Descision variables

%brit Amount of carried raw materials from supplier i to factory in period t
B=[x(1) x(2) x(3) x(4) x(5) x(6);
   x(7) x(8) x(9) x(10) x(11) x(12);
   x(13) x(14) x(15) x(16) x(17) x(18);
   x(19) x(20) x(21) x(22) x(23) x(24);
   x(25) x(26) x(27) x(28) x(29) x(30);
   x(31) x(32) x(33) x(34) x(35) x(36)]; 

%xp Number of products produced in the factory in period t
XP = [x(37) x(38) x(39) x(40) x(41) x(42)];

%XPD Number of carried products from factory to distribution center j in period t
XPD=[x(43) x(44) x(45) x(46) x(47) x(48);
     x(49) x(50) x(51) x(52) x(53) x(54)];

%XDC Number of carried products from distribution center j to customer k in period t
XDC1=[ x(55) x(56) x(57) x(58) x(59) x(60);
       x(61) x(62) x(63) x(64) x(65) x(66);
       x(67) x(68) x(69) x(70) x(71) x(72);
       x(73) x(74) x(75) x(76) x(77) x(78);];

XDC2=[x(79) x(80) x(81) x(82) x(83) x(84); 
      x(85) x(86) x(87) x(88) x(89) x(90);
      x(91) x(92) x(93) x(94) x(95) x(96);
      x(97) x(98) x(99) x(100) x(101) x(102);];

XDC = cat(3,XDC1,XDC2);



%I Amount of inventory held at distribution center j in period t
I=[x(103) x(104) x(105) x(106) x(107) x(108);
    x(109) x(110) x(111) x(112) x(113) x(114);];


 %0/1   
Z=[x(115) x(116) x(117) x(118) x(119) x(120)];
Z = arrayfun(@one_zero,Z);
 %0/1   
VJA=[x(121) x(122); 
     x(123) x(124) ];

VJA = arrayfun(@one_zero,VJA);





%jt = 2 x 6
SPD=[x(125) x(126) x(127) x(128) x(129) x(130);
     x(131) x(132) x(133) x(134) x(135) x(136)];
SPD = arrayfun(@one_zero,SPD);

%SDC=[];
SDC1=[x(137) x(138) x(139) x(140) x(141) x(142);
      x(143) x(144) x(145) x(146) x(147) x(148);
      x(149) x(150) x(151) x(152) x(153) x(154);
      x(155) x(156) x(157) x(158) x(159) x(160) ];

SDC2=[x(161) x(162) x(163) x(164) x(165) x(166);
      x(167) x(168) x(169) x(170) x(171) x(172);
      x(173) x(174) x(175) x(176) x(177) x(178);
      x(179) x(180) x(181) x(182) x(183) x(184) ];

SDC = cat(3,SDC1,SDC2);

SDC = arrayfun(@one_zero,SDC);

P=[x(185) x(186) x(187) x(188) x(189) x(190)];


%CONSTRAINTS

%CON 24 EQ
%Demands of customers 4x6
DKT = [ 3663 5752 5246 5295 6573 6409;
        309 255 458 521 588 565;
        561 1260 1466 1352 1453 1240;
        902 1035 1172 1089 1409 1260 ; ];

con24=zeros(n,T);



for k=1:n
    for t=1:T
        sum=0;
        for j=1:m
            sum=sum+XDC(k,t,j);
        end
        con24(k,t) = sum - DKT(k,t);
    end
end


%CON 24 

%CON 25 EQ
con25=zeros(m,T);

for j=1:m
    for t=2:T
        sumXDC = 0;
        for k=1:n
            sumXDC=sumXDC+XDC(k,t,j);
        end
        con25(j,t) = I(j,t)  -   (I(j,t-1) + XPD(j,t) - sumXDC);
    end
end

%CON 25 EQ

%CON 26 
con26a= zeros(m,T);
con26b= zeros(m,T);

CAPDCj = 5000;

for j=1:m
    for t=2:T
        con26a(j,t) = 0 - I(j,t);
    end
end

for j=1:m
    for t=2:T
        con26b(j,t) =  I(j,t) - CAPDCj;
    end
end

%CON 26 

%CON 27
con27= zeros(1,T);
CAPP=15000;
for t=1:T
    con27(1,t)= XP(t) - CAPP;
end
%CON 27

%CON 28
Vr=10;
CAPS=[30000; 15000; 17000; 8000; 23000; 26000];
con28= zeros(s,T);

for i=1:s
    for t=1:T
        con28(j,t) =  (Vr * B(j,t)) - (Z(i) * CAPS(i));
    end
end


%CON 28

%CON 29 eq
con29= zeros(1,T);
Ur=10;
ysri= [0.01 0.02 0.03 0.05 0 0.04];
for t=1:T
    sumB=0;
    for i=1:s
        sumB=sumB + B(i,t)*ysri(i);
    end
    con29(t) =  (Ur*XP(T)) - sumB ;
end

%CON 29

%CON30 eq
con30=zeros(1,s);
for j=1:m
    sumVJ = 0;
    for a=1:2
        sumVJ=VJA(j, a) + sumVJ;
    end
    con30(j) = sumVJ - 1;
end


%CON30

%CON31
% con31=zeros(1,s);
% sum=0;
% for i=1:s
%    con31(i) = 0 - Z(i);
% end

% con31b=zeros(1,s);
% for i=1:s
%     con31b(i) = Z(i) - s;
% end
%CON31

%CON32

con32=zeros(n,T,m);

UDC=12000;

for j=1:m
    for k=1:n
        for t=1:T
            con32(k,t,j) = XDC(k,t,j) - UDC * SDC(k,t,j);
        end
    end
end


%CON32


%CON33

con33=zeros(n,T,m);

LDC=100;

for j=1:m
    for k=1:n
        for t=1:T
            con33(k,t,j) =  LDC * SDC(k,t,j) - XDC(k,t,j); 
        end
    end
end


%CON33


%CON34

con34 = zeros(m,T);
UPD=12000;

for j=1:m
    for t=1:T
        con34(j,t) = XPD(j,t) - UPD * SPD(j,t);
    end
end
%CON34

%CON35
LPD=1000;

con35 = zeros(m,T);


for j=1:m
    for t=1:T
        con35(j,t) = LPD * SPD(j,t) - XPD(j,t); 
    end
end
%CON35


%CON36
con36a= zeros(1,T);
CP0=0.15;
P0=2.4;
CP =  [0.011 0.0116 0.0116 0.011 0.0112 0.0113 ];
for t=1:T
    con36a(t) = CP(t) * P0 / CP0 - P(t);
end


con36b= zeros(1,T);

for t=1:T
    con36b(t) =  P(t) - P0;
end
%CON36


%CON37 & 38 are about the range of some variables and parameters.
tol = 1;




 ceq= [];
 c = [reshape(con24-tol.',1,[]),...
     reshape(-con24-tol.',1,[]),...
     reshape(con25-tol.',1,[]),...
     reshape(-con25-tol.',1,[]),...
      reshape(con26a.',1,[]),...
     reshape(con26b.',1,[]),...
     con27 ,...
     reshape(con28.',1,[]),...
     con29,...
     con30-tol,...
     -con30-tol,...
     reshape(con32(:,:,1).',1,[]),reshape(con32(:,:,2).',1,[]),...
     reshape(con33(:,:,1).',1,[]),reshape(con33(:,:,2).',1,[]),...
     reshape(con34.',1,[]),...
      reshape(con35.',1,[]),...     
      con36a,...
     con36b
     ];


%Used this https://se.mathworks.com/help/gads/mixed-integer-optimization.html#bs1clc2 to convert ceq to c

% 
% c = [reshape(con26a,1,m*T),reshape(con26b,1,m*T),con27,reshape(con28,1,s*T),...
%    reshape(con32(:,:,1).',1,[]),reshape(con32(:,:,2).',1,[]),...
%    reshape(con33(:,:,1).',1,[]),reshape(con33(:,:,2).',1,[]),...
%    reshape(con34.',1,[]),reshape(con35.',1,[]),con36a,con36b];
% ceq = [reshape(con24,1,n*T),reshape(con25,1,m*T),con29,con30];
% 

% % 
















