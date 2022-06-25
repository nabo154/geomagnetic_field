clc;
clear;

global g;
global h;

g = zeros(4,5);
h = zeros(4,5);

%IGRF-13 Gauss coefficients
g(1,1) = -29404.8;
g(1,2) = -1450.9;
h(1,2) = 4652.5;
g(2,1) = -2499.6;
g(2,2) = 2982.0;
h(2,2) = -2991.6;
g(2,3) = 1677.0;
h(2,3) = -734.6;
g(3,1) = 1363.2;
g(3,2) = -2381.2;
h(3,2) = -82.1;
g(3,3) = 1236.2;
h(3,3) = 241.9;
g(3,4) = 525.7;
h(3,4) = -543.4;
g(4,1) = 903.0;
g(4,2) = 809.5;
h(4,2) = 281.9;
g(4,3) = 86.3;
h(4,3) = -158.4;
g(4,4) = -309.4;
h(4,4) = 199.7;
g(4,5) = 48.0;
h(4,5) = -349.7;

N = 180;
theta = linspace(0,pi,N+1);
phi = linspace(0,2*pi,2*N+1);

X_val = zeros(length(theta),length(phi));
Y_val = zeros(length(theta),length(phi));
Z_val = zeros(length(theta),length(phi));

for i = 1:181
    for j = 1:361
        Theta = theta(i);
        Phi = phi(j);
        X_val(i,j) = comx(Theta,Phi);
        Y_val(i,j) = comy(Theta,Phi);
        Z_val(i,j) = comz(Theta,Phi);
    end
end

F_val = sqrt(X_val.^2 + Y_val.^2 + Z_val.^2);
H_val = sqrt(X_val.^2 + Y_val.^2);
D_val = atan(Y_val./X_val)/pi * 180;
I_val = atan(Z_val./H_val)/pi * 180;

figure;
axesm robinson;
pcolorm((pi/2-theta)/pi*180,phi/pi*180,F_val);
colormap jet;
contourm((pi/2-theta)/pi*180,phi/pi*180,F_val,20);
colorbar;
load coastlines;
plotm(coastlat,coastlon);
title('Total field intensity F using IGRF-13');

figure;
axesm robinson;
pcolorm((pi/2-theta)/pi*180,phi/pi*180,-Z_val);
colormap jet;
contourm((pi/2-theta)/pi*180,phi/pi*180,-Z_val,20);
colorbar;
load coastlines;
plotm(coastlat,coastlon);
title('Radial component Br using IGRF-13');

figure;
axesm robinson;
pcolorm((pi/2-theta)/pi*180,phi/pi*180,I_val);
colormap jet;
contourm((pi/2-theta)/pi*180,phi/pi*180,I_val,20);
colorbar;
load coastlines;
plotm(coastlat,coastlon);
title('Inclination I using IGRF-13');

figure;
axesm robinson;
pcolorm((pi/2-theta)/pi*180,phi/pi*180,D_val);
colormap jet;
contourm((pi/2-theta)/pi*180,phi/pi*180,D_val,20);
colorbar;
load coastlines;
plotm(coastlat,coastlon);
title('Declination D using IGRF-13');

function x_val = comx(theta,phi)
    global g;
    global h;
    x_val = 0;
    for n = 1:4
        for m = 0:n
            dp = com_dp(n,theta);
            x_val = x_val ...
                + cos(m * phi) * dp(m+1) * g(n,m+1)...
                + sin(m * phi) * dp(m+1) * h(n,m+1);
        end
    end
end

function y_val = comy(theta,phi)
    global g;
    global h;
    y_val = 0;
    for n = 1:4
        for m = 0:n
            leg = legendre(n,cos(theta),'sch');
            y_val = y_val ...
                + m * sin(m * phi) * leg(m+1)/sin(theta) * g(n,m+1) ...
                - m * cos(m * phi) * leg(m+1)/sin(theta) * h(n,m+1);
        end
    end
end

function z_val = comz(theta,phi)
    global g;
    global h;
    z_val = 0;
    for n = 1:4
        for m = 0:n
            leg = legendre(n,cos(theta),'sch');
            z_val = z_val ...
                -cos(m * phi) * leg(m+1) * (n + 1) * g(n,m+1)...
                -sin(m * phi) * leg(m+1) * (n + 1) * h(n,m+1);
        end
    end
end

function dp_val = com_dp(n,theta)
    dtheta = 0.00001;
    p1 = legendre(n,cos(theta-dtheta),'sch');
    p2 = legendre(n,cos(theta+dtheta),'sch');
    dp_val =( p2 - p1 )/ ( 2 * dtheta);
end
    