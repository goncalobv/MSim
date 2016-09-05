% Cadeira de Modela��o e Simula��o
%
% 1� Trabalho de laborat�rio
% Simula��o b�sica em Matlab/Simulink
%
% Turno: 4� feira, das 9h �s 11h
%
% Elementos do grupo:
%     Gon�alo V�tor  N�73229
%     Catarina Cruz  N�73319
%     Diogo Br�s     N�68212

%% Ex. 1 - Simula��o do movimento livre de uma viatura
%
close all
clear all
v0 = [-1 +1];
y0 = 1;
stop_time = 10.0;
m = 50;
beta = [10 25 50];


vlegend = cell(1, size(beta, 2)*size(v0,2));
plegend = cell(1, size(beta, 2)*size(v0,2));
vdata = cell(1, size(beta, 2)*2);
pdata = cell(1, size(beta, 2)*2);
for i = 1:size(beta, 2),
    sim('carro');

    vdata{2*i-1} = t;
    vdata{2*i} = v;
    pdata{2*i-1} = t;
    pdata{2*i} = y;
    for z=1:size(v0, 2),
        vlegend{size(v0,2)*(i-1)+z} = sprintf('\\beta = %d Nms ^{-1}, v_{0} = %d ms ^{-1}', beta(i), v0(z));
        plegend{size(v0,2)*(i-1)+z} = sprintf('\\beta = %d Nms ^{-1}, v_{0} = %d ms ^{-1}, y_{0} = %d m', beta(i), v0(z), y0);
    end
end

figure(1);
plot(vdata{1:size(vdata,2)})
title(sprintf('Evolu��o da velocidade do carro ao longo do tempo, m = %d kg', m))
xlabel('tempo t/s')
ylabel('velocidade v/ms ^{-1}')
ylim([-1 +4])
legend(vlegend, 'location', 'NorthEast');


figure(2);
plot(pdata{1:size(pdata,2)})
title(sprintf('Evolu��o da posi��o do carro ao longo do tempo, m = %d kg', m))
xlabel('tempo t/s')
ylabel('posi��o y/m')
ylim([-6 +20])
legend(plegend, 'location', 'NorthEast');

% Os resultados obtidos tanto para a posi��o, como para a velocidade
% obtidos por simula��o est�o de acordo com os previstos teoricamente.

%% Ex. 2 - Simula��o de um modelo predador-presa
%
%% Ex2.2

%%
y=zeros(6,1);
M1=[1   1   1   1;
    1   1   1   1;
    -1 -1  -1  -1;
    1   1   1   1; 
    1   1   1   1; 
    1  1.1 0.5 0.1];

M2=[1    1    1   1;
    1    1    1   1;
   -2   -2   -3  -3;
    2    4    6   6; 
    1    3    4   9; 
    1    3    4   9];

% As colunas de M1/M2 correspondem aos valores dos par�metros a fornecer
% � simula��o. Iterar pelas colunas da matriz fornece ent�o os v�ros
% exemplos necess�rios
%
% As primeiras duas linhas correspondem a alfa1 e alfa2, que neste
% exerc�cio devem ser mantidos a 1

for y=M1
    
    alpha1=y(1);alpha2=y(2);delta1=y(3);delta2=y(4);N1_0=y(5);N2_0=y(6);
    options = simset('SrcWorkspace','current');
    sim('function_teste',[],options);

    figure;
    hold on;

    plot(tout,n1,'b');
    plot(tout,n2,'g');

    title(['Modelo predador presa (2.2) - varia��o das condi��es iniciais\newline\alpha_1=',num2str(alpha1),'   \alpha_2=',num2str(alpha2),'  \delta_1=',num2str(delta1),'   \delta_2=',num2str(delta2),'   N_1(0)=',num2str(N1_0),'   N_2(0)=',num2str(N2_0),'   Ponto de Equil�brio: N_1=',num2str(-delta1/alpha1),' ;  N_2=',num2str(delta2/alpha2)]);
    legend('N_1','N_2');

    m=max(max(n1),max(n2))+1;
    axis([0 10 0 m]);

    xlabel('Time (t)');
    ylabel('N_1 / N_2');

    hold off;

