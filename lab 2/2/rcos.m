 %% funcao rcos(T,beta)
   %  funcionalidade:       preencher vectores recebidos
   %  entrada:              vector com o tempo T e vector com beta
   %                        coeficiente rolloff
   %
   %  saida:                vector com o tempo e vector com aplitudes
   %                        respectivas
   %
   %  algoritmo:            imposto pela função indicada no enunciado de
   %                        acordo com os tempos indicados
   %



function [u, tempo] = rcos(T, beta)
    t_tolerance = 1E-3;
    t0 = (1-beta)/2;
    t2 = (1+beta)/2;
    u = []; %gerar u, valores de entrada do nosso sistema
            % vector nulo pronto a ser acrescentado
    tempo = [];
    
    for t=-t2:t_tolerance:t2
        if (abs(t) <= t0)           % testa se está na zona do impulso
            u(end+1) = 1;           % em que a amplitude é constante
            tempo(end+1)=t;         
            continue
        end
        if (abs(t) <= t2 && abs(t) > t0)                            % testa se está na zona do impulso em que
           u(end+1) = 0.5 * ( 1 + cos (pi/beta * (abs(t) - t0)));   % a amplitude é constituída por uma função composta do cosseno
           tempo(end+1)=t;
        end       
    end
    u = u';             %transposição dos vectores de entrada e de tempo
    tempo=tempo';
    
end