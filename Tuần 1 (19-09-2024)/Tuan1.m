clear
hc = 40; P = 0.016; k = 240; Ac = 1.6e-5;
h = 0.02; x = 0 : 0.02 : 0.1;
beta = hc*P/(k*Ac); aDiag = -2 - h^2 * beta;
Ts = 293; T(1) = 473; T(6) = 293;
cele = -h^2 * beta * Ts;

a = eye(4, 4) * aDiag;
for i = 1 : 3
    a(i, i + 1) = 1;
    a(i + 1, i) = 1;
end
c = [cele - T(1); cele; cele; cele - T(6)];

T(2:5) = a\c;

fprintf('The temperatures at the grid points are\n')
disp(T)
plot(x,T,'-* r')
xlabel('Distance (m)'); ylabel('Temperature (K)')
