% Cadeira de Modela��o e Simula��o
%
% 3� Trabalho de laborat�rio
% Din�mica de um metr�nomo b�sico
%
% Turno: 4� feira, das 9h �s 11h
%
% Elementos do grupo:
%     Gon�alo V�tor  N�73229
%     Catarina Cruz  N�73319
%     Diogo Br�s     N�68212

warning off

%% Ex4
close all
clear all

L = .4;
M = .1;
l = .3;
m = .4;
k = 5;
beta = .1;
g = 10;
J = 1/3*M*L^2 + m*l^2;

U = [0 0];
x0 = [pi/16 0];

sim('metronomo')
plot(tout, theta)
grid on;
title('Evolu��o de \theta ao longo do tempo')
ylabel('\theta/rad')
xlabel('t/s')
figure
plot(tout, omega)
grid on;
title('Evolu��o de \omega ao longo do tempo')
ylabel('\omega/rad s^{-1}')
xlabel('t/s')
figure
plot(theta, omega)
title('Espa�o de estados')
ylabel('\omega/rad s^{-1}')
xlabel('\theta/rad')

%% Ex5
close all
clear all

L = .4;
M = .1;
l = .3;
m = .4;
k = 5;
beta = .1;
g = 10;
J = 1/3*M*L^2 + m*l^2;

U = [0 0];
x0 = [pi/16 0];

A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];
B = [0; 1/J];
C = [1 0; 0 1];
D = [0; 0];
sim('metronomo_modelo_estado')
plot(tout, Y.signals.values(:,1))
grid on
title('Evolu��o de \theta ao longo do tempo')
ylabel('\theta/rad')
xlabel('t/s')

figure
plot(tout, Y.signals.values(:,2))
title('Evolu��o de \omega ao longo do tempo')
ylabel('\omega/rad s^{-1}')
xlabel('t/s')
grid on
% Para efeitos de simula��o a matriz C deve ser escolhida como a matriz
% identidade, pois permite uma visualiza��o mais directa das vari�veis de
% estado atrav�s das sa�das do sistema.



%% Ex6

close all;clear all;

%Dados do problema
L = .4; M = .1; l = .3; m = .4; k = 5; beta = .1; g = 10;
J = 1/3*M*L^2 + m*l^2;  U = [0 0];
x0 = [pi/16 0];

b = [0 1];

for i = 1:1:length(b)
    beta = b(i);
    A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];
    B = [0; 1/J];
    C = [1 0; 0 1];
    D = [0; 0];
    sim('metronomo_modelo_estado')
    figure;
 
    plot(tout, Y.signals.values(:,1));
    grid on;
    title('Evolu��o de \theta ao longo do tempo');
    ylabel('\theta/rad');
    xlabel('t/s');
    legend(['\beta = ', num2str(beta)]);
    figure;
    plot(tout, Y.signals.values(:,2));
    grid on;
    title('Evolu��o de \omega ao longo do tempo')
    ylabel('\omega/rad s^{-1}')
    xlabel('t/s')
    legend(['\beta = ', num2str(beta)]);
    figure
    plot(Y.signals.values(:,1), Y.signals.values(:,2))
    title('Espa�o de estados')
    ylabel('\omega/rad s^{-1}')
    xlabel('\theta/rad')
    legend(['\beta = ', num2str(beta)]);
end

%%
close all ;
clear all;

% Dados do problema
L = .4; M = .1; l = .3; m = .4; k = 5; g = 10;
J = 1/3*M*L^2 + m*l^2; U = [0 0];

b = [0 .1 1];
x01i = [pi/2 pi 3*pi/2];
x02i = [0 1 10];

for i = 1:1:length(b)
    figure
    hold on
    beta = b(i);
for c1 = 1:1:length(x01i) 
        for c2 = 1 : 1 : length(x02i)
            x0 = [x01i(c1) x02i(c2)];
            A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];
            B = [0; 1/J];
            C = [1 0; 0 1];
            D = [0; 0];
            sim('metronomo_modelo_estado')
            plot(Y.signals.values(:,1), Y.signals.values(:,2))
        end
end
    ylabel('\omega/rad s^{-1}')
    
    title(['Espa�o de estados para \beta = ',num2str(beta)]);
    
    minimo_1 = min(Y.signals.values(:,1)); % theta
    maximo_1 = max(Y.signals.values(:,1));
    minimo_2 = min(Y.signals.values(:,2)); % omega
    maximo_2 = max(Y.signals.values(:,2));
    
%Obten��o do campo de vectores:    
    x = linspace(minimo_1,maximo_1,21);
    y = linspace(minimo_2,maximo_2,21);
    [x, y] = meshgrid(x,y);
    
Px = [];
Py = [];
    for i1=1:size(x,1)
        for j=1:size(x,2)
        p = A * [x(i1,j); y(i1,j)];
        Px(i1,j) = p(1);
        Py(i1,j) = p(2);
        end
    end
    
    valores_proprios = eig(A);
    
    lambda1 = valores_proprios(1);
    lambda2 = valores_proprios(2);
    
    xlabel(['\theta/rad   \lambda_1=', num2str(lambda1),'  \lambda_2=',num2str(lambda2)])
    quiver(x, y, Px, Py);
 
    hold off