end
%%
%
% A partir dos primeiros gr�ficos, pode concluir-se o seguinte
% 
% * Quando ambas as condi��es iniciais correspondem ao equil�brio, as popula��es nunca oscilam e mant�m sempre o equil�brio (assumimos que n�o h� perturba��es), tal como esperado
% * Ao "desequilibrar" uma das condi��es iniciais, as popula��es passam a seguir um modelo oscilat�rio, sendo que o aumento da amplitude das popula��es torna mais vis�vel a varia��o lenta perto dos m�nimos e r�pida perto dos m�ximos, tal como esperado da an�lise te�rica
% * Ao manter um dos valores iniciais no equil�brio, o outro valor inicial passa a definir o m�ximo ou o m�nimo, conforme acima ou abaixo do valor de equil�brio, respectivamente

%%
for y=M2
    
    alpha1=y(1);alpha2=y(2);delta1=y(3);delta2=y(4);N1_0=y(5);N2_0=y(6);
    options = simset('SrcWorkspace','current');
    sim('function_teste',[],options);

    figure;
    hold on;

    plot(tout,n1,'b');
    plot(tout,n2,'g');

    title(['Modelo predador presa (2.2) - varia��o dos pontos de equil�brio/m�ximos/m�nimos\newline\alpha_1=',num2str(alpha1),'   \alpha_2=',num2str(alpha2),'  \delta_1=',num2str(delta1),'   \delta_2=',num2str(delta2),'   N_1(0)=',num2str(N1_0),'   N_2(0)=',num2str(N2_0),'   Ponto de Equil�brio: N_1=',num2str(-delta1/alpha1),' ;  N_2=',num2str(delta2/alpha2)]);
    legend('N_1','N_2'); 

    m=max(max(n1),max(n2))+1;
    axis([0 10 0 m]);

    xlabel('Time (t)');
    ylabel('N_1 / N_2');

    hold off;

end

%%
% 
% Nestes exemplos podem ver-se essencialmente os efeitos da varia��o dos par�metros alfa e delta em particular, mantendo as condi��es iniciais iguais.
% 
% * � de notar o afastamento das solu��es com o afastamento dos valores de delta, o que demontra a depend�ncia directa entre este par�metro e o valor de equil�brio (mantendo alfa constante)
% * Entre os dois �ltimos gr�ficos pode notar-se a diferen�a das amplitues face � varia��o simult�nea das condi��es iniciais
% * O primeiro caso representa uma situa��o em que o valor inicial � superior ao valor de equil�brio da popula��o de presas e inferior ao da popula��o de predadores
% * No segundo caso o valor inicial � superior a ambos os pontos de equil�brio)

%%
% 
% Em rela��o ao gr�fico obtido em 2.1, podemos verificar a semelhan�a na
% forma da varia��o das popula��es, fazendo-se uma compara��o directa
% com o primeiro do segundo grupo de figuras, pois os valores utilizados
% para os par�metros s�o os mesmos. 
% 

%% Ex2.3 - a)

%%

%Tentativa 1
y1=[1.2;1.2;-1.2;2.3;10;10]; 

%Tentativa 2
y2=[1.2;1.2;-1.2;2.3;1.9167;10]; 

%Tentativa 3
y3=[0.6;1.2;-1.2;2.3;1.9167;10]; 

%Tentativa 4
y4=[0.55;1.2;-1.2;2.3;1.9167;10]; 

y=zeros(6,1);
M=[y1 y2 y3 y4];

for y=M

    alpha1=y(1);alpha2=y(2);delta1=y(3);delta2=y(4);N1_0=y(5);N2_0=y(6);
       
    load('presas.mat');
    options = simset('SrcWorkspace','current');
    sim('function_teste', tr,options);

    figure;
    hold on;

    plot(tout,n1,'b');
    plot(tout,n2,'g');
    plot(tr,yr,'r');

    title(['Modelo predador presa (2.3) - C�lculo de modelo por tentativa\newline\alpha_1=',num2str(alpha1),'   \alpha_2=',num2str(alpha2),'  \delta_1=',num2str(delta1),'   \delta_2=',num2str(delta2),'   N_1(0)=',num2str(N1_0),'   N_2(0)=',num2str(N2_0),'\newlinePonto de Equil�brio: N_1=',num2str(-delta1/alpha1),' ;  N_2=',num2str(delta2/alpha2)]);
    legend('N_1','N_2','N_2(file)');

    m=max(max(n1),max(n2))+1;
    axis([0 20 0 m]);

    xlabel('Time (t)');
    ylabel('N_1 / N_2');

    hold off;
    
