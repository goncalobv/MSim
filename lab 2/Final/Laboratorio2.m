% Cadeira de Modela��o e Simula��o
%
% 2� Trabalho de laborat�rio
% Simula��o b�sica em Matlab/Simulink
%
% Turno: 4� feira, das 9h �s 11h
%
% Elementos do grupo:
%     Gon�alo V�tor  N�73229
%     Catarina Cruz  N�73319
%     Diogo Br�s     N�68212

%% Ex. 2 
% Simula��o do sistema de entradas compostas para diferentes valores de
% alpha e beta e posterior confirma��o, por tentativa e erro, dos
% resultados anal�ticos por observa��o dos gr�ficos.


%%
% 
%  vbeta = [0:0.2:1]; % 0 <= beta <=1 beta poder� ser qualquer entre 0 e 1
% pelo que ach�mos por bem simular para 5 valores de beta distintos
%

warning off

vbeta = [0:0.25:1];

alpha = 1;
for beta = vbeta

    T1 = 1+beta; 
    T2= alpha * T1; 
    U1 = -2/(T1 * (1 + alpha)); % Rela��o descoberta analiticamente entre U1 e T1
    U2 = -U1; 

    [u1,t1] = rcos(T1,beta);
    u1 = U1 * u1;

    [u2,t2] = rcos(T2,beta);
    u2 = U2 * u2;

    t1=t1+T1/2;
    t2=t2*alpha;
    t2=t2+T2/2+T1;
    t2=t2+0.001;

    tempo = [t1; t2];
    simin = [tempo,[u1; u2]];
    sim('sis', tempo);

    figure;
    hold on;
    plot(tempo,simout,'b');
    plot(tempo,simout1,'r');
    plot(tempo,zeros(length(tempo)),'g');
    legend('y(t)','y''(t)');
    title(['Alpha=1 ;',' Beta=',num2str(beta)]);
    hold off;

    figure;
    hold on;
    plot(simout,simout1,'b');
    plot(simout(1),simout1(1),'go');
    plot(simout(end),simout1(end),'ro');
    plot(0,0,'rx');
    title(['Alpha=1 ;',' Beta=',num2str(beta)]);
    legend('(y,y'')','Estado inicial','Estado final','Estado final pretendido');
    hold off;
end

%%
%
% valpha = [0.5:0.5:3]; % alpha > 0; escolhemos um valor inicial em 0.5 
% visto que alpha n�o pode tomar o valor de 0.Resultando assim, de acordo
% com o nosso valor inicial, passo e valor final, 5 valores distintos de
% alpha.
% O valor final de alpha foi escolhido para avaliar como alpha evolui ap�s
% passar do valor favorito que era 1, para esta vari�vel
% 

valpha = [0.5:0.5:2.5];

beta = 0;
i=0;
for alpha = valpha

    % atribui��es
    T1 = 1+beta;
    T2= alpha * T1;
    U1 = -2/(T1 * (1 + alpha)); % Rela��o descoberta analiticamente entre U1 e T1
    U2 = -U1;

    [u1,t1] = rcos(T1,beta); % Fun��o que simula o impulso descrito no enunciado Pb(t)
    u1 = U1 * u1;

    [u2,t2] = rcos(T2,beta); % Fun��o que simula o impulso descrito no enunciado Pb(t)
    u2 = U2 * u2;

    t1=t1+T1/2;
    t2=t2*alpha;
    t2=t2+T2/2+T1;
    t2=t2+0.001;

    tempo = [t1;t2];
    simin = [tempo,[u1; u2]];
    sim('sis', tempo)

    figure;
    hold on;
    plot(tempo,simout,'b');
    plot(tempo,simout1,'r');
    plot(tempo,zeros(length(tempo)),'g');
    legend('y(t)','y''(t)');
    title(['Alpha=',num2str(alpha),'   Beta=0']);
    hold off;

    figure;
    hold on;
    plot(simout,simout1,'b');
    plot(simout(1),simout1(1),'go');
    plot(simout(end),simout1(end),'ro');
    plot(0,0,'rx');
    legend('(y,y'')','Estado inicial','Estado final','Estado final pretendido');
    title(['Alpha=',num2str(alpha),'   Beta=0']);
    hold off;

end

%% Conclus�o: A estrat�gia de actua��o �ptima � tal que se adopte alpha = 1 e beta = 0



