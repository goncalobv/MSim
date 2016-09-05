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
C = [1 0];  %pretende-se apenas a saída theta
D = [0];
U = [0 0];

%Representação dos gráficos
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
C = [1 0]; %pretende-se apenas a saída theta
D = [0];

%Representação dos gráficos

H=ss(A,B,C,D);%definicao do sistema pelo espaco de estados
figure;
hold on;
bode(H);
title('Diagramas de Bode para L = L(200BPM)');
grid;


%simulação temporal para w(binário) = 5.24rad/s
% aproximadamente 100BPM
t = (linspace(0,100,10000))';
w = 5.24; %radianos por segundo
l = l_20;
J = 1/3*M*L^2 + m*l^2;

A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];
B = [0; 1/J];
C = [1 0 ; 0 1]; %pretende-se apenas a saída theta
D = [0; 0];

%Representação dos gráficos
U = [t sin(w*t)];
sim('metronomo_modelo_estado',t);
figure; hold on;
plot(t,U(:,2),'b'); axis([0 20 -20 20]); 
plot(t, Y.signals.values(:,1),'g');

%Retiram-se dois valores para obter o período das oscilações
[x_z,y_z]=ginput(2); somas = x_z(end)-x_z(1); med=somas/2; %2 periodos
freq1=2*pi/med; bpm1=(freq1/(2*pi))*60*2;

U(:,1)=U(:,1)*J;
sim('metronomo',t);
plot(t, theta(:,1),'r');

%Retiram-se dois valores para obter o período das oscilações
[x_z,y_z]=ginput(2); somas = x_z(end)-x_z(1); med=somas/2; %2 periodos
freq2=2*pi/med; bpm2=(freq2/(2*pi))*60*2;

ylabel('\theta/rad');xlabel('t/s'); grid on;
legend('Binário externo', 'Modelo linear', 'Modelo não linear');
title(['Evolução de \theta ao longo do tempo para w(binário)=',num2str(w),' rad/s\newlineLinear: \omega(\theta)=',num2str(freq1),'rad/s (',num2str(bpm1),' BPM) Não linear: \omega(\theta)=',num2str(freq2),'rad/s (',num2str(bpm2),' BPM)'])
hold off;


% simulação temporal para w(binário) = 0.524rad/s
% aproximadamente 10BPM

% aproximadamente 100BPM
t = (linspace(0,100,10000))'; 
w = 0.524;%radianos
l = l_20;
J = 1/3*M*L^2 + m*l^2;

A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];
B = [0; 1/J];
C = [1 0 ; 0 1]; %pretende-se apenas a saída theta
D = [0; 0];

%Representação dos gráficos
U = [t sin(w*t)];
sim('metronomo_modelo_estado',t);
figure; hold on;
plot(t,U(:,2),'b');
axis([0 100 -100 100]);
plot(t, Y.signals.values(:,1),'g')

%Retiram-se dois valores para obter o período das oscilações
[x_z,y_z]=ginput(2); somas = x_z(end)-x_z(1); med=somas/2; %2 periodos
freq1=2*pi/med; bpm1=(freq1/(2*pi))*60*2;

U(:,1)=U(:,1)*J;
sim('metronomo',t);
plot(t, theta(:,1),'r');

%Retiram-se dois valores para obter o período das oscilações
[x_z,y_z]=ginput(2); somas = x_z(end)-x_z(1); med=somas/2; %2 periodos
freq2=2*pi/med; bpm2=(freq2/(2*pi))*60*2;
ylabel('\theta/rad'); xlabel('t/s');grid on;
legend('Binário externo', 'Modelo linear', 'Modelo não linear');
title(['Evolução de \theta ao longo do tempo para w(binário)=',num2str(w),' rad/s\newlineLinear: \omega(\theta)=',num2str(freq1),'rad/s (',num2str(bpm1),' BPM) Não linear: \omega(\theta)=',num2str(freq2),'rad/s (',num2str(bpm2),' BPM)'])
hold off;

%%
% 
%  Em relação às simulações realizadas para a frequência de 5,24 rad/s (100BPM):
%
%  -- No modelo linear, o ganho em amplitude face à entrada foi G=8 --> G=18.07 dB
%  -- No modelo não linear este ganho foi G=3.5 --> G=10.881 dB
%  -- O ganho de amplitude em dB do diagrama de Bode é 6dB
%
%  A discrepância nestes valores é muito elevada
%
%  -- No modelo linear, a fase nas oscilações menores parecem estar em oposição de fase face à entrada
%  -- No modelo não linear, parece que entrada e saída estão em fase
%  -- Do diagrama de Bode, teríamos que a fase seria 180 graus (oposição de fase)
%
%  Os resultados não foram conclusivos
%
%  Em relação às simulações realizadas para a frequência de 0,524 rad/s (10BPM):
%
%  -- No modelo linear, o ganho em amplitude face à entrada foi G=75 --> G=37,5 dB
%  -- No modelo não linear este ganho é praticamente unitário, ou seja 0dB
%  -- O ganho de amplitude em dB do diagrama de Bode é 37,2dB
%
%  O modelo linear está em concordância com o diagrama de Bode, como esperado
%
%  -- No modelo linear, as oscilações estão em fase face à entrada
%  -- No modelo não linear, o mesmo ocorre
%  -- Do diagrama de Bode, teríamos que a fase seria 0 graus (entrada e saída em fase)
%
%  Os resultados estão de acordo com o esperado
%

%%
% 
%  Não faz sentido operar um metrónomo neste regime, pois não pretendemos aplicar um binário externo sinusoidal, apenas compensar o decaimento das
%  oscilações pontualmente, por exemplo nas passagens pela vertical, como se verá no exercício seguinte
%  Para além disto, as saídas obtidas com este binário não correspondem ao funcionamento oscilatório pretendido no uso de um metrónomo 
%
