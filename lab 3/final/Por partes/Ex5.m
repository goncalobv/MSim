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