%% Ex6.2
close all
clear all

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