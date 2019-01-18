function [X, Y, Z] = ContourPSO(solspace, F, cont, pctThresh)
%Calculates contours of the objective function for visualization.
%Calculates Z value for matrix of X and Y locations specified by solution
%space
%   inputs:
%       solspace   - bounds of initialization space
%       F          - the function in use
%       cont       - binary indicator on whether to calculate constraints or not
%       pctThresh  - the required percentage to converge, used here to calculate the average cost
%   outputs:
%       X          - meshgrid of X coordinates used for calculation of Z
%       Y          - meshgrid of Y coordinates used for calculation of Z
%       Z          - matrix of values for matrix of X and Y locations specified by solspace

x = linspace(solspace(1),solspace(2),50);           %specify vector and spacing of x values to calculate object function for
y = linspace(solspace(3),solspace(4),50);           %setting sparser vector will improve speed but decrease quality of contours
[X,Y] = meshgrid(x,y);
for i = 1:size(X,1)
    for j = 1:size(X,2)
        Z(i,j) = ObjFunct([X(i,j) Y(i,j)], F, cont, pctThresh);
    end
end

end