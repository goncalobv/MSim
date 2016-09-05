%% Ex9

close all;
clear all;

%Dados do problema
L =0.2; M = 0.1; m = 0.5; k = 1; beta = 0.001; g=10;

l_200 = 0.080217; %posicao da massa para 20BPM   
l_20 = 0.176298; %posicao da massa para 200BPM   

x0 = [pi/16 0];

%20 BPM's
l = l_20;
J = 1/3*M*L^2 + m*l^2;
A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];
B = [0; 1/J];
C = [1 0];  %pretende-se apenas a sa�da theta
D = [0];
U = [0 0];

%Representa��o dos gr�ficos
H=ss(A,B,C,D); %definicao do sistema pelo espaco de estados
figure;
bode(H);
title('Diagramas de Bode para L = L(20BPM)');
grid;

%200 BPM's
l = l_200;
J = 1/3*M*L^2 + m*l^2;
A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];
B = [0; 1/J];
C = [1 0]; %pretende-se apenas a sa�da theta
D = [0];

%Representa��o dos gr�ficos

H=ss(A,B,C,D);%definicao do sistema pelo espaco de estados
figure;
hold on;
bode(H);
title('Diagramas de Bode para L = L(200BPM)');
grid;


%simula��o temporal para w(bin�rio) = 5.24rad/s
% aproximadamente 100BPM
t = (linspace(0,100,10000))';
w = 5.24; %radianos por segundo
l = l_20;
J = 1/3*M*L^2 + m*l^2;

A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];
B = [0; 1/J];
C = [1 0 ; 0 1]; %pretende-se apenas a sa�da theta
D = [0; 0];

%Representa��o dos gr�ficos
U = [t sin(w*t)];
sim('metronomo_modelo_estado',t);
figure; hold on;
plot(t,U(:,2),'b'); axis([0 20 -20 20]); 
plot(t, Y.signals.values(:,1),'g');

%Retiram-se dois valores para obter o per�odo das oscila��es
[x_z,y_z]=ginput(2); somas = x_z(end)-x_z(1); med=somas/2; %2 periodos
freq1=2*pi/med; bpm1=(freq1/(2*pi))*60*2;

U(:,1)=U(:,1)*J;
sim('metronomo',t);
plot(t, theta(:,1),'r');

%Retiram-se dois valores para obter o per�odo das oscila��es
[x_z,y_z]=ginput(2); somas = x_z(end)-x_z(1); med=somas/2; %2 periodos
freq2=2*pi/med; bpm2=(freq2/(2*pi))*60*2;

ylabel('\theta/rad');xlabel('t/s'); grid on;
legend('Bin�rio externo', 'Modelo linear', 'Modelo n�o linear');
title(['Evolu��o de \theta ao longo do tempo para w(bin�rio)=',num2str(w),' rad/s\newlineLinear: \omega(\theta)=',num2str(freq1),'rad/s (',num2str(bpm1),' BPM) N�o linear: \omega(\theta)=',num2str(freq2),'rad/s (',num2str(bpm2),' BPM)'])
hold off;


% simula��o temporal para w(bin�rio) = 0.524rad/s
% aproximadamente 10BPM

% aproximadamente 100BPM
t = (linspace(0,100,10000))'; 
w = 0.524;%radianos
l = l_20;
J = 1/3*M*L^2 + m*l^2;

A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];
B = [0; 1/J];
C = [1 0 ; 0 1]; %pretende-se apenas a sa�da theta
D = [0; 0];

%Representa��o dos gr�ficos
U = [t sin(w*t)];
sim('metronomo_modelo_estado',t);
figure; hold on;
plot(t,U(:,2),'b');
axis([0 100 -100 100]);
plot(t, Y.signals.values(:,1),'g')

%Retiram-se dois valores para obter o per�odo das oscila��es
[x_z,y_z]=ginput(2); somas = x_z(end)-x_z(1); med=somas/2; %2 periodos
freq1=2*pi/med; bpm1=(freq1/(2*pi))*60*2;

U(:,1)=U(:,1)*J;
sim('metronomo',t);
plot(t, theta(:,1),'r');

%Retiram-se dois valores para obter o per�odo das oscila��es
[x_z,y_z]=ginput(2); somas = x_z(end)-x_z(1); med=somas/2; %2 periodos
freq2=2*pi/med; bpm2=(freq2/(2*pi))*60*2;
ylabel('\theta/rad'); xlabel('t/s');grid on;
legend('Bin�rio externo', 'Modelo linear', 'Modelo n�o linear');
title(['Evolu��o de \theta ao longo do tempo para w(bin�rio)=',num2str(w),' rad/s\newlineLinear: \omega(\theta)=',num2str(freq1),'rad/s (',num2str(bpm1),' BPM) N�o linear: \omega(\theta)=',num2str(freq2),'rad/s (',num2str(bpm2),' BPM)'])
hold off;

%%
% 
%  Em rela��o �s simula��es realizadas para a frequ�ncia de 5,24 rad/s (100BPM):
%
%  -- No modelo linear, o ganho em amplitude face � entrada foi G=8 --> G=18.07 dB
%  -- No modelo n�o linear este ganho foi G=3.5 --> G=10.881 dB
%  -- O ganho de amplitude em dB do diagrama de Bode � 6dB
%
%  A discrep�ncia nestes valores � muito elevada
%
%  -- No modelo linear, a fase nas oscila��es menores parecem estar em oposi��o de fase face � entrada
%  -- No modelo n�o linear, parece que entrada e sa�da est�o em fase
%  -- Do diagrama de Bode, ter�amos que a fase seria 180 graus (oposi��o de fase)
%
%  Os resultados n�o foram conclusivos
%
%  Em rela��o �s simula��es realizadas para a frequ�ncia de 0,524 rad/s (10BPM):
%
%  -- No modelo linear, o ganho em amplitude face � entrada foi G=75 --> G=37,5 dB
%  -- No modelo n�o linear este ganho � praticamente unit�rio, ou seja 0dB
%  -- O ganho de amplitude em dB do diagrama de Bode � 37,2dB
%
%  O modelo linear est� em concord�ncia com o diagrama de Bode, como esperado
%
%  -- No modelo linear, as oscila��es est�o em fase face � entrada
%  -- No modelo n�o linear, o mesmo ocorre
%  -- Do diagrama de Bode, ter�amos que a fase seria 0 graus (entrada e sa�da em fase)
%
%  Os resultados est�o de acordo com o esperado
%

%%
% 
%  N�o faz sentido operar um metr�nomo neste regime, pois n�o pretendemos aplicar um bin�rio externo sinusoidal, apenas compensar o decaimento das
%  oscila��es pontualmente, por exemplo nas passagens pela vertical, como se ver� no exerc�cio seguinte
%  Para al�m disto, as sa�das obtidas com este bin�rio n�o correspondem ao funcionamento oscilat�rio pretendido no uso de um metr�nomo 
%