end

%%
%
% Figura 9: 
% Ap�s observa��o dos valores fornecidos come�ou por escolher-se os par�metros alfa1 e a condi��o inicial dos predadores iguais aos valores conhecidos das presas
% 
% Figura 10: 
% De seguida, sendo o m�ximo dos valores observados 10, tal como o valor inicial da popula��o de presas, baixou-se o valor inicial da popula��o de predadores para igualar o ponto de equil�brio da popula��o das presas(em 2.1 e 2.2-a vimos que para que a condi��o inicial de uma popula��o seja um extremo, a condi��o inicial da popula��o concorrente deve ser o ponto de equil�brio da anterior)
% 
% Figura 11: 
% Variando alfa1 (passando por outros valores n�o exemplificados) concluiu-se que colocando o mesmo a metade de delta1, as popula��es dada e calculada come�am a sobrep�r-se
% 
% Figura 12: 
% De forma a optimizar a sobreposi��o nas primeiras arcadas, variou-se ligeiramente alfa1 no sentido anterior; no entanto, ambas �ltimas figuras representam uma sobreposi��o adequada dos valores fornecidos e do modelo calculado
% 
% 
% O m�nimo encontrado por tentativa e erro ocorre em alfa1 = 0.55  and N1(0) = 1.9167
       

%% Ex2.3 - b)
%%

n2=zeros(1,101);
yr=zeros(1,101);

[X,Y] = meshgrid(2:((2.9-2)/20):2.9, 0.56:((0.58-0.56)/20):0.58); 
s=size(X);
l=s(1);
c=s(2);
E=zeros(l,c);

for i=1:1:l
    for j=1:1:c
        
        y=[X(i,j) Y(i,j)];
        E(i,j)=func_error(y);

    end
   
    %tempo_restante = waitbar(i/l);
    
end
figure;
h=surf(X,Y,E);
[x_b,y_b]=find(E==min(min(E)));

title('Error surface');
xlabel('N_1(0)');
ylabel('\alpha_1');
zlabel('Error');
%shading interp;


%% Ex2.3 - c)

%%
x0=[1.9167 0.55];
options = optimset('TolX',1e-12);
[x_c,fval_c] = fminsearch(@func_error,x0,options);
  
%% Ex2.3 - d)

%%

  
    alpha1=Y(x_b,y_b);
    alpha2=1.2;
    delta1=-1.2;
    delta2=2.3;
    N1_0=X(x_b,y_b);
    N2_0=10;

  load('presas.mat');
  options = simset('SrcWorkspace','current');
  sim('function_teste', tr,options);

  figure;
  hold on;

  plot(tout,n2,'g');
  plot(tr,yr,'ro');

   title(['Modelo predador presa (2.3)- (b/d) Solu��o de modelo por m�nimo de superf�cie\newline\alpha_1=',num2str(alpha1),' \alpha_2=',num2str(alpha2),' \delta_1=',num2str(delta1),' \delta_2=',num2str(delta2),' N_1(0)=',num2str(N1_0),' N_2(0)=',num2str(N2_0),'\newlinePonto de Equil�brio: N_1=',num2str(-delta1/alpha1),' ; N_2=',num2str(delta2/alpha2)]);
   legend('N_2','N_2(file)');

  m=max(max(n1),max(n2))+1;
  axis([0 20 0 m]);

  xlabel('Time (t)');
  ylabel('N_1 / N_2');

  E(x_b,y_b);
  hold off;
  
    
 %%
 %
 % O m�nimo com ciclos for � 12.1014 alfa1 = 0.5710 e N1(0) = 2.5850
 %
 %%

    alpha1=x_c(2);
    alpha2=1.2;
    delta1=-1.2;
    delta2=2.3;
    N1_0=x_c(1);
    N2_0=10;

  load('presas.mat');
  options = simset('SrcWorkspace','current');
  sim('function_teste', tr,options);

  figure;
  hold on;

  plot(tout,n2,'g');
  plot(tr,yr,'ro');

  title(['Modelo predador presa (2.3) - (c/d) Solu��o de modelo por optimiza��o de procura\newline\alpha_1=',num2str(alpha1),' \alpha_2=',num2str(alpha2),' \delta_1=',num2str(delta1),' \delta_2=',num2str(delta2),' N_1(0)=',num2str(N1_0),' N_2(0)=',num2str(N2_0),'\newlinePonto de Equil�brio: N_1=',num2str(-delta1/alpha1),' ; N_2=',num2str(delta2/alpha2)]);
  legend('N_2','N_2(file)');

  m=max(max(n1),max(n2))+1;
  axis([0 20 0 m]);

  xlabel('Time (t)');
  ylabel('N_1 / N_2');

  hold off;
  
 %%
 %
 % O m�nimo do erro atrav�s de optimiza��o �  12.0533 para alfa1 = 0.5715 e
 % N1(0) = 2.5740
 %
