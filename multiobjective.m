function y = multiobjective(x)
%Multiobjective function made into a single objective function.

y = F1(x)+ F2(x) + F3(x) + F4(x)+ F5(x) + F6(x) + F8a(x) + F8b(x); %F7
br = broken_constraints_GA(x);

y = y * (1+br) ;%+ (br*100)^9;
% cons = [];
end