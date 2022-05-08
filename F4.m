function F4 = F4(x)
T=6;
Ce=0.09;
EM = 1.23; % cant find ρ EM(ρ) = 0.7ρ^2 + 0.0000004ρ + 1.23
                                %a       b            c

XP = [x(37) x(38) x(39) x(40) x(41) x(42)];
const=zeros(T,1);
    for i=1:T
        const(i)=Ce*EM;
    end

F4 = XP * const;