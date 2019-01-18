function [Particles, solspace] = InitializePSO(np, F)
%initializes position of particles for given function, the solution space
%is defined here for the objective functions
%   inputs:
%       np         - number of particles
%       F          - objective function name
%   outputs:
%       Particles  - np,2 array containing the design variable values
%       solspace   - the bounds to view and initialize the objective function on

if strcmp(F,'peaks')
    solspace = [-4 4 -4 4];  
elseif strcmp(F,'parabaloid')
    solspace = [-4 4 -4 4];  
elseif strcmp(F,'Rastrigin')
    solspace = [-4 4 -4 4];  
elseif strcmp(F,'Michalewicz')
    solspace = [-4 4 -4 4];  
elseif strcmp(F,'camel')
    solspace = [-4 4 -4 4];  
elseif strcmp(F,'dropwave')
    solspace = [-4 4 -4 4];  
elseif strcmp(F,'schaffer')
    solspace = [-4 4 -4 4];  
elseif strcmp(F,'egg')
    solspace = [-4 4 -4 4];  
elseif strcmp(F,'Schwefel')
    solspace = [-500 500 -500 500];  
elseif strcmp(F,'bukin6')
    solspace = [-15 -5 -3 3];  
end
rand1 = rand(np,1);
rand2 = rand(np,1);
Particles(1:np,1) = solspace(1) + rand1*(solspace(2) - solspace(1));
Particles(1:np,2) = solspace(3) + rand2*(solspace(4) - solspace(3));
end

