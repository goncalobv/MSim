function prob_val = RunAndPlot(P, prob0, kfinal, title_var)
    % k final - instante de tempo final da sim.

    % para um instante k
    % k = 10;
    % prob = (prob0'*P^k);
    prob_index = meshgrid([1:length(prob0)],[0:kfinal])';
    time = meshgrid([0:kfinal],[1:length(prob0)]);

    prob_val = [];
    for k=0:kfinal
        prob_val(:,k+1) = (prob0'*P^k)';
    end
    plot3(prob_index, time, prob_val)
    xlabel('Índice dos nós')
    ylabel('Tempo')
    zlabel('Probabilidades')
    title(title_var)

    % verificar que para cada t a soma de prob_val é 1
    % remover ; para verificar!
    uns =  sum(prob_val); % é um vector de uns!
