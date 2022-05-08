T  = zeros(1,25);
R = zeros(1,25);
C = zeros(1,25);
E = zeros(1,25);
for i=1:25
    b = tic();
    [x, fval,exitflag,output,population,scores] = PSO;
    t = toc(b);
    R(i) = fval;
    T(i) = t;
    C(i) = broken_constraints_GA(x);

end
disp(R)
disp(mean(R))
disp(std(R));
disp(mean(T))
disp(mean(C));
disp(N);
disp(C);