function [Xbest,Fbest] = PSOfunc(Fn,Np,lb,ub,T,w,c1,c2)

%Determine the number of variables
D = length(lb);

pop = repmat(lb,Np,1) + repmat((ub-lb),Np,1).*rand(Np,D);   % Generation of the initial population
% Loop through each row and randomly set 25 columns to 0
for i = 1:Np
    % Randomly select 25 column indices for the current row
    zeroIndices = randperm(D, 25);
    
    % Set the selected columns to 0 for the current row
    pop(i, zeroIndices) = 0;
end

% Generate random velocity vectors
v = repmat(lb,Np,1) + repmat((ub-lb),Np,1).*rand(Np,D);

%Evaluate the fitness value for each population member
for i = 1:Np
    obj(i) = Fn(pop(i,:));
end

%Initialize the personal best solutions
pbest = pop;
pbest_obj = obj;


% determine the global best solution
[gbest_obj,ind] = min(obj);
gbestPop = pop(ind,:);


% Perform iterations
for j = 1:T
    
    for i = 1:Np
        
        % generate new velocity vector for the solution i
        v(i,:) = w*v(i,:) + c1*rand(1,D).*(pbest(i,:)-pop(i,:)) + c2*rand(1,D).*(gbestPop - pop(i,:));
        
        % generate new solution 
        pop(i,:) = pop(i,:) + v(i,:);
        
        % bound the new solution
        pop(i,:) = max(pop(i,:),lb);
        pop(i,:) = min(pop(i,:),ub);
        
        % Determine the fitness of the new population member
        obj(i) = Fn(pop(i,:));
        
        % update the personal best solution
        if obj(i)<pbest_obj(i)
            pbest(i,:) =  pop(i,:);
            pbest_obj(i) = obj(i);
            
            % update the global best solution
            if pbest_obj(i)< gbest_obj
                gbest_obj = pbest_obj(i);
                gbestPop = pbest(i,:);
            end
        end
    end
end

Fbest = gbest_obj;
Xbest = pbest(ind,:);



