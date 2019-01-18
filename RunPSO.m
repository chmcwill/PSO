%% Run PSO
%This script will run PSO on a variety of test functions.
% 
%Important notes: 
%The Gbest will be shown with a green dot. Average objective function value 
%is calculated using the best % of the particles as defined as the 
%percentage required to converge. This is done to avoid oscillating 
%particles skewing the average and have the average tend toward Gbest as 
%convergence is met. The average only looks good with dropwave, it is currently 
%commented out under PlotPSO. Change the solution space for each function inside of
%InitializePSO. Recommended functions are: dropwave, Rastrigin, Schwefel, camel 

clear
clc
close all

np = 100;                                                                   %number of particles
w = .8;                                                                     %weight on inertia
c1 = 2;                                                                     %learning rate on Pbest
c2 = 2;                                                                     %learning rate on Gbest
pctThresh = .5;                                                             %percent converged threshold criteria
iters = 1000;                                                               %number of iterations allowed before stopping
Vel = zeros(np,2);                                                          %initialize velocity

% uncomment the desired function
% F = 'schaffer';
F = 'dropwave';  
% F = 'Rastrigin';
% F = 'bukin6';
% F = 'Schwefel';       %this example has constraints
% F = 'camel';
% F = 'peaks';      
% F = 'parabaloid';
for testIter = 1:20                                                         %how many cycles to run before plotting distribution of iterations needed to converge
    tic                                                                     %start measuring time
    PctConv = 0;                                                            %initialize percent converged
    i = 1;                                                                  %initialize counter for iterations
    [Particles, solspace] = InitializePSO(np, F);                           %call function to initialize positions and define solution space
    [C.X, C.Y, C.Z]       = ContourPSO(solspace, F, 1, pctThresh);          %calculate the contour lines
    %first iteration
    Pbest               = Particles;                                        %Pbest is their only position so far
    [Vals,minIndex, CB] = ObjFunct(Particles, F, 0, pctThresh);             %objective function values, index of Gbest, square constraint boundaries ([xmin xmax ymin ymax])
    Gbest               = Particles(minIndex,:);                            %find Gbest
    CostG               = ObjFunct(Gbest,F,0,pctThresh);                    %evaluate cost at Gbest
    CostAvg             = mean(Vals);                                       %find cost avg
    PlotPSO(Particles, Gbest, i, PctConv, solspace, C, CB, CostAvg, CostG, pctThresh); %plot cost function and map of particles
    pause(3)                                                                %pause after initializing and before starting to allow user to open and expand plot
    [Particles,Vel] = UpdatePos(Particles, Vel, Pbest, Gbest, w, c1, c2, minIndex); %update position and store velocity
    i = i + 1;
    %now loop to solve
    while PctConv < pctThresh && i < iters                                   %continue iterating until converged or max iters reached
        [NewVals,minIndex, ~, MNV90] = ObjFunct(Particles, F, 0, pctThresh); %evaluate objective function
        [Pbest, Gbest, PctConv]   = GbestPbest(Particles, Pbest, minIndex, Vals, NewVals, np); %calculate Pbest, Gbest, and PctConv
        CostG                     = [CostG ObjFunct(Gbest,F,0,pctThresh)];   %concatenate cost at Gbest to vector for plotting cost over iterations
        CostAvg                   = [CostAvg MNV90];                         %concatenate avg cost
        [Particles,Vel]           = UpdatePos(Particles, Vel, Pbest, Gbest, w, c1, c2, minIndex); %update position
        PlotPSO(Particles, Gbest, i, PctConv, solspace, C, CB, CostAvg, CostG, pctThresh); %update plots
        i = i + 1;                                                           %add to the counter of iterations
        pause(.001)                                                          %pause briefly to allow matlab to update plot, if desire to step through slowly, increase the pause
    end
    toc                                                                      %measure time taken to converge
    if i == iters                                                            %communicate result
        title(['Failed to Converge After ' num2str(i) ' Iterations'])
        pause(2)
    else
        title(['Converged After ' num2str(i) ' Iterations'])
        pause(2)
    end
    ItersNeeded(testIter) = i;                                               %store iterations needed for histogram later
end
% Distribution of iters needed
figure 
histogram(ItersNeeded)
title(['Iterations needed to converge (' num2str(np) 'particles used)'])
xlabel('Iterations to converge')
ylabel('Frequency')
% figure
% % obj = @ObjFunctOnly;
% % fsurf(obj, solspace)
% %%
% shaffer = @(x,y) -(0.5 + (cos(sin(abs(x.^2-y.^2))) - 0.5)./(1 + 0.001*(x.^2+y.^2)).^2);
% %fsurf(shaffer, [-50 50 -50 50]);
% %% 
% egg = @(x,y)  -(X2+47).*sin(sqrt(abs(X2+X1/2+47))) + -X1.*sin(sqrt(abs(X1-(X2+47))));
% 
% 
