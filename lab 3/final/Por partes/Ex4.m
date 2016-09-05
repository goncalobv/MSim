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
title('Evolu��o de \theta ao longo do tempo')
ylabel('\theta/rad')
xlabel('t/s')
figure
plot(tout, omega)
title('Evolu��o de \omega ao longo do tempo')
ylabel('\omega/rad s^{-1}')
xlabel('t/s')
figure
plot(theta, omega)
title('Espa�o de estados')
ylabel('\omega/rad s^{-1}')
xlabel('\theta/rad')