function [Vals, minIndex, ConstBound, MNV90] = ObjFunct(Particles, F, cont, pctThresh)
%Calculates objective function for 2 design variables, calculates index of
%Gbest, calculate mean cost of best pctThresh particles
%   inputs:
%       Particles  - np,2 array containing the design variable values
%       F          - the function in use
%       cont       - binary indicator on whether to calculate constraints or not
%       pctThresh  - the required percentage to converge, used here to calculate the average cost
%   outputs:
%       Vals       - np length column vector containing the cost of each particle
%       minIndex   - the index of Vals containing Gbest
%       ConstBound - 1,4 vector containing [xmin xmax ymin ymax] of constraint
%       MNV90      - mean of the best pctThresh particles

ConstBound = [0 0 0 0];
if strcmp(F,'peaks')
    X1 = Particles(:,1);
    X2 = Particles(:,2);
    Vals = 3*(1-X1).^2.*exp(-(X1.^2)-(X2+1).^2)...
        - 10*(X1./5 - X1.^3 - X2.^5).*exp(-X1.^2-X2.^2)...
        - 1/3*exp(-(X1+1).^2 - X2.^2);
elseif strcmp(F,'parabaloid')
    P = Particles;
    Vals = (1.4 + P(:,2)).^2 + (1.8 + P(:,1)).^2;
elseif strcmp(F,'Rastrigin')
    P = Particles;
    Vals = 20 + P(:,1).^2 + P(:,2).^2 - 10*(cos(2*pi*P(:,1)) + cos(2*pi*P(:,2)));
elseif strcmp(F,'Michalewicz')
    P = Particles;
    Vals = zeros(size(P(:,1)));
    m = 10;
    for k = 1:size(P,2) 
        for i = 1:size(P,1)
            Vals(i) = Vals(i) - sin(P(i,k)).*(sin(k*(P(i,k).^2)/pi).^2*m);
        end
    end
elseif strcmp(F,'camel')
    X1 = Particles(:,1);
    X2 = Particles(:,2);
    Vals = (4-2.1*(X1.^2)+(X1.^4)/3).*(X1.^2) + X1.*X2 + (-4+4*(X2.^2)).*(X2.^2);
elseif strcmp(F,'dropwave')
    X1 = Particles(:,1);
    X2 = Particles(:,2);
    Vals = - (1 + cos(12*((X1.^2+X2.^2).^.5)))./(.5*((X1.^2) + (X2.^2))+2);
elseif strcmp(F,'schaffer')
    X1 = Particles(:,1);
    X2 = Particles(:,2);
    fact1 = cos(sin(abs(X1.^2-X2.^2))) - 0.5;
    fact2 = (1 + 0.001*(X1.^2+X2.^2)).^2;   
    Vals = - (0.5 + fact1./fact2);
elseif strcmp(F,'egg')
    X1 = Particles(:,1);
    X2 = Particles(:,2);
    term1 = -(X2+47).*sin(sqrt(abs(X2+X1/2+47)));
    term2 = -X1.*sin(sqrt(abs(X1-(X2+47))));
    Vals = term1 + term2;
elseif strcmp(F,'Schwefel')
    X1 = Particles(:,1);
    X2 = Particles(:,2);
    Vals = 418.9829*2 - X1.*sin(sqrt(abs(X1))) - X2.*sin(sqrt(abs(X2)));
    %constraints!!! (bcus the nooby dots wont stay home)
    penalty = 100000000;
    ConstBound = [220 -200 200 -200]; %xmax xmin ymax ymin
    outIndx = X1 > ConstBound(1) | X1 < ConstBound(2) | X2 > ConstBound(3) | X2 < ConstBound(4);
%     magOutBounds = (abs(X1) - 500 + abs(X2) - 500)/2;
    if cont == 0
        Vals = Vals + outIndx.*penalty;    %magOutBounds.*  %if not doing contour, then apply constraints
    end
elseif strcmp(F,'bukin6')
    X1 = Particles(:,1);
    X2 = Particles(:,2);
    term1 = 100 * sqrt(abs(X2 - 0.01*X1.^2));
    term2 = 0.01 * abs(X1+10);
    Vals = term1 + term2;
end
ValsSorted = sort(Vals);
MNV90 = mean(Vals(1:floor(pctThresh*length(ValsSorted))));    %avg the best 90% to avoid oscillators throwing off avg
[~, minIndex] = min(Vals);
end

