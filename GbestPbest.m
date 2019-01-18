function [Pbest, Gbest, PctConv] = GbestPbest( Particles, Pbest, minIndex, Vals, NewVals, np)
%updates design variable values of global best and personal best. Calculates percent converged
%   inputs:
%       Particles  - np,2 array containing the design variable values
%       Pbest      - np,2 array of personal best values of each particle
%       minIndex   - the index of Vals containing Gbest
%       Vals       - np length column vector containing the cost of each particle
%       Vals       - np length column vector containing the cost of each particle of iteration i-1 to compare Pbest and Gbest
%       np         - number of particles
%   outputs:
%       Pbest      - np,2 array of personal best values of each particle
%       Gbest      - design variable values of Gbest
%       PctConv    - percent of particles within .1% of Gbest

Gbest = Particles(minIndex,:);
for j = 1:np
    if NewVals(j,1) < Vals(j,1)                                         %update pbest if better
        Pbest(j,:) = Particles(j,:);
    end
end
%calculate prct convergence
for i = 1:size(Particles,2)
    minG(i) = Gbest(i) - max(.0001*Gbest(i), .01); %if centered at origin, provide minimum width of box as .01
    maxG(i) = Gbest(i) + max(.0001*Gbest(i), .01);
end
IndexConv    = Particles > minG & Particles < maxG;
IndexConvTot = mean(IndexConv,2) == 1;                                            %must all be ones to be valid
PctConv      = sum(IndexConvTot)/length(IndexConvTot);
end