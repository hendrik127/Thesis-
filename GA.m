function [fbest,xbest,pop] = GA()
%Function for the GA


%--------------------------------------------
%number of variables
numv=190;
%constraints which can have only integer values
%CON38
intcon=linspace(115,184,70);
%bounds for constraints, especially meant for integer constraints
%CON 37
lb1=zeros(114,1);
ub1=Inf*ones(114,1);
z1=zeros(70,1);
o1=ones(70,1);
lb2=zeros(6,1);
ub2=Inf*ones(6,1);

lb=[lb1;z1;lb2];
ub=[ub1;o1;ub2];

%options
%gacreationuniformint
opts = optimoptions(@ga, ...,
                    'CrossoverFraction',0.8,...
                    'PopulationSize', 300, ...
                    'MaxGenerations', 500, ...
                    'EliteCount', 20, ...
                  'PlotFcn', {@gaplotbestf},'NonlinearConstraintAlgorithm','penalty', ...
                  'MutationFcn', {@mutationpower}, 'CrossoverFcn',{@crossoverlaplace}, 'SelectionFcn',...
                     {@selectiontournament,4});
  %'EliteCount', 100, ...
%GA
%rng(0, 'twister');
%disp(opts);
disp(opts.CreationFcn)
[xbest,fbest,exitflag,output,pop,scores] = ga(@multiobjective, numv, [], [], [], [],lb, ub,@GA_constraints,intcon, opts);

%display(xbest);
%x = fbest;
%fprintf('\nCost function returned by ga = %g\n', fbest);
