function [u, t] = rcos(T, beta)
    t_tolerance = 1E-3;
    t0 = (1-beta)/2;
    t2 = (1+beta)/2;
    u = [];
    
    for t=-t2:t_tolerance:t2
        if (abs(t) < t0)
            u(end+1) = 1;
            continue
        end
        if (abs(t) <= t2 && abs(t) >= t0)
           u(end+1) = 0.5 * ( 1 + cos (pi/beta * (abs(t) - t0)));
        end
        
    end
    u = u';
    t= [-t2:t_tolerance:t2]';

end