beta = 0.5;
alpha = 1.5;
T1 = .5+beta;

U1 = -2/(T1 * (1+alpha));
U2 = -U1;

[u1,t1] = rcos(T1,beta);
u1 = U1 * u1;

[u2,t2] = rcos(alpha*T1,beta);
u2 = U2 * u2;

simin = [[t1 + T1/2;t2 + alpha*T1/2+T1],[u1; u2]]
     

sim('sis')