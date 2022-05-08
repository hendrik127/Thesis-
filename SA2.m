% -----------------------------------------------------------------  %
% Matlab Programs included the Appendix B in the book:               %
%  Xin-She Yang, Engineering Optimization: An Introduction           %
%                with Metaheuristic Applications                     %
%  Published by John Wiley & Sons, USA, July 2010                    %
%  ISBN: 978-0-470-58246-6,   Hardcover, 347 pages                   %
% -----------------------------------------------------------------  %
% Citation detail:                                                   %
% X.-S. Yang, Engineering Optimization: An Introduction with         %
% Metaheuristic Application, Wiley, USA, (2010).                     %
%                                                                    % 
% http://www.wiley.com/WileyCDA/WileyTitle/productCd-0470582464.html % 
% http://eu.wiley.com/WileyCDA/WileyTitle/productCd-0470582464.html  %
% -----------------------------------------------------------------  %
% ===== ftp://  ===== ftp://   ===== ftp:// =======================  %
% Matlab files ftp site at Wiley                                     %
% ftp://ftp.wiley.com/public/sci_tech_med/engineering_optimization   %
% ----------------------------------------------------------------   %
% Simulated Annealing for constrained optimization 
% by Xin-She Yang @ Cambridge University @2008
% Usage: sa_mincon(alpha)
function [bestsol,fmin,N]=SA2(varargin)
%Second implementation of the SA.
% Default cooling factor

 alpha=0.9; 

% Display usage
%disp('sa_mincon or [Best,fmin,N]=sa_mincon(0.8)');
% d dimensions
% Welded beam design optimization
lb1=zeros(114,1);
ub1=15000*ones(114,1);
z1=zeros(70,1);
o1=ones(70,1);
lb2=zeros(6,1);
ub2=15000*ones(6,1);

Lb=[lb1;z1;lb2];
Ub=[ub1;o1;ub2];
u0=[randi([0 10000],1,114),randi([0 1],1,70),randi([0 10000],1,6)].';
if ~isempty(varargin)
    u0 = varargin(1);
    u0 = u0{1};
end
if length(Lb) ~=length(Ub),
    disp('Simple bounds/limits are improper!');
    return
end
%% Start of the main program -----------------------------------------
d=length(Lb);        % Dimension of the problem
% Initializing parameters and settings
T_init = 1.0;        % Initial temperature
T_min =  1e-10;      % Finial stopping temperature
max_rej=500;        % Maximum number of rejections
max_run=700;         % Maximum number of runs
max_accept = 1000;    % Maximum number of accept
initial_search=100; % Initial search period 
k = 1;               % Boltzmann constant

% Initializing the counters i,j etc
i= 0; j = 0; accept = 0; totaleval = 0;
% Initializing various values
T = T_init;
E_init = multiobjective(u0);
E_old = E_init; E_new=E_old;
best=u0;  % initially guessed values
% Starting the simulated annealling
while ((T > T_min) || (j <= max_rej))
    i = i+1;
    % Check if max numbers of run/accept are met
    if (i >= max_run) || (accept >= max_accept)     
        % reset the counters
        i = 1;  accept = 1;
      % Cooling according to a cooling schedule
        T = cooling(alpha,T);  
        %disp(strcat('The best found so far =',num2str(fmin)));
    end
    
    % Function evaluations at new locations
    if totaleval<initial_search
        init_flag=1;
        ns=newsolution(u0,Lb,Ub,init_flag);
    else
        init_flag=0;
        ns=newsolution(best,Lb,Ub,init_flag);
    end
     
      totaleval=totaleval+1;
      E_new = multiobjective(ns);
    % Decide to accept the new solution
    DeltaE=E_new-E_old;
    % Accept if improved
    if (DeltaE <0)
        %disp(E_new)
        best = ns; E_old = E_new;
        accept=accept+1;   j = 0;
    end
    % Accept with a small probability if not improved
    if (DeltaE>=0 && exp(-DeltaE/(k*T))>rand )
        %disp(E_new)
        best = ns; E_old = E_new;
        accept=accept+1;
    else
        j=j+1;
    end
    % Update the estimated optimal solution
    fmin=E_old;
    
end
bestsol=best
fmin
N=totaleval
%% New solutions
function s=newsolution(u0,Lb,Ub,init_flag)
  % Either search around
if ~isempty(Lb) && init_flag==1
  s=Lb+(Ub-Lb).*rand(size(u0));
   sbits = arrayfun(@one_zero,s(115:184)); % 
   
 
   option = randsample(3,1);
 
   if option == 1
        s(115:184) = bit_exchange(sbits);
   elseif option == 2
        s(115:184) = bit_swap(sbits);
   end
 
else
  % Or local search by random walk
  s=u0+0.0001*(Ub-Lb).*randn(size(u0));
   sbits = arrayfun(@one_zero,s(115:184)); 
 
   option = randsample(3,1);
 
   if option == 1
        s(115:184) = bit_exchange(sbits);
   elseif option == 2
        s(115:184) = bit_swap(sbits);
   end
 
   
 end
s=bounds(s,Lb,Ub);
end

%% Cooling
function T=cooling(alpha,T)
T=alpha*T;
end
function ns=bounds(ns,Lb,Ub)
if ~isempty(Lb)
% Apply the lower bound
  ns_tmp=ns;
  I=ns_tmp<Lb;
  ns_tmp(I)=Lb(I);
  % Apply the upper bounds 
  J=ns_tmp>Ub;
  ns_tmp(J)=Ub(J);
% Update this new move 
  ns=ns_tmp;
else
  ns=ns;
end
end

function x = bit_exchange(x) 

    len = length(x);
    if sum(x) > 0 && sum(x) < len
        zeros = [];
        ones = [];
        for in=1:len
            if x(in) == 0
                zeros = [zeros, in];
            else
                ones = [ones, in];
            end
        end
        if length(zeros) > 1
            inx0 = randsample(zeros,1);
        else
            inx0 = zeros;
        end
            
        if length(ones) > 1
            inx1 = randsample(ones,1);
        else
            inx1 = ones;
        end

        

        x(inx0) = 1;
        x(inx1) = 0;
      
    else
        x = bit_swap(x);
    end

      
end


function x = bit_swap(x) 

      index = randsample(length(x), 1);

      if x(index) == 1
          x(index) = 0;
      else
          x(index) = 1;
      end
end



end



%% End of the program ------------------------------------------------


