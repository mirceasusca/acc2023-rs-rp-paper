x = optimvar("x",LowerBound=-5,UpperBound=5);
y = optimvar("y",LowerBound=-5,UpperBound=5);
x0.x = -1;
x0.y = 2;
prob = optimproblem(Objective=peaks(x,y));
opts = optimoptions("fmincon",Display="none");
[sol,fval] = solve(prob,x0,Options=opts)

%%
ms = GlobalSearch;
[sol2,fval2] = solve(prob,x0,ms)

%%
% [X,Y,Z] = peaks;
% surf(X,Y,Z)