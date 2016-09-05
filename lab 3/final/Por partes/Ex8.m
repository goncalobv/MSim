%% Ex8

close all; clear all;

%Dados do problema
L = .2; M = .1; beta = .001; g = 10; k=1; m=0.5; 
l1=0.080217; l2=0.176298;

%Itera��o por v�rios �ngulos de deflex�o iniciais
for x01=[pi/16 pi/6 pi/3]
x0 = [x01 0];
    
%Para 200 BPM
l=l1;
J = 1/3*M*L^2 + m*l^2; U = [0 0];
A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];
B = [0; 1/J]; C = [1 0; 0 1]; D = [0; 0];


%Simula��o do modelo linear:
sim('metronomo_modelo_estado');
figure; hold on;
plot(tout, Y.signals.values(:,1),'b'); 
axis([0 2 min(Y.signals.values(:,1)) max(Y.signals.values(:,1))]);
ylabel('\theta/rad'); xlabel('t/s'); grid on;

%Retiram-se dois valores para obter o per�odo das oscila��es
[x_z1,y_z1]=ginput(2); somas1 = x_z1(end)-x_z1(1);med1=somas1/2; %2 periodos
freq1=2*pi/med1; bpm1=(freq1/(2*pi))*60*2;

%Simula��o do modelo n�o linear:
sim('metronomo');
plot(tout, theta(:,1),'r');
axis([0 2 min(theta(:,1)) max(theta(:,1))]);
ylabel('\theta/rad');xlabel('t/s');grid on;

%Retiram-se dois valores para obter o per�odo das oscila��es
[x_z2,y_z2]=ginput(2); somas2 = x_z2(end)-x_z2(1);med2=somas2/2;
freq2=2*pi/med2;bpm2=(freq2/(2*pi))*60*2;

title(['Evolu��o de \theta ao longo do tempo para ',num2str(l),'  \theta_{0}=',num2str(x01)])
legend(['Linear: ',num2str(freq1),'rad/s (', num2str(bpm1) ,' BPM)'],['N�o linear: ', num2str(freq2) ,'rad/s (', num2str(bpm2) ,' BPM)' ]);
hold off;


%Para 20 BPM
l=l2;
J = 1/3*M*L^2 + m*l^2; U = [0 0];
A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];
B = [0; 1/J]; C = [1 0; 0 1]; D = [0; 0];


%Simula��o do modelo linear:
sim('metronomo_modelo_estado');
figure; hold on;
plot(tout, Y.signals.values(:,1),'b');
axis([0 10 min(Y.signals.values(:,1)) max(Y.signals.values(:,1))]);
ylabel('\theta/rad');xlabel('t/s');grid on;

%Retiram-se dois valores para obter o per�odo das oscila��es
[x_z1,y_z1]=ginput(2);somas1 = x_z1(end) - x_z1(1); med1=somas1/1; 
freq1=2*pi/med1; bpm1=(freq1/(2*pi))*60*2;

%Simula��o do modelo n�o linear:
sim('metronomo');
plot(tout, theta(:,1),'r');
axis([0 10 min(theta(:,1)) max(theta(:,1))]);
ylabel('\theta/rad');xlabel('t/s');grid on;

%Retiram-se dois valores para obter o per�odo das oscila��es
[x_z2,y_z2]=ginput(2); somas2 = x_z2(end) - x_z2(1); med2=somas2/1;
freq2=2*pi/med2; bpm2=(freq2/(2*pi))*60*2;

title(['Evolu��o de \theta ao longo do tempo para ',num2str(l),'  \theta_{0}=',num2str(x01)])
legend(['Linear: ',num2str(freq1),'rad/s (', num2str(bpm1) ,' BPM)'],['N�o linear: ', num2str(freq2) ,'rad/s (', num2str(bpm2) ,' BPM)' ]);
hold off;

end

%%
% 
%  Confirmou-se o dimensionamento realizado por simula��o (a primeira linear realizada permite aferir a frequ�ncia), tendo as frequ�ncias medidas
%  sido muito pr�ximas das pretendidas.
% 
%  Foi realizada tamb�m uma compara��o entre o modelo linearizado e o modelo n�o linear do sistema para diferentes �ngulos de deflex�o
%  iniciais, tendo-se retirado as seguintes conclus�es:
%
%  -- Para frequ�ncias de oscila��o mais lentas, a discrep�ncia entre modelos � bastante mais relevante
%  -- Com o aumento do �ngulo de deflex�o, tamb�m a diferen�a entre modelos � mais vis�vel
%
%  Estas conclus�es est�o de acordo com o esperado, tendo em conta que para um mesmo per�odo de tempo a n�o linearidade � mais vis�vel em oscila��es 
%  mais espa�adas temporalmente, e que para um �ngulo de deflex�o maior, que pressup�e maior "dist�ncia" percorrida entre extremos, tamb�m a n�o 
%  linearidade tem mais efeito
%