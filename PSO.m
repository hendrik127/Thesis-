function [x, fval,exitflag,output,population,scores]= PSO(varargin)


%Function for the PSO

%number of variables
nvars=190;
%constraints which can have only integer values
%CON38
intcon=linspace(115,184,70);
%bounds for constraints, especially meant for integer constraints
%CON 37
lb1=zeros(1,114);
ub1=Inf*ones(1,114);
z1=zeros(1,70);
o1=ones(1,70);
lb2=zeros(1,6);
ub2=Inf*ones(1,6);

lb=[lb1,z1,lb2];
ub=[ub1,o1,ub2];


options = psooptimset();
options.ConstrBoundary = 'absorb';
options.ConstraintTolerance = 1e-3;
options.PopulationSize = 3;
options.Generations = 200;
 options.CognitiveAttraction = 0.5;
 options.SocialAttraction = 1.5 ;
  options.ConstraintTolerance = 1e-3;
 %options.PopInitRange = [0;5000] ;
 options.StallGenLimit = 200;
 %options.VelocityLimit = 1;
% Default options
options.Verbosity = 6;
%psoiterate
options.InitialPopulation = [];

disp(options)

if ~isempty(varargin)
    u0 = varargin(1);
    options.InitialPopulation = u0{1};
end




%disp(options)
%rng(0, 'twister');
[x, fval,exitflag,output,population,scores] = pso(@multiobjective,nvars,[],[],[],[],lb,ub,@PSO_SA_constraints,options);

%[x, fval,exitflag,output,population,scores] = pso(@multiobjective,nvars,[],[],[],[],lb,ub,[],options);


%disp(x);


