function [NewPos,NewVel] = UpdatePos(Ppres, VelOld, Pbest, Gbest, w, c1, c2, minIndex)
%Calculates new position of particles, stores velocity. Treats Gbest as a
%particle but zeroes its velocity
%   inputs:
%       Ppres      - np,2 array containing the design variable values
%       VelOld     - old velocity
%       Pbest      - np,2 array of personal best values of each particle
%       Gbest      - design variable values of Gbest
%       minIndex   - index of Gbest
%   outputs:
%       NewPos     - updated position of particles
%       NewVel     - velocity used for position update

R1 = rand(size(Ppres,1),1);
R2 = rand(size(Ppres,1),1);
GBnoVel = minIndex == 1:length(R1);
% NewVel = (w.*VelOld + R1.*(c1*(Pbest - Ppres)) + R2.*(c2*(Gbest - Ppres)));   %allow Gbest to move
NewVel = (1-GBnoVel)'.*(w.*VelOld + R1.*(c1*(Pbest - Ppres)) + R2.*(c2*(Gbest - Ppres)));   %zero out the velocity of the gbest
NewPos = NewVel + Ppres;
end

