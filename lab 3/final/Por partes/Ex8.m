%% Ex8

close all; clear all;

%Dados do problema
L = .2; M = .1; beta = .001; g = 10; k=1; m=0.5; 
l1=0.080217; l2=0.176298;

%Iteração por vários ângulos de deflexão iniciais
for x01=[pi/16 pi/6 pi/3]
x0 = [x01 0];
    
%Para 200 BPM
l=l1;
J = 1/3*M*L^2 + m*l^2; U = [0 0];
A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];
B = [0; 1/J]; C = [1 0; 0 1]; D = [0; 0];


%Simulação do modelo linear:
sim('metronomo_modelo_estado');
figure; hold on;
plot(tout, Y.signals.values(:,1),'b'); 
axis([0 2 min(Y.signals.values(:,1)) max(Y.signals.values(:,1))]);
ylabel('\theta/rad'); xlabel('t/s'); grid on;

%Retiram-se dois valores para obter o período das oscilações
[x_z1,y_z1]=ginput(2); somas1 = x_z1(end)-x_z1(1);med1=somas1/2; %2 periodos
freq1=2*pi/med1; bpm1=(freq1/(2*pi))*60*2;

%Simulação do modelo não linear:
sim('metronomo');
plot(tout, theta(:,1),'r');
axis([0 2 min(theta(:,1)) max(theta(:,1))]);
ylabel('\theta/rad');xlabel('t/s');grid on;

%Retiram-se dois valores para obter o período das oscilações
[x_z2,y_z2]=ginput(2); somas2 = x_z2(end)-x_z2(1);med2=somas2/2;
freq2=2*pi/med2;bpm2=(freq2/(2*pi))*60*2;

title(['Evolução de \theta ao longo do tempo para ',num2str(l),'  \theta_{0}=',num2str(x01)])
legend(['Linear: ',num2str(freq1),'rad/s (', num2str(bpm1) ,' BPM)'],['Não linear: ', num2str(freq2) ,'rad/s (', num2str(bpm2) ,' BPM)' ]);
hold off;


%Para 20 BPM
l=l2;
J = 1/3*M*L^2 + m*l^2; U = [0 0];
A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];
B = [0; 1/J]; C = [1 0; 0 1]; D = [0; 0];


%Simulação do modelo linear:
sim('metronomo_modelo_estado');
figure; hold on;
plot(tout, Y.signals.values(:,1),'b');
axis([0 10 min(Y.signals.values(:,1)) max(Y.signals.values(:,1))]);
ylabel('\theta/rad');xlabel('t/s');grid on;

%Retiram-se dois valores para obter o período das oscilações
[x_z1,y_z1]=ginput(2);somas1 = x_z1(end) - x_z1(1); med1=somas1/1; 
freq1=2*pi/med1; bpm1=(freq1/(2*pi))*60*2;

%Simulação do modelo não linear:
sim('metronomo');
plot(tout, theta(:,1),'r');
axis([0 10 min(theta(:,1)) max(theta(:,1))]);
ylabel('\theta/rad');xlabel('t/s');grid on;

%Retiram-se dois valores para obter o período das oscilações
[x_z2,y_z2]=ginput(2); somas2 = x_z2(end) - x_z2(1); med2=somas2/1;
freq2=2*pi/med2; bpm2=(freq2/(2*pi))*60*2;

title(['Evolução de \theta ao longo do tempo para ',num2str(l),'  \theta_{0}=',num2str(x01)])
legend(['Linear: ',num2str(freq1),'rad/s (', num2str(bpm1) ,' BPM)'],['Não linear: ', num2str(freq2) ,'rad/s (', num2str(bpm2) ,' BPM)' ]);
hold off;

end

%%
% 
%  Confirmou-se o dimensionamento realizado por simulação (a primeira linear realizada permite aferir a frequência), tendo as frequências medidas
%  sido muito próximas das pretendidas.
% 
%  Foi realizada também uma comparação entre o modelo linearizado e o modelo não linear do sistema para diferentes ângulos de deflexão
%  iniciais, tendo-se retirado as seguintes conclusões:
%
%  -- Para frequências de oscilação mais lentas, a discrepância entre modelos é bastante mais relevante
%  -- Com o aumento do ângulo de deflexão, também a diferença entre modelos é mais visível
%
%  Estas conclusões estão de acordo com o esperado, tendo em conta que para um mesmo período de tempo a não linearidade é mais visível em oscilações 
%  mais espaçadas temporalmente, e que para um ângulo de deflexão maior, que pressupõe maior "distância" percorrida entre extremos, também a não 
%  linearidade tem mais efeito
%