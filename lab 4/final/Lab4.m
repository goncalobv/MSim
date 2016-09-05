% Cadeira de Modela��o e Simula��o
%
% 4� Trabalho de laborat�rio
% Seria��o de p�ginas web
%
% Turno: 4� feira, das 9h �s 11h
%
% Elementos do grupo:
%     Gon�alo V�tor  N�73229
%     Catarina Cruz  N�73319
%     Diogo Br�s     N�68212

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

% A soma de todas as linhas de P � 1, dado que os valores de cada linha i correspondem �s
% probabilidades de transi��o entre esse estado i e os outros estados j e existe obrigatoriamente uma
% transi��o entre estados.
sum(P,2)
perm = [1 2 3 8 4 5 6 7 10 11 12 13 9];
% Matriz P em forma can�nica
Pcanonical = P(perm,perm)
% Denominemos:
% t1 como a classe transiente 1 - estados 1,2,3
% t2 como a classe transiente 2 - estado 8
% e1 como a classe erg�dica 1 - estados 4,5,6,7,10,11,12,13
% e2 como a classe erg�dica 2 - estado 9

% D matriz diagonal que cont�m os valores pr�prios de P', V matriz cujas
% colunas s�o os vectores pr�prios de P' associados aos valores pr�prios de
% D
[V, D] = eig(P');

% Obt�m-se dois valores pr�prios iguais a 1, correspondentes a dois
% modos diferentes
% o modo associado ao estado 9 - corresponde ao estado inicial 9
vector_proprio1_1 = V(:,1) % mant�m-se no estado 9
% estado inicial � qualquer outro estado
vector_proprio1_2 = V(:,2)/sum(V(:,2)) % � interessante notar que os estados/classes transientes (1,2,3,8) apresentam probabilidade nula
% este aspecto faz sentido se se considerar que os estados/classes transientes
% t�m liga��es unidireccionais para estados/classes erg�dicas
% Por outro lado, estados mais acess�veis (com mais liga��es vindas de
% outros estados) t�m probabilidades de ser visitados mais frequentemente.


L = (eye(4)-Pcanonical(1:4,1:4))^(-1)*Pcanonical(1:4,5:13)

% A matriz L pode ser vista como um conjunto de 4 matrizes
L11 = L(1:3,1:8) % transi��o de t1 para e1
L12 = L(1:3,9) % transi��o de t1 para e2
L21 = L(4,1:8) % transi��o de t2 para e1
L22 = L(4,9) % transi��o de t2 para e2


% Probabilidades de absor��o
p_absorption_t1_to_e1 = (1/3*ones(1,3))*L11*ones(8,1)
p_absorption_t1_to_e2 = (1/3*ones(1,3))*L12*ones(1,1)
p_absorption_t2_to_e1 = 1*L21*ones(8,1) % t2 apenas tem liga��es para estados em e1 p=1
p_absorption_t2_to_e2 = 1*L22*ones(1,1) % t2 n�o tem nenhuma liga��o para estados em e2 p=0

% � mais prov�vel t1 ser absorvido para e1 do que para e2, dado que existem
% mais liga��es de t1 para e1 do que para e2.

% N�mero de passos esperados at� � absor��o
N = (eye(4)-Pcanonical(1:4,1:4))^(-1)*ones(4,1)
% N�mero de passos esperados a partir de 1,2,3 e 8
% Note-se que de 8 basta apenas um passo (N(4)=1) pois a transi��o � directamente
% para uma classe erg�dica.
% Por outro lado, para 1, apenas 1/3 das liga��es s�o para um estado numa
% classe erg�dica (n�mero de passos esperado mais elevado at� absor��o) e
% para 2 e 3, existem 1/2 das liga��es para estados numa classe erg�dica,
% sendo que para 3 o n�mero de passos esperados � superior (correspondente
% a um caminho esperado mais longo). De forma muito simplificada, os
% caminhos que n�o conduzem a absor��o a partir de 2 s�o 2-3-1 ou 2-3-2,
% enquanto a partir de 3 (mais numerosos), temos 3-2-3, 3-1-3, 3-1-2.
% Qualitativamente os resultados obtidos est�o de acordo com o racioc�nio
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
prob_val = RunAndPlot(P, prob0, kfinal, '\pi(0) com distribui��o uniforme');

% Para k elevado, a distribui��o de probabilidades tende
% para um valor aproximadamente constante. Optou-se por escolher um kfinal
% relativamente baixo pois permite uma melhor visualiza��o dos resultados
% obtidos, bem como uma distribui��o de probabilidades aproximadamente
% constante.

% As probabilidades de equil�brio obtidas em prob_val(:,end) deveriam ser
% pr�ximas das obtidas por decomposi��o em valores e vectores pr�prios em
% valor_proprio1_2, no entanto verificam-se algumas diferen�as, sobretudo
% no que respeita � probabilidade do estado 9, ao qual est�
% associado tamb�m o outro vector pr�prio (vector_proprio1_1).
% Numa analogia com os modos de um sistema, pode referir-se que a
% distribui��o de probabilidades ao longo do tempo (devidamente normalizada)
% � uma combina��o linear dos diversos vectores pr�prios, sendo que a
% maioria desses modos tender� a desaparecer para k elevado (m�dulo
% do valor pr�prio associado menor que 1).
% Desta forma, as distribui��es de probabilidades para k elevado ser�o
% dependentes apenas dos vectores pr�prios associados a valores pr�prios
% unit�rios, justificando-se assim a diferen�a no valor da
% probabilidade do estado 9 (ao qual est� associado um outro modo
% espec�fico).

% Diferen�a entre as probabilidades esperadas e as obtidas por itera��o
vector_proprio1_2'-prob_val(:,end)'

% --
prob0 = [1/4 1/4 1/4 0 0 0 0 1/4 0 0 0 0 0]';
figure

prob_val2 = RunAndPlot(P, prob0, kfinal, '\pi(0) com distribui��o uniforme nos estados transientes (1,2,3,8)');

% Diferen�a entre as probabilidades esperadas e as obtidas por itera��o
vector_proprio1_2'-prob_val2(:,end)'

% --
prob0 = [0 0 0 0 0 0 0 1 0 0 0 0 0]';
figure

prob_val3 = RunAndPlot(P, prob0, kfinal, '\pi(0)=0 para i!=8');

% Notar que prob_val3(9,:) � sempre nulo, absor��o na classe erg�dica 1

% --
prob0 = [0 0 0 0 0 0 0 0 1 0 0 0 0]';
figure

prob_val4 = RunAndPlot(P, prob0, kfinal, '\pi(0)=0 para i!=9');

% Notar que prob_val4(9,:) � um vector de 1, absor��o na classe erg�dica 2

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

% verificar que para cada t a soma de prob_val � 1
%   uns=sum(prob_val); 
% � um vector de uns!

%s1 = sprintf('Verifica��o da soma das probabilidades:');
%disp(s1);
%disp(uns);

%%
% 
% ??
% % comentar diferen�as face ao anterior
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

str = sprintf('Figura1 remo�ao da aresta de 1 para 3');
Q = changeLine(Q, 1, [2,6]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura2 remo�ao da aresta de 1 para 6');
Q = changeLine(Q, 1, [2,3]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura3 remo�ao da aresta de 1 para 2');
Q = changeLine(Q, 1, [3,6]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura4 remo�ao da aresta de 3 para 2');
Q = changeLine(Q, 3, [1,6,7]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura5 remo�ao da aresta de 3 para 6');
Q = changeLine(Q, 3, [1,2,7]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura6 remo�ao da aresta de 3 para 7');
Q = changeLine(Q, 3, [1,2,6]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura7 remo�ao da aresta de 7 para 6');
Q = changeLine(Q, 7, [5,10]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura8 remo�ao da aresta de 8 para 12');
Q = changeLine(Q, 8, [6,7]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura9 remo�ao da aresta de 8 para 7');
Q = changeLine(Q, 8, [6,12]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura10 remo�ao da aresta de 8 para 6');
Q = changeLine(Q, 8, [7,12]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura11 remo�ao da aresta de 10 para 7');
Q = changeLine(Q, 10, [12]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura12 remo�ao da aresta de 10 para 12');
Q = changeLine(Q, 10, [7]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura13 remo�ao da aresta de 11 para 5');
Q = changeLine(Q, 11, [13]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;
str = sprintf('Figura14 remo�ao da aresta de 12 para 6');
Q = changeLine(Q, 12, [13]);
[V, D] = eig(Q);
prob_estados(Q,alfa);
disp(str);

Q = Q_inicial;

str = sprintf('Figura15 sem remo��es de arestas');
prob_estados(Q_inicial,alfa);
disp(str);


%%
% 
%  A Figura 14 representa a remo��o da aresta que faz o estado 12 transitar para o estado 6. Aquando desta ocorrencia, criam-se dois 
%  ciclos - (7->6->12->13->7->...) e (7->10->12->13->7->...) - com passagem obrigat�ria pelos estados 7, 12 e 13 , e que s�o definidos
%  pela transi��o de sa�da do n� 7. Isto explica portanto a exist�ncia dos m�ximos de probabilidade nos respectivos estados.
% 
%


%% Ex 3a
close all
clear all

N = 13;

prob0 = 1/N*ones(N,1);

nruns = 1000; % define o n�mero de runs

burnin = 200; % n de passos em que n�o s�o contabilizados os estados

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
disp('Vector de probabilidades dos estados ap�s runs de Monte Carlo');
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

nruns = 1000; % define o n�mero de runs

burnin = 200; % n de passos em que n�o s�o contabilizados os estados

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
disp('Vector de probabilidades dos estados ap�s runs de Monte Carlo');
str=sprintf('%.6f\t\t',freq_rel);
disp(str);
figure;
plot(1:13,freq_rel,'r');
axis([0 14 0 0.8]);

%os valores pr�prios s�o os esperados de uma cadeia peri�dica
%as probabilidades usando o ciclo de monte carlo fazem sentido
