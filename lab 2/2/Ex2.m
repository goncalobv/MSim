%% excerc�cio 2 

% Simula��o do sistema de entradas compostas para diferentes valores de
% alpha e beta e posterior confirma��o, por tentativa e erro, dos
% resultados anal�ticos por observa��o dos gr�ficos.


% vbeta = [0:0.2:1]; % 0 <= beta <=1 beta poder� ser qualquer entre 0 e 1
% pelo que ach�mos por bem simular para 5 valores de beta distintos
%
% valpha = [0.5:0.5:3]; % alpha > 0; escolhemos um valor inicial em 0.5 
% visto que alpha n�o pode tomar o valor de 0.Resultando assim, de acordo
% com o nosso valor inicial, passo e valor final, 5 valores distintos de
% alpha.
% O valor final de alpha foi escolhido para avaliar como alpha evolui ap�s
% passar do valor favorito que era 1, para esta vari�vel
% 
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
simin = [tempo,[u1; u2]]
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

%% Conclus�o: A estrat�gia de actua��o �ptima � tal que se adopte alpha = 0.5? e beta = 1?



%% 3 Simula��o de uma vers�o perturbada do sistema com a = 0.99 e b = 0.1

% Estudo por simula��o, da depend�ncia do erro de posi��o/velocidade final
% em fun��o de alpha e de beta para sinais de controlo projectados para o
% sistema nominal.

%Crit�rio de Custo: (em fun��o da dura��o do sinal de controlo e do
%respectivo erro.


vbeta = [0:0.2:1];
valpha = [0.5:0.5:3];

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
simin = [tempo,[u1; u2]]
sim('sis2', tempo)

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

%%Conclus�o: Estrat�gia de actua��o �ptima para o sistema perturbado 
%� luz do Crit�rio de Custo estabelecido no princ�pio: 