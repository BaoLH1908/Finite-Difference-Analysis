clear
a = 0; b = 1;
N = 8; h = (b - a)/N;
x = a : h : b;
hDenom = 3 + 2*h;
aDia = 4 + h^2;
y(1) = 1;

A = eye(N - 2, N - 2) * aDia;
A(N - 1, N - 1) = aDia - 8/hDenom;
for i = 1:N-2
    A(i, i + 1) = -2;
    A(i + 1, i) = -2;
end

A(N - 1, N - 2) = 2/hDenom - 2;
c(1) = 2 + h^2*exp(-0.2*x(2));
c(2:N-1) = h^2*exp(-0.2*x(3:N));
y(2:N) = tridiagonal(A,c);
y(N + 1) = -1 * y(N - 1)/hDenom + 4 * y(N)/hDenom;

yExact = -0.2108.*exp(x./sqrt(2)) + 0.1238.*exp(-x./sqrt(2)) + exp(-0.2.*x)./0.92;

plot(x, y, '-*r', x, yExact, '-o b')
