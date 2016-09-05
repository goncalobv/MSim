% Cadeira de Modelação e Simulação
%
% 3º Trabalho de laboratório
% Dinâmica de um metrónomo básico
%
% Turno: 4ª feira, das 9h às 11h
%
% Elementos do grupo:
%     Gonçalo Vítor  Nº73229
%     Catarina Cruz  Nº73319
%     Diogo Brás     Nº68212

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
title('Evolução de \theta ao longo do tempo')
ylabel('\theta/rad')
xlabel('t/s')
figure
plot(tout, omega)
title('Evolução de \omega ao longo do tempo')
ylabel('\omega/rad s^{-1}')
xlabel('t/s')
figure
plot(theta, omega)
title('Espaço de estados')
ylabel('\omega/rad s^{-1}')
xlabel('\theta/rad')