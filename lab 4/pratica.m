%%aula
P1 = [0 0 1; 0.5 0 0.5; 0 1 0]; 
P2 = [0 0 1; 0 0.5 0.5; 0 1 0]; 
P3 = [0 0 1; 1 0 0; 0 1 0];
P4 = [0 0.5 0.5 0 ; 0 0 0 1; 0 0 1 0; 0 0.5 0 0.5];
P = P4;

p = []
p = rand(1,size(P,1))
p = p/sum(p)

for i = 1: 100
    p = p*P
end
[V,D] = eig(P')
%find diag entry D(i,i) = 1
v = V(:,3)
v = v/(sum(v))

[V,D] = eig(P')
plot(diag(D),'*')