end

%%
% 
% Valores pr�prios reais implicam vectores pr�prios de componentes reais, represent�veis no plano como "rectas"
% 
% Como o modo temporal de theta � dado por exponenciais de expoente real bem como a sua derivada, teremos dois modos representados por cada um dos
% valores pr�prios e vectores pr�prios associados, que ir�o "atra�r" o movimento no plano de estados.
%
% Por este motivo, independentemente das condi��es iniciais, nos gr�ficos correspondentes a beta = 1, vemos as curvas tender para o mesmo segmento 
% de recta  
%
% 
% Com os valores pr�prios puramente imagin�rios as exponenciais que representam a varia��o temporal, ser�o invariantes em m�dulo, raz�o pela
% qual, para beta = 0, obtemos diferentes circunfer�ncias com m�dulo dependente da condi��o inicial
%
%
% Para beta = 0.1, temos uma conjuga��o de ambos os movimentos, observando-se a varia��o correspondente � parte imagin�ria, bem como um
% decaimento de m�dulo associado � parte real
%


%% Ex7

    %%
    %          
    % C�lculo exterior dos vectores pr�prios de A: [V1,D1] = eig(A);
    % Usamos ent�o estes valores como condi��es iniciais (primeiro) e (segundo) em que s� ir� 
    % ser vis�vel um modo e ainda um valor interm�dio (terceiro) para notar a diferen�a
    % [V1,D1] = eig(A)
    %     V1  =     0.2216   -0.0505
    %              -0.9751    0.9987
    % 
    
close all;clear all;

%Dados do problema
L = .4; M = .1; l = .3; m = .4; k = 5; g = 10;
J = 1/3*M*L^2 + m*l^2; U = [0 0];
b = [1]; 
         
beta = b(1);

primeiro = [0.2216 -0.9751];
segundo = [-0.0505 0.9987];
terceiro = (primeiro + segundo);

x = linspace(-5,0,21);
y = linspace(-19.7932,15,21);
[x, y] = meshgrid(x,y);
         
x01i = [primeiro(1) segundo(1) terceiro(1)];
x02i = [primeiro(2) segundo(2) terceiro(2)];

    figure
    hold on
    
    Px = [];
    Py = [];
vec = ['b' 'g' 'r' 'b']; %vector com as cores que ir�o ser usadas para representar
                         % cada curva

    
    eig_x=[-0.15:0.01:0.3];%vector de -0.15 com passos de 0.01 em 0.01 at� 0.3
    eig_y=eig_x*(-0.9751/0.2216);%vector pr�prio
    eig_y2=eig_x*(-0.9987/0.0505);%vector pr�prio
    plot(eig_x,eig_y,'k--'); %linhas a tracejado representam a direc��o do vector pr�prio
    plot(eig_x,eig_y2,'k--'); %linhas a tracejado representam a direc��o do vector pr�prio

    for c2 = 1 : 1 : length(x02i)
        x0 = [x01i(c2) x02i(c2)];
        A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];  B = [0; 1/J];
        C = [1 0; 0 1];     D = [0; 0];
        sim('metronomo_modelo_estado')
        plot(Y.signals.values(1,1), Y.signals.values(1,2),vec(c2),'Marker','o'); %marca��o do ponto inicial de cada curva
        plot(Y.signals.values(:,1), Y.signals.values(:,2),vec(c2),'LineWidth',2); %
        xlabel('\theta/rad');
    end
    for i1=1:size(x,1)
        for j=1:size(x,2) 
            p = A * [x(i1,j); y(i1,j)];
            Px(i1,j) = p(1);
            Py(i1,j) = p(2);
            
        end
    end

    ylabel('\omega/rad s^{-1}');
    title('Espa�o de estados');
    axis([-0.15 0.3 -2 2]);
    hold off

    %%
    % 
    %  
    % Neste gr�fico, a curva a verde e a curva azul (ambos segmentos de recta)
    % representam as condi��es iniciais igualadas ao primeiro e ao segundo
    % vector pr�prio da matriz A, respectivamente, e a curva a vermelho (n�o
    % linear) representa uma combina��o dos dois modos.
    % Assim, quaisquer condi��es iniciais que estejam sobre as rectas definidas
    % pelos vectores pr�prios (valores m�ltiplos de cada um dos vectores
    % pr�prios)conduzem a respostas que apenas apresentam um dos modos 
    % (resposta no espa�o de fase limitada a essas mesmas rectas). Por outro
    % lado, condi��es iniciais que n�o estejam sobre as rectas definidas pelos
    % vectores pr�prios, conduzem a respostas que s�o combina��es lineares dos
    % dois modos existentes (respostas n�o lineares no espa�o de fase).
    %
    % 
    
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

%% Ex10

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