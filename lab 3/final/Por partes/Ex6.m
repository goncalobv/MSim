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
    figure
    plot(tout, Y.signals.values(:,1))
    title('Evolução de \theta ao longo do tempo')
    ylabel('\theta/rad')
    xlabel('t/s')
    legend(['\beta = ', num2str(beta)]);
    figure
    plot(tout, Y.signals.values(:,2))
    title('Evolução de \omega ao longo do tempo')
    ylabel('\omega/rad s^{-1}')
    xlabel('t/s')
    legend(['\beta = ', num2str(beta)]);
    figure
    plot(Y.signals.values(:,1), Y.signals.values(:,2))
    title('Espaço de estados')
    ylabel('\omega/rad s^{-1}')
    xlabel('\theta/rad')
    legend(['\beta = ', num2str(beta)]);
end
