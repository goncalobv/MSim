%% An�lise da fun��o f para entrada linear e sinusoidal
clear all
close all
yl = 0.4;
k1 = 1/yl;
k2 = sqrt(2*k1);
% f(10)
index = 1;
Y=[];
Z=[];
X=[-2:.01:2];
for i=1:size(X,2)
    Y(i) = f(X(i));
    Z(i) = f(sin(X(i)));
end
plot(X, Y, X, X)
title('Sinal linear � entrada');
legend('subsys','y=x');
figure
plot(X, Z, X, sin(X))
title('Sinal sinusoidal � entrada');
legend('subsys', 'y=sin(x)');
%% Ex7
% � suposto utilizar k2 para o ganho ou um valor elevado?
% Falta comparar com o sistema b�sico em malha fechada, tanto a evolu�ao do
% estado como do sinal de controlo (saida do subsistema)
% Quantificar tbm o tempo de resposta com sis basico e comparar
%
clear all
close all
pos0 = 10; % posi��o inicial da cabe�a do disco
ref = [0 0]; % valor da refer�ncia para a posi��o final da cabe�a do disco
yl = 0.4;
k1 = 1/yl;
k2 = sqrt(2*k1);
xmin = -10;
xmax = 10;
ymin = -10;
ymax = 10;
% ambos os XY Graph viewers foram definidos entre xmin xmax e ymin ymax; A
% posi��o inicial foi definida como pos0 = 10, o que nos
% permite observar a diferen�a entre a utiliza��o do subsistema
% simplesmente linear e o subsistema com o tro�o n�o linear.
% Embora seja um valor muito grande pos0 = 10, permite uma melhor
% compara��o das respostas.

% para comparar a degrada��o da resposta no tempo, definiu-se o tempo de
% simula��o para 20 s. Compara-se o tempo que demora a atingir uma
% velocidade final inferior a uma dada toler�ncia, neste caso 1E-3

vel_tolerance = 1E-3;

sim('no_chattering');
response = responsetime(tout', vel', vel_tolerance)
t_non_lin = response(2) % tempo de resposta com subsistema melhorado (n�o linear)


sim('no_chattering_linearsubsys');
response = responsetime(tout', vel',vel_tolerance)
t_lin = response(2) % tempo de resposta com subsistema linear
% Um tempo de resposta maior corresponde a uma solu��o pior, dado que se
% pretende minimizar o tempo de deslocamento da cabea�a do disco

% Analisando os sinais de controlo no tempo de ambos os subsistemas,
% nota-se que a amplitude deste sinal no subsistema melhorado � muito
% inferior � amplitude no subsistema linear.

%% Ex8
clear all
close all
pos0 = 10; % posi��o inicial da cabe�a do disco
yl = 0.4;
k1 = 1/yl;
k2 = sqrt(2*k1);
xmin = -10;
xmax = 10;
ymin = -10;
ymax = 10;
vel_tolerance = 1E-3;

% ref = [0 0;10 0;10 5]; % sinal constante por tro�os
ref = [0 0; 10 5; 20 0]; % sinal linear por tro�os
sim('no_chattering');
sim('no_chattering_linearsubsys');
% Observando o espa�o de fase para os dois sinais de entrada nota-se que a
% resposta do sistema linear tende a afastar-se mais das refer�ncias
% antes de haver a troca do sinal da velocidade (correspondente a uma fase
% de corre�ao da posi��o). Assim, o sistema n�o linear apresenta um
% comportamento din�mico melhor, para al�m de apresentar um tempo de
% resposta inferior (como observado na al�near anterior).