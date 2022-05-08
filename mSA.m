T  = zeros(1,25);
R = zeros(1,25);
C = zeros(1,25);
E = zeros(1,25);
for i=1:25
    b = tic();
    [bestsol,fmin,N] = SA2;
    t = toc(b);
    R(i) = fmin;
    T(i) = t;
    C(i) = broken_constraints_GA(bestsol);
    E(i) = N;  
    disp(int2str(i)+"/25 iterations.")
end
disp(R)
disp(mean(R))
disp(std(R));
disp(mean(T))
disp(mean(C));
disp(N);
disp(C);