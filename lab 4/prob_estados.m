function prob_estados(Q,alfa)

E = ones(13);
P = alfa*Q+(1-alfa)/13*E;

%[V, D] = eig(P); 
% D matriz diagonal que cont�m os valores, V matriz cujas colunas s�o os vectores pr�prios

prob0 = 1/13*ones(13,1);
% k final - instante de tempo final da sim.
kfinal = 20;
% para um instante k
% k = 10;
% prob = prob0*P^k;
prob_index = meshgrid([1:13],[0:kfinal])';
time = meshgrid([0:kfinal],[1:13]);
prob_val = [];
for k=0:kfinal
    prob_val(:,k+1) = (prob0'*P^k)';
end

figure();
plot3(prob_index, time, prob_val)
axis([0 15 0 20 0 0.8])
xlabel('�ndice dos n�s')
ylabel('Tempo')
zlabel('Probabilidades')
title('Evolu��o das probabilidades ao longo do tempo')


end