%% Ex 3 - Simula��o de uma vers�o perturbada do sistema com a = 0.99 e b = 0.1
%Estudo por simula��o, da depend�ncia do erro de posi��o/velocidade final
% em fun��o de alpha e de beta para sinais de controlo projectados para o
% sistema nominal.
%Crit�rio de Custo: (em fun��o da dura��o do sinal de controlo e do
%respectivo erro.

%%

vbeta = [0:0.5:1];
valpha = [0.5:0.5:1.5];

simouts = []; % vector onde s�o inseridas todos os vectores de velocidade 
% (simout) velocidades de todas as simula��es efectuadas de que ir� ser
% mais tarde usado na pergunta 3 por forma a avaliar


alpha = 1;
for beta = vbeta

    T1 = 1+beta;
    T2= alpha * T1;
    U1 = -2/(T1 * (1 + alpha)); % Rela��o descoberta analiticamente entre U1 e T1
    U2 = -U1;

    [u1,t1] = rcos(T1,beta); % Fun��o que simula o impulso descrito no enunciado Pb(t)
    u1 = U1 * u1;

    [u2,t2] = rcos(T2,beta);
    u2 = U2 * u2;

    t1=t1+T1/2;
    t2=t2*alpha;
    t2=t2+T2/2+T1;
    t2=t2+0.001;

    tempo = [t1; t2];
    simin = [tempo,[u1; u2]];
    sim('sis2', tempo);

    figure;
    hold on;
    plot(tempo,simout,'b');
    plot(tempo,simout1,'r');
    plot(tempo,zeros(length(tempo)),'g');
    legend('y(t)','y''(t)');
    title(['Sistema com perturba��es para Alpha=1 ;',' Beta=',num2str(beta)]);
    hold off;

    figure;
    hold on;
    plot(simout,simout1,'b');
    plot(simout(1),simout1(1),'go');
    plot(simout(end),simout1(end),'ro');
    plot(0,0,'rx');
    title(['Sistema com perturba��es para Alpha=1 ;',' Beta=',num2str(beta)]);
    legend('(y,y'')','Estado inicial','Estado final','Estado final pretendido');
    hold off;
end


beta = 0;
i=0;
for alpha = valpha

    T1 = 1+beta;
    T2= alpha * T1;
    U1 = -2/(T1 * (1 + alpha)); % Rela��o descoberta analiticamente entre U1 e T1
    U2 = -U1; 

    [u1,t1] = rcos(T1,beta); % Fun��o que simula o impulso descrito no enunciado Pb(t)
    u1 = U1 * u1;

    [u2,t2] = rcos(T2,beta);
    u2 = U2 * u2;

    t1=t1+T1/2;
    t2=t2*alpha;
    t2=t2+T2/2+T1;
    t2=t2+0.001;

    tempo = [t1;t2];
    simin = [tempo,[u1; u2]];
    sim('sis2', tempo)

    figure;
    hold on;
    plot(tempo,simout,'b');
    plot(tempo,simout1,'r');
    plot(tempo,zeros(length(tempo)),'g');
    legend('y(t)','y''(t)');
    title(['Sistema com perturba��es para Alpha=',num2str(alpha),'   Beta=0']);
    hold off;

    figure;
    hold on;
    plot(simout,simout1,'b');
    plot(simout(1),simout1(1),'go');
    plot(simout(end),simout1(end),'ro');
    plot(0,0,'rx');
    legend('(y,y'')','Estado inicial','Estado final','Estado final pretendido');
    title(['Sistema com perturba��es para Alpha=',num2str(alpha),'   Beta=0']);
    hold off;

end

%Conclus�o: Estrat�gia de actua��o �ptima para o sistema perturbado 
% Estrat�gia de actua��o:
% se custo for esfor�o gasto pelo bra�o que l� o disco ent�o ele ir� estar relacionado com a acelera��o
% porque For�a = acelera��o (� parte da massa que � apenas uma constante, um factor multiplicativo)
% pelo que o que o facto de ser uma acelera��o grande (neste caso negativa) 
% para parar o bra�o, que demora menos tempo e por conseguinte um maior sinal de controlo 
% ou uma acelera��o pequena para parar que demora mais tempo o que exige um menor sinal de controlo

%% Ex. 5
% 

xmin = -10;
xmax = 10;
ymin = -10;
ymax = 10;


alpha=1;
beta=0;
k_values=[-5 -1 0.0001 1 .1 10]

for k=k_values

    k_ref=k/2; %valor a ser usado para identifica��o do ponto de comuta��o

    sim('sis5');
    
    figure;
    hold on;
    plot(tout,y,'b');
    plot(tout,dy,'r');
    plot(tout,u,'g');
    legend('y(t)','y''(t)','Sinal de controlo');
    title(['y(0)=',num2str(k)]);
    hold off;

    figure;
    hold on;
    plot(y,dy,'b');
    plot(y(1),dy(1),'go');
    plot(y(end),dy(end),'ro');
    plot(0,0,'rx');
    
    legend('(y,y'')','Estado inicial','Estado final','Estado final pretendido');
    title(['y(0)=',num2str(k)]);
    hold off;

end

%%
%A observa��o de chattering n�o � evidente, no entanto pudemos observar que
%o sistema de malha fechada levou sempre o estado final para o pretendido.
%Este sistema seria mais eficaz que o anterior de malha aberta face a
%perturba��es em a e b 
%


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

k = [10];
k_ref = k/2;
sim('sis5');
response = responsetime(tout', dy', vel_tolerance)
t_sis_chattering = response(2) % tempo de resposta com sistema com chattering

sim('no_chattering');
response = responsetime(tout', vel', vel_tolerance)
t_non_lin = response(2) % tempo de resposta com subsistema melhorado (n�o linear)


sim('no_chattering_linearsubsys');
response = responsetime(tout', vel',vel_tolerance)
t_lin = response(2) % tempo de resposta com subsistema linear
% Um tempo de resposta maior corresponde a uma solu��o pior, dado que se
% pretende minimizar o tempo de deslocamento da cabea�a do disco

% Analisando os sinais de controlo no tempo de ambos os subsistemas (melhorado e linear),
% nota-se que a amplitude deste sinal no subsistema melhorado � muito
% inferior � amplitude no subsistema linear.

% Por outro lado, comparando com o sistema da alinea 5, notamos que o tempo
% da resposta � inferior ao dos outros dois sistemas.

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