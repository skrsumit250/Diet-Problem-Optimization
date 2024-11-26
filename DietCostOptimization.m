function fn = DietCostOptimization(x)

    [l,u,cost,cal,fat,protein,vitamin,mineral] = DietData;

    n = length(x);
    total_cost = 0;
    total_cal = 0;
    total_fat = 0;
    total_protein = 0;
    total_vitamin = 0;
    total_mineral = 0;
    penalty = 0;

    INF = 10^6;
    for i = 1:n
        if l(i) <= x(i) && x(i) <= u(i)
            total_cost = total_cost + x(i)*cost(i)/100; % Objective function
            total_cal = total_cal + x(i)*cal(i)/100;
            total_fat = total_fat + x(i)*fat(i)/100;
            total_protein = total_protein + x(i)*protein(i)/100;
            total_vitamin = total_vitamin + x(i)*vitamin(i)/100;
            total_mineral = total_mineral + x(i)*mineral(i)/100;
        elseif 0 <x(i) &&  x(i)<l(i)  
            penalty = penalty + INF;
        end
    end


    %       cal fat protein vitamin mineral budget
    low =  [2000 44 46 0.113 6.028];
    high = [2500 78 56 0.134 8.049];
    count = 0;
    if(total_cal~=0 && (total_cal<low(1) || high(1)<total_cal))
        count = count +1;
    end

    if(total_fat~=0 && (total_fat<low(2) || high(2)<total_fat))
        count = count +1;
    end

    if(total_protein~=0 && (total_protein<low(3) || high(3)<total_protein))
        count = count +1;
    end

    if(total_vitamin~=0 && (total_vitamin<low(4) || high(4)<total_vitamin))
        count = count +1;
    end

    if(total_mineral~=0 && (total_mineral<low(5) || high(5)<total_mineral))
        count = count +1;
    end

    fn = total_cost;
    
    if count > 3 
        fn = fn + INF;
    end

    