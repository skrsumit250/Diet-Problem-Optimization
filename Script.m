%% Problem settings
[l,u,cost,cal,fat,protein,vitamin,mineral] = DietData;

Fn = @DietCostOptimization;     % Fitness function
Np = 1000;                      % Population Size
T = 10;                         % No. of iterations
rng(2,'twister')

%% Parameters for Genetic Algorithm
etac = 20;                         % Distribution index for crossover
etam = 20;                         % Distribution index for mutation
Pc = 0.8;                          % Crossover probability
Pm = 0.2;                          % Mutation probability

%% Parameters for PSO
w = 0.5; 
c1 = 2; 
c2 = 2;


% TLBO
TLBOsol = zeros(1,25);
for i=1:25
    [bestsolTLBO,bestfitnessTLBO] = TLBO(Fn,l,u,Np,T);
    TLBOsol(i) = bestfitnessTLBO;
end

% GA
GAsol = zeros(1,25);
for i=1:25
    [bestsolGA,bestfitnessGA] = GeneticAlgorithm(Fn,l,u,Np,T,etac,etam,Pc,Pm);
    GAsol(i) = bestfitnessGA;
end

% PSO
PSOsol = zeros(1,25);
for i=1:25
    [Xbest,Fbest] = PSOfunc(Fn,Np,l,u,T,w,c1,c2);
    PSOsol(i) = Fbest;
end

% Compare TLBO,GA,PSO
TLBOsol = MIN(TLBOsol);
GAsol = MIN(GAsol);
PSOsol = MIN(PSOsol);

x = zeros(1,25);
for i=1:25
    x(i) = i;
end

hold on;

PLOT(TLBOsol,x,'r');
PLOT(GAsol,x,'g');
PLOT(PSOsol,x,'b');
legend("TLBO","GA","PSO");

function [mn] = MIN(fitness)
    sz = length(fitness);
    mn = zeros(1,sz);
    mn(1) = fitness(1);
    for i=2:sz
        mn(i) = min(mn(i-1),fitness(i));
    end
end

function PLOT(y,x,color)
    plot(y,x,color);
    xlabel("Iterations");
    ylabel("Fitness")
end