% Cadeira de Modelação e Simulação
%
% 4º Trabalho de laboratório
% Seriação de páginas web
%
% Turno: 4ª feira, das 9h às 11h
%
% Elementos do grupo:
%     Gonçalo Vítor  Nº73229
%     Catarina Cruz  Nº73319
%     Diogo Brás     Nº68212

% warning off

%% Ex2b
close all
clear all

P = zeros(13);
P = changeLine(P, 1, [2,3,6]);
P = changeLine(P, 2, [3,9]);
P = changeLine(P, 3, [1,2,6,7]);
P = changeLine(P, 4, [11]);
P = changeLine(P, 5, [4, 11]);
P = changeLine(P, 6, [12]);
P = changeLine(P, 7, [5,6,10]);
P = changeLine(P, 8, [6,7,12]);
P = changeLine(P, 9, [9]);
P = changeLine(P, 10, [7,12]);
P = changeLine(P, 11, [5,13]);
P = changeLine(P, 12, [6,13]);
P = changeLine(P, 13, [7]);

% A soma de todas as linhas de P é 1, dado que os valores de cada linha i correspondem às
% probabilidades de transição entre esse estado i e os outros estados j e existe obrigatoriamente uma
% transição entre estados.
sum(P,2)
perm = [1 2 3 8 4 5 6 7 10 11 12 13 9];
% Matriz P em forma canónica
Pcanonical = P(perm,perm)
% Denominemos:
% t1 como a classe transiente 1 - estados 1,2,3
% t2 como a classe transiente 2 - estado 8
% e1 como a classe ergódica 1 - estados 4,5,6,7,10,11,12,13
% e2 como a classe ergódica 2 - estado 9