%%
%
% Os valores obtidos foram muito semelhantes para ambas as al�neas. No
% entanto, o segundo m�todo � mais eficiente, visto que o primero envolve a
% escolha de uma grelha e diminui��o da mesma por observa��o, e a procura
% do m�nimo na matriz de erro resultante. Esta simula��o com o uso dos ciclos 'for'
% � um processo demorado e com tempo de c�lculo para cada matriz a evoluir 
% quadraticamente com as dimens�es da mesma.
%


       
%% Ex. 3.2 - Sistema ca�tico
% 
% NOTA: a simula��o � corrida a partir das equa��es diferenciais das
% vari�veis de estado
clear all
close all
m = 50;
m1 = m;
m2 = m;
l = 1;
l1 = l;
l2 = l;
g = 10;
p10 = 0;
p20 = 0;
teta10 = 25*pi/180;
teta20 = 25*pi/180;
load_system('sis_caotico.mdl');
% a simula��o deve ser posta a correr com t_disc(3) para abranger
% todos os tempos
set_param(gcs, 'StopTime', '10');
sim('sis_caotico');
subplot(2,1,1)
plot(teta1*180/pi, teta2*180/pi)
xlabel('\theta_{1}')
ylabel('\theta_{2}')
title('Descri��o de (\theta_{1}, \theta_{2}) ao longo do movimento')
subplot(2,1,2)
plot(x1,y1,x2,y2)
xlabel('coordenada x')
ylabel('coordenada y')
title('(x,y) posi��o de m_{1} e m_{2}')
legend('m_{1}','m_{2}')


%% Ex. 3.4 - Sistema ca�tico
% 
% NOTA: a simula��o � corrida a partir das equa��es diferenciais das
% vari�veis de estado
%
% Legenda da barra de cores
% 0 - n�o ocorre looping
% i - looping occore at� ao instante definido por t_disc(i)

clear all
close all
m = 50;
m1 = m;
m2 = m;
l = 1;
l1 = l;
l2 = l;
g = 10;
p10 = 0;
p20 = 0;
% tempo discretizado
t_disc =[10*sqrt(l/g), 10^2*sqrt(l/g), 10^3*sqrt(l/g)];
i = 0;
j = 0;
angleMin = -3.5;
angleMax = 3.5;
angleStep = .5;

for teta10 = angleMin:angleStep:angleMax,
    i= i+1;
    for teta20 = angleMin:angleStep:angleMax,
        j = j+1;
        load_system('sis_caotico_simples.mdl');
        % a simula��o deve ser posta a correr com t_disc(3) para abranger
        % todos os tempos
        set_param(gcs, 'StopTime', num2str(round(t_disc(3))));
        sim('sis_caotico_simples');
        first_loop_time = getFirstLoopTime(t, teta1, teta2);
        if(isnan(first_loop_time))
            first_loop_time = Inf;
        end
        index = find(t_disc>first_loop_time, 1);
        if(isempty(index))
            index = 0;
        end
        X(i,j) = teta10;
        Y(i,j) = teta20;
        C(i,j) = index;
    end
    j=0;
end
pcolor(X,Y,C);
colormap(gray(4));
colorbar
title('Tempo discretizado ao fim do qual ocorre o primeiro looping, dados \theta_{10} e \theta_{20}');
xlabel('\theta_{10}');
ylabel('\theta_{20}');
% e interessante notar que a matriz C obtida � sim�trica por rota��o de 180
% graus; dada a geometria do problema (que apresenta um eixo de simetria
% segundo x=0), tal seria expect�vel, ou seja, o tempo do primeiro loop
% para (teta10, teta20) � igual ao tempo para (-teta10, -teta20).
% isequal(rot90(C,2),C) % da como resultado o valor 1
