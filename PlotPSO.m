function [] = PlotPSO(Particles, Gbest, i, PctConv, solspace, cont, CB, CostAvg, CostG, pctThresh)
%creates subplot of cost function and map of contour and particle locations
%gbest is a green dot
%   inputs:
%       Particles  - np,2 array containing the design variable values
%       i          - iteration number
%       PctConv    - number of particles within .1% of the Global Best location
%       solspace   - bounds of initialization space
%       cont       - structure containing contour lines
%       CB         - constraint boundary polygon coordinates
%       CostAvg    - vector of all means of the best pctThresh particles
%       CostG      - vector of all Gbest cost values
%       pctThresh  - percent of particles within .1% of Gbest required for convergence

subplot(1,2,2)
plot(Particles(:,1),Particles(:,2),'b.','MarkerSize',16);
hold on
plot(Gbest(1),Gbest(2),'g.','MarkerSize',32);
title(['PSO Iteration ', num2str(i)]) %; \tGbest = (' num2str(round(Gbest(1),3)), ', ' num2str(round(Gbest(2),3)) ')'
text(.3*solspace(2), .85*solspace(4), ['Gbest = (', num2str(round(Gbest(1),2)), ', ', num2str(round(Gbest(2),2)) ')'])
text(.3*solspace(2), .7*solspace(4), [num2str(round(PctConv*100,1)) '% Converged'])
ylabel('x2')
xlabel('x1')
axis(solspace)
contour(cont.X, cont.Y, cont.Z)
if sum(CB~=0) > 1
    x = [CB(1) CB(1) CB(2) CB(2) CB(1)];
    y = [CB(3) CB(4) CB(4) CB(3) CB(3)];
    plot(x,y,'r--','LineWidth',2)                               %plot constraint boundary polygon
    hold off
end
hold off

subplot(1,2,1)
plot(1:length(CostG),CostG,'k-','LineWidth',2)
% currently not plotting average, uncomment the 3 lines below to plot it
% hold on                                                       
% plot(1:length(CostAvg),CostAvg,'b-','LineWidth',1)
% legend('Value at Gbest',['Average Value of best ' num2str(pctThresh*100) '%'])
title('Value at Gbest')
xlabel('Iteration number')
ylabel('Value of objective function')
hold off
end