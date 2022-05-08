function y = broken_constraints(x)
%A function that measures the broken constraints.

[c, ceq] = GA_constraints(x);



% disp(c);
% disp(ceq);

y = 0;

for i=1:size(c.')
    if c(i) > 0
        y = y + 1;
    end
end

for i=1:size(ceq.')
    if abs(ceq(i)) > 0.01
        y = y + 1;
    end
end


end

