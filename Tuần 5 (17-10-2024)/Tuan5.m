% Solving advection equation
clc
clear
% Paramaters
L_max = 1; T_max = 1; c = 1.0;
Nt = 350; % number of time steps
dt = T_max/Nt;
Nx = 300;
n_init = 50;
dx = L_max/Nx; % number of spatial steps
b = c * dt/(2 * dx);
time = [2, 11, 51, 101];
x = 0:dx:1;
t = 0:dt:T_max;
u = zeros(Nx, Nt);

% Initial conditions
for i = 1 : Nx+1
    if i < n_init
        u(i, 1) = 1;
    else
        u(i, 1) = 0;
    end
    x(i) = (i - 1) * dx;
end

% Value of u at the boundary
for k = 1 : Nt+1
    u(1, k) = 1;
    u(Nx+1, k) = 0;
    time(k) = (k-1) * dt;
end

% Using FTCS method
for k = 1 : Nt
    for i = 2 : Nx
        u(i, k+1) = u(i, k) - b * (u(i+1, k) - u(i-1, k));
    end
end

% Using Lax method
% for k = 1 : Nt
%    for i = 2 : Nx
%        u(i, k+1) = 0.5 * (u(i+1, k) + u(i-1, k)) - b * (u(i+1, k) - u(i-1, k));
%    end
% end

% Plotting the results
plot(x, u(:, 1), '-',x, u(:, 10), '-',x, u(:, 50), '-',x, u(:, 100), '-')

figure(2)
mesh(x, time, u')
xlabel('x'); ylabel('y');
