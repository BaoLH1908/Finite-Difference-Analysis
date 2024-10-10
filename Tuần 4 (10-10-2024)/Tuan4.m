clc
clear
% 2D Elliptic PDE
Nx = 50; Ny = 50;
Lx = 1; Ly = 1;
% Grid
x = linspace(0, Lx, Nx);
y = linspace(0, Ly, Ny);
dx = x(2) - x(1);
dy = y(2) - y(1);
% Matrix M
N = Nx * Ny;
M = zeros(N, N); B = zeros(N, 1);
% Interior points
for i = 2 : Nx-1
    for j = 2 : Ny-1
        n = i + (j - 1) * Nx; % convert ij to nth grid point
        M(n, n) = -4;
        M(n, n-1) = 1;
        M(n, n+1) = 1;
        M(n, n-Nx) = 1;
        M(n, n+Nx) = 1;
        B(n, 1) = 0;
    end
end
% Boundary conditions (BCs)
% Left BC: phi = y
i = 1;
for j = 1 : Ny
    n = i + (j - 1)*Nx;
    M(n, n) = 1;
    B(n, 1) = y(j);
end
% Right BC: phi = 1 - y
i = Nx;
for j = 1 : Ny
    n = i + (j - 1)*Nx;
    M(n, n) = 1;
    B(n, 1) = 1 - y(j);
end
% Lower BC: phi = x
j = 1;
for i = 1 : Ny
    n = i + (j - 1)*Nx;
    M(n, n) = 1;
    B(n, 1) = x(i);
end
% Upper BC: phi = 1 - x
j = Ny;
for i = 1 : Ny
    n = i + (j - 1)*Nx;
    M(n, n) = 1;
    B(n, 1) = 1 - x(i);
end
% phi = M^(-1)*B
phi_vec = M\B;
% 2D array
for i = 1 : Nx
    for j = 1 : Ny
        n = i + (j - 1)*Nx;
        phi(i, j) = phi_vec(n);
    end
end
% Plotting solution
surf(x, y, phi');
