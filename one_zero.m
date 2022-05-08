
function y = one_zero(x)
%Function that constrains a value to {0,1}
if x > 0.5
    y = 1;
else
    y = 0;
end

