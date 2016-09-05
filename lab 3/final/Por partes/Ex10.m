%%Ex10

close all; clear all;

%Para efeitos de compara��o, utilizam-se os valores do exerc�cio 8
x01=pi/16; L = .2; M = .1; beta = .001; k=1; m=0.5; g = 10;
x0 = [x01 0];
t=linspace(1,100,1000);
l1=0.080217; l2=0.176298;

%Para 200BPM:
l=l1; w=10.47;
J = 1/3*M*L^2 + m*l^2; U = [0 0];
A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];
B = [0; 1/J]; C = [1 0; 0 1]; D = [0; 0];

%Sem mecanismo de ajuste
sim('metronomo',t);
figure;
plot(tout, theta(:,1),'r');
axis([0 50 min(theta(:,1)) max(theta(:,1))])
ylabel('\theta/rad'); xlabel('t/s');grid on;
[x_z,y_z]=ginput(2);
somas = x_z(end)-x_z(1);
n = length(x_z) - 1;
med=somas/10; %2 periodos
freq=2*pi/med;
bpm=(freq/(2*pi))*60*2;
title(['Com compensa��o:Evolu��o de \theta ao longo do tempo para ',num2str(l),'\newline\theta_{0}=',num2str(x01),'    Frequ�nca calculada',num2str(freq),' rad/s ; ',num2str(bpm),'BPM'])

%Com mecanismo de ajuste
sim('metronomo10',t);
figure;
plot(tout, theta(:,1),'b');
axis([0 50 min(theta(:,1)) max(theta(:,1))])
ylabel('\theta/rad');xlabel('t/s');grid on;
[x_z,y_z]=ginput(2);
somas = x_z(end)-x_z(1);
n = length(x_z) - 1;
med=somas/10; %2 periodos
freq=2*pi/med;
bpm=(freq/(2*pi))*60*2;
title(['Com compensa��o:Evolu��o de \theta ao longo do tempo para ',num2str(l),'\newline\theta_{0}=',num2str(x01),'    Frequ�nca calculada',num2str(freq),' rad/s ; ',num2str(bpm),'BPM'])


%Para 20BPM:
l=l2; w=1.047;
J = 1/3*M*L^2 + m*l^2; U = [0 0];
x0 = [x01 0];
A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];
B = [0; 1/J]; C = [1 0; 0 1]; D = [0; 0];

%Sem mecanismo de ajuste
sim('metronomo',t);
figure;
plot(tout, theta(:,1),'r');
axis([0 100 min(theta(:,1)) max(theta(:,1))]);
ylabel('\theta/rad');xlabel('t/s');grid on;
[x_z,y_z]=ginput(2);
somas = x_z(end)-x_z(1);
n = length(x_z) - 1;
med=somas/10; %2 periodos
freq=2*pi/med;
bpm=(freq/(2*pi))*60*2;
title(['Com compensa��o:Evolu��o de \theta ao longo do tempo para ',num2str(l),'\newline\theta_{0}=',num2str(x01),'    Frequ�nca calculada',num2str(freq),' rad/s ; ',num2str(bpm),'BPM'])

%Com mecanismo de ajuste
sim('metronomo10',t);
figure;
plot(tout, theta(:,1),'b');
axis([0 100 min(theta(:,1)) max(theta(:,1))]);
ylabel('\theta/rad');xlabel('t/s');grid on;
[x_z,y_z]=ginput(2);
somas = x_z(end)-x_z(1);
n = length(x_z) - 1;
med=somas/10; %2 periodos
freq=2*pi/med;
bpm=(freq/(2*pi))*60*2;
title(['Com compensa��o:Evolu��o de \theta ao longo do tempo para ',num2str(l),'\newline\theta_{0}=',num2str(x01),'    Frequ�nca calculada',num2str(freq),' rad/s ; ',num2str(bpm),'BPM'])

%%
% 
%  Atrav�s de pequenos impulsos nas passagens pela vertical ( �ngulo de deflex�o = 0) no metr�nomo consegue contrariar-se o decaimento do
%  �ngulo; a amplitude que melhor se adequou em geral � dada em rela��o a J, sendo metade deste valor. Desta forma, para frequ�ncias em torno dos 20 BPM e
%  200 BPM obteve-se uma compensa��o razo�vel
% 
%  Verificou-se que a frequ�ncia de oscila��o pretendida n�o foi afectada significativamente por este mecanismo
%