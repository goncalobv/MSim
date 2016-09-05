%% Lab2 - Questao 6

function val = f (x)
    yl = 1;
    k1 = 1/yl;
    k2 = sqrt(2*k1);
    
    if(abs(x)<=yl)
        val = k1/k2*x;
    else
        val = sign(x)*(sqrt(2*abs(x))-1/k2);
    end
end
