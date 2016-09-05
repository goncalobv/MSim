%% Ex7

    %%
    %          
    % Cálculo exterior dos vectores próprios de A: [V1,D1] = eig(A);
    % Usamos então estes valores como condições iniciais (primeiro) e (segundo) em que só irá 
    % ser visível um modo e ainda um valor intermédio (terceiro) para notar a diferença
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
vec = ['b' 'g' 'r' 'b']; %vector com as cores que irão ser usadas para representar
                         % cada curva

    
    eig_x=[-0.15:0.01:0.3];%vector de -0.15 com passos de 0.01 em 0.01 até 0.3
    eig_y=eig_x*(-0.9751/0.2216);%vector próprio
    eig_y2=eig_x*(-0.9987/0.0505);%vector próprio
    plot(eig_x,eig_y,'k--'); %linhas a tracejado representam a direcção do vector próprio
    plot(eig_x,eig_y2,'k--'); %linhas a tracejado representam a direcção do vector próprio

    for c2 = 1 : 1 : length(x02i)
        x0 = [x01i(c2) x02i(c2)];
        A = [0 1;(M*g*L/2+m*g*l-k)/J -beta/J];  B = [0; 1/J];
        C = [1 0; 0 1];     D = [0; 0];
        sim('metronomo_modelo_estado')
        plot(Y.signals.values(1,1), Y.signals.values(1,2),vec(c2),'Marker','o'); %marcação do ponto inicial de cada curva
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
    title('Espaço de estados');
    axis([-0.15 0.3 -2 2]);
    hold off

    %%
    % 
    %  
    % Neste gráfico, a curva a verde e a curva azul (ambos segmentos de recta)
    % representam as condições iniciais igualadas ao primeiro e ao segundo
    % vector próprio da matriz A, respectivamente, e a curva a vermelho (não
    % linear) representa uma combinação dos dois modos.
    % Assim, quaisquer condições iniciais que estejam sobre as rectas definidas
    % pelos vectores próprios (valores múltiplos de cada um dos vectores
    % próprios)conduzem a respostas que apenas apresentam um dos modos 
    % (resposta no espaço de fase limitada a essas mesmas rectas). Por outro
    % lado, condições iniciais que não estejam sobre as rectas definidas pelos
    % vectores próprios, conduzem a respostas que são combinações lineares dos
    % dois modos existentes (respostas não lineares no espaço de fase).
    %
    % 
    