% D matriz diagonal que contém os valores próprios de P', V matriz cujas
% colunas são os vectores próprios de P' associados aos valores próprios de
% D
[V, D] = eig(P');

% Obtêm-se dois valores próprios iguais a 1, correspondentes a dois
% modos diferentes
% o modo associado ao estado 9 - corresponde ao estado inicial 9
vector_proprio1_1 = V(:,1) % mantém-se no estado 9
% estado inicial é qualquer outro estado
vector_proprio1_2 = V(:,2)/sum(V(:,2)) % é interessante notar que os estados/classes transientes (1,2,3,8) apresentam probabilidade nula
% este aspecto faz sentido se se considerar que os estados/classes transientes
% têm ligações unidireccionais para estados/classes ergódicas
% Por outro lado, estados mais acessíveis (com mais ligações vindas de
% outros estados) têm probabilidades de ser visitados mais frequentemente.


L = (eye(4)-Pcanonical(1:4,1:4))^(-1)*Pcanonical(1:4,5:13)

% A matriz L pode ser vista como um conjunto de 4 matrizes
L11 = L(1:3,1:8) % transição de t1 para e1
L12 = L(1:3,9) % transição de t1 para e2
L21 = L(4,1:8) % transição de t2 para e1
L22 = L(4,9) % transição de t2 para e2


% Probabilidades de absorção
p_absorption_t1_to_e1 = (1/3*ones(1,3))*L11*ones(8,1)
p_absorption_t1_to_e2 = (1/3*ones(1,3))*L12*ones(1,1)
p_absorption_t2_to_e1 = 1*L21*ones(8,1) % t2 apenas tem ligações para estados em e1 p=1
p_absorption_t2_to_e2 = 1*L22*ones(1,1) % t2 não tem nenhuma ligação para estados em e2 p=0

% É mais provável t1 ser absorvido para e1 do que para e2, dado que existem
% mais ligações de t1 para e1 do que para e2.

% Número de passos esperados até à absorção
N = (eye(4)-Pcanonical(1:4,1:4))^(-1)*ones(4,1)
% Número de passos esperados a partir de 1,2,3 e 8
% Note-se que de 8 basta apenas um passo (N(4)=1) pois a transição é directamente
% para uma classe ergódica.
% Por outro lado, para 1, apenas 1/3 das ligações são para um estado numa
% classe ergódica (número de passos esperado mais elevado até absorção) e
% para 2 e 3, existem 1/2 das ligações para estados numa classe ergódica,
% sendo que para 3 o número de passos esperados é superior (correspondente
% a um caminho esperado mais longo). De forma muito simplificada, os
% caminhos que não conduzem a absorção a partir de 2 são 2-3-1 ou 2-3-2,
% enquanto a partir de 3 (mais numerosos), temos 3-2-3, 3-1-3, 3-1-2.
% Qualitativamente os resultados obtidos estão de acordo com o raciocínio
% realizado.


%% Ex2c

close all
clear all

P = zeros(13);
P = changeLine(P, 1, [2,3,6]);
P = changeLine(P, 2, [3,9]);
P = changeLine(P, 3, [1,2,6,7]);
P = changeLine(P, 4, [11]);
P = changeLine(P, 5, [4, 11]);
P = changeLine(P, 6, [12]);
P = changeLine(P, 7, [5,6,10]);
P = changeLine(P, 8, [6,7,12]);
P = changeLine(P, 9, [9]);
P = changeLine(P, 10, [7,12]);
P = changeLine(P, 11, [5,13]);
P = changeLine(P, 12, [6,13]);
P = changeLine(P, 13, [7]);

[V, D] = eig(P');
vector_proprio1_2 = V(:,2)/sum(V(:,2));

kfinal = 20;

prob0 = 1/13*ones(13,1);
prob_val = RunAndPlot(P, prob0, kfinal, '\pi(0) com distribuição uniforme');

% Para k elevado, a distribuição de probabilidades tende
% para um valor aproximadamente constante. Optou-se por escolher um kfinal
% relativamente baixo pois permite uma melhor visualização dos resultados
% obtidos, bem como uma distribuição de probabilidades aproximadamente
% constante.

% As probabilidades de equilíbrio obtidas em prob_val(:,end) deveriam ser
% próximas das obtidas por decomposição em valores e vectores próprios em
% valor_proprio1_2, no entanto verificam-se algumas diferenças, sobretudo
% no que respeita à probabilidade do estado 9, ao qual está
% associado também o outro vector próprio (vector_proprio1_1).
% Numa analogia com os modos de um sistema, pode referir-se que a
% distribuição de probabilidades ao longo do tempo (devidamente normalizada)
% é uma combinação linear dos diversos vectores próprios, sendo que a
% maioria desses modos tenderá a desaparecer para k elevado (módulo
% do valor próprio associado menor que 1).
% Desta forma, as distribuições de probabilidades para k elevado serão
% dependentes apenas dos vectores próprios associados a valores próprios
% unitários, justificando-se assim a diferença no valor da
% probabilidade do estado 9 (ao qual está associado um outro modo
% específico).

% Diferença entre as probabilidades esperadas e as obtidas por iteração
vector_proprio1_2'-prob_val(:,end)'

% --
prob0 = [1/4 1/4 1/4 0 0 0 0 1/4 0 0 0 0 0]';
figure

prob_val2 = RunAndPlot(P, prob0, kfinal, '\pi(0) com distribuição uniforme nos estados transientes (1,2,3,8)');

% Diferença entre as probabilidades esperadas e as obtidas por iteração
vector_proprio1_2'-prob_val2(:,end)'

% --
prob0 = [0 0 0 0 0 0 0 1 0 0 0 0 0]';
figure

prob_val3 = RunAndPlot(P, prob0, kfinal, '\pi(0)=0 para i!=8');

% Notar que prob_val3(9,:) é sempre nulo, absorção na classe ergódica 1

% --
prob0 = [0 0 0 0 0 0 0 0 1 0 0 0 0]';
figure

prob_val4 = RunAndPlot(P, prob0, kfinal, '\pi(0)=0 para i!=9');

% Notar que prob_val4(9,:) é um vector de 1, absorção na classe ergódica 2

%% 2d

close all
clear all

Q = zeros(13);
alfa = .95;

Q = changeLine(Q, 1, [2,3,6]);
Q = changeLine(Q, 2, [3,9]);
Q = changeLine(Q, 3, [1,2,6,7]);
Q = changeLine(Q, 4, [11]);
Q = changeLine(Q, 5, [4,11]);
Q = changeLine(Q, 6, [12]);
Q = changeLine(Q, 7, [5,6,10]);
Q = changeLine(Q, 8, [6,7,12]);
Q = changeLine(Q, 9, [9]);
Q = changeLine(Q, 10, [7,12]);
Q = changeLine(Q, 11, [5,13]);
Q = changeLine(Q, 12, [6,13]);
Q = changeLine(Q, 13, [7]);

prob_estados(Q,alfa);

% verificar que para cada t a soma de prob_val é 1
%   uns=sum(prob_val); 
% é um vector de uns!

%s1 = sprintf('Verificação da soma das probabilidades:');
%disp(s1);
%disp(uns);

%%
% 
% ??
% % comentar diferenças face ao anterior
% o ranking obtido faz sentido?
%


%% Ex 2e

%close all
%clear all

Q = zeros(13);
alfa = .95;

Q = changeLine(Q, 1, [2,3,6]);
Q = changeLine(Q, 2, [3,9]);
Q = changeLine(Q, 3, [1,2,6,7]);
Q = changeLine(Q, 4, [11]);
Q = changeLine(Q, 5, [4,11]);
Q = changeLine(Q, 6, [12]);
Q = changeLine(Q, 7, [5,6,10]);
Q = changeLine(Q, 8, [6,7,12]);
Q = changeLine(Q, 9, [9]);
Q = changeLine(Q, 10, [7,12]);
Q = changeLine(Q, 11, [5,13]);
Q = changeLine(Q, 12, [6,13]);
Q = changeLine(Q, 13, [7]);

%linhas a serem mudadas:
Q_inicial = Q;

str = sprintf('Figura1 remoçao da aresta de 1 para 3');
Q = changeLine(Q, 1, [2,6]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura2 remoçao da aresta de 1 para 6');
Q = changeLine(Q, 1, [2,3]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura3 remoçao da aresta de 1 para 2');
Q = changeLine(Q, 1, [3,6]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura4 remoçao da aresta de 3 para 2');
Q = changeLine(Q, 3, [1,6,7]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura5 remoçao da aresta de 3 para 6');
Q = changeLine(Q, 3, [1,2,7]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura6 remoçao da aresta de 3 para 7');
Q = changeLine(Q, 3, [1,2,6]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura7 remoçao da aresta de 7 para 6');
Q = changeLine(Q, 7, [5,10]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura8 remoçao da aresta de 8 para 12');
Q = changeLine(Q, 8, [6,7]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura9 remoçao da aresta de 8 para 7');
Q = changeLine(Q, 8, [6,12]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura10 remoçao da aresta de 8 para 6');
Q = changeLine(Q, 8, [7,12]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura11 remoçao da aresta de 10 para 7');
Q = changeLine(Q, 10, [12]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura12 remoçao da aresta de 10 para 12');
Q = changeLine(Q, 10, [7]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura13 remoçao da aresta de 11 para 5');
Q = changeLine(Q, 11, [13]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura14 remoçao da aresta de 12 para 6');
Q = changeLine(Q, 12, [13]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;

str = sprintf('Figura15 sem remoções de arestas');
prob_estados(Q_inicial,alfa);
disp(str);


%%
% 
%  A Figura 14 representa a remoção da aresta que faz o estado 12 transitar para o estado 6. Aquando desta ocorrencia, criam-se dois 
%  ciclos - (7->6->12->13->7->...) e (7->10->12->13->7->...) - com passagem obrigatória pelos estados 7, 12 e 13 , e que são definidos
%  pela transição de saída do nó 7. Isto explica portanto a existência dos máximos de probabilidade nos respectivos estados.
% 
%


%% Ex 3a
close all
clear all

N = 13;

prob0 = 1/N*ones(N,1);

nruns = 1000; % define o número de runs

burnin = 200; % n de passos em que não são contabilizados os estados

passos = 2000;% n de passos em cada run

Q = zeros(N);
alfa = .95;

Q = changeLine(Q, 1, [2,3,6]);
Q = changeLine(Q, 2, [3,9]);
Q = changeLine(Q, 3, [1,2,6,7]);
Q = changeLine(Q, 4, [11]);
Q = changeLine(Q, 5, [4,11]);
Q = changeLine(Q, 6, [12]);
Q = changeLine(Q, 7, [5,6,10]);
Q = changeLine(Q, 8, [6,7,12]);
Q = changeLine(Q, 9, [9]);
Q = changeLine(Q, 10, [7,12]);
Q = changeLine(Q, 11, [5,13]);
Q = changeLine(Q, 12, [6,13]);
Q = changeLine(Q, 13, [7]);

E = ones(N);
P = alfa*Q+(1-alfa)/N*E;

histograma = zeros(N,1);
hist_matrix=zeros(nruns,13);


for i=1:nruns
    hh=waitbar(i/nruns);
    prob = prob0;
    rindex = find(cumsum(prob) > rand,1,'first'); % estado inicial
%     histograma(rindex) = histograma(rindex)+1;
    for j=1:passos
        from = rindex;
        rindex = find(cumsum(P(rindex,:)) > rand,1,'first'); % estado seguinte
        if(j > burnin)
            histograma(rindex) = histograma(rindex)+1;
        end
        to = rindex;
        if(P(from, to) == 0)
            error('There is a problem!');
        end
    end

end
close(hh);


freq_rel = histograma/(nruns*(passos-burnin));
disp('Vector de probabilidades dos estados após runs de Monte Carlo');
str=sprintf('%.6f\t\t',freq_rel);
disp(str);
figure;
plot(1:13,freq_rel,'r');
axis([0 14 0 0.8]);

%passos-burnin - n+ de vezes por run que se pode contabilizar um estado


%%
% 
%  
% 
%

%% Ex3b
close all
clear all

N = 13;

prob0 = 1/N*ones(N,1);

nruns = 1000; % define o número de runs

burnin = 200; % n de passos em que não são contabilizados os estados

passos = 2000;% n de passos em cada run

Q = zeros(N);
alfa = 1;

Q = changeLine(Q, 1, [2,3,6]);
Q = changeLine(Q, 2, [3,9]);
Q = changeLine(Q, 3, [1,2,6,7]);
Q = changeLine(Q, 4, [9,11]);
Q = changeLine(Q, 5, [4,11]);
Q = changeLine(Q, 6, [12]);
Q = changeLine(Q, 7, [5,6,10]);
Q = changeLine(Q, 8, [6,7,12]);
Q = changeLine(Q, 9, [2]);
Q = changeLine(Q, 10, [7,12]);
Q = changeLine(Q, 11, [5,13]);
Q = changeLine(Q, 12, [6,8,13]);
Q = changeLine(Q, 13, [7]);

E = ones(N);
P = alfa*Q+(1-alfa)/N*E;

histograma = zeros(N,1);
hist_matrix=zeros(nruns,13);


for i=1:nruns
    hh=waitbar(i/nruns);
    prob = prob0;
    rindex = find(cumsum(prob) > rand,1,'first'); % estado inicial
%     histograma(rindex) = histograma(rindex)+1;
    for j=1:passos
        from = rindex;
        rindex = find(cumsum(P(rindex,:)) > rand,1,'first'); % estado seguinte
        if(j > burnin)
            histograma(rindex) = histograma(rindex)+1;
        end
        to = rindex;
        if(P(from, to) == 0)
            error('There is a problem!');
        end
    end

end
close(hh);


freq_rel = histograma/(nruns*(passos-burnin));
disp('Vector de probabilidades dos estados após runs de Monte Carlo');
str=sprintf('%.6f\t\t',freq_rel);
disp(str);
figure;
plot(1:13,freq_rel,'r');
axis([0 14 0 0.8]);

%os valores próprios são os esperados de uma cadeia periódica
%as probabilidades usando o ciclo de monte carlo fazem sentido
