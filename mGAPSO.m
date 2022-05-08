%Measuring the GA+PSO hybrid.
T1  = zeros(1,25);
R1 = zeros(1,25);
C1 = zeros(1,25);
T2  = zeros(1,25);
R2 = zeros(1,25);
C2 = zeros(1,25);
for i=1:25
    b = tic();
    [fbest,xbest,pop] = GA();
    t = toc(b);
    T1(i) = t;
    R1(i) = fbest;
    C1(i) = broken_constraints_GA(xbest);
    
    b = tic();
    [x, fval,exitflag,output,population,scores] = PSO(pop);
    t = toc(b);
    
    T2(i) = t;
    R2(i) = multiobjective(x);
    C2(i) = broken_constraints_GA(x);

    disp(R1(i))
    disp(R2(i))
  


    
  
    
     
    
    
end
% disp(R1)
% disp(mean(R1))
% disp(std(R1));
% disp(mean(T1))
% disp(mean(C1));
% disp(C1);