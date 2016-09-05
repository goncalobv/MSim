function first_loop_time = getFirstLoopTime(t, teta1, teta2)
% A detecção de teta1 ou teta2 iguais a pi, pode ser observada
% através da passagem dos teta1_mod ou teta2_mod de 2*pi para 0 ou vice-versa
    first_loop_time = -1;
    teta1_mod = mod(teta1-pi, 2*pi);
    teta2_mod = mod(teta2-pi, 2*pi);
    for i=1:1:size(teta1_mod, 1)-1,
        if(teta1_mod(i)>=2*pi-1 && teta1_mod(i+1)<=1)
            first_loop_time = t(i);
    %         disp 'teta1';
    %         i
            break;
        end
        if(teta1_mod(i)<=1 && teta1_mod(i+1)>=2*pi-1)
            first_loop_time = t(i);
    %         disp 'teta1';
    %         i
            break;
        end
        if(teta2_mod(i)>=2*pi-1 && teta2_mod(i+1)<=1)
            first_loop_time = t(i);
    %         disp 'teta2';
    %         i
            break;
        end
        if(teta2_mod(i)<=1 && teta2_mod(i+1)>=2*pi-1)
            first_loop_time = t(i);
    %         disp 'teta2';
    %         i

            break;
        end
    end
    if(first_loop_time == -1),first_loop_time = NaN;
end