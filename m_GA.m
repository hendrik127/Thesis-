%Measurements for the GA.
T  = zeros(1,25);
R = zeros(1,25);
C = zeros(1,25);
for i=1:25
    b = tic();
    [f,x] = GA;
    t = toc(b);
    R(i) = f;
    T(i) = t;
    C(i) = broken_constraints_GA(x);
end
disp(R)
disp(mean(R))
disp(std(R));
disp(mean(T))
disp(mean(C));
disp(C);