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

F = zeros(length(theta),length(phi));
I = zeros(length(theta),length(phi));
D = zeros(length(theta),length(phi));
H = zeros(length(theta),length(phi));
R = zeros(length(theta),length(phi));

for i = 1:181
    for j = 1:361
        Theta = theta(i);
        Phi = phi(j);
        F(i,j) = Intensity(Theta,Phi);
        H(i,j) = sqrt(Bx(Theta,Phi)^2 + By(Theta,Phi)^2);
        D(i,j) = atan(By(Theta,Phi)/Bx(Theta,Phi))/pi*180;
        I(i,j) = atan(Bz(Theta,Phi)/H(i,j))/pi*180;
        R(i,j) = -Br(Theta,Phi);
    end
end

figure;
axesm robinson;
pcolorm((pi/2-theta)/pi*180,phi/pi*180,F);
contourm((pi/2-theta)/pi*180,phi/pi*180,F);
load coastlines;
plotm(coastlat,coastlon);
colormap jet;
colorbar;
title('Total field intensity F using IGRF-13');

figure;
axesm robinson;
pcolorm((pi/2-theta)/pi*180,phi/pi*180,R);
contourm((pi/2-theta)/pi*180,phi/pi*180,R,15);
load coastlines;
plotm(coastlat,coastlon)
colormap jet;
colorbar;
title('Radial Component Br using IGRF-13');

figure;
axesm robinson;
pcolorm((pi/2-theta)/pi*180,phi/pi*180,D);
contourm((pi/2-theta)/pi*180,phi/pi*180,D);
load coastlines;
plotm(coastlat,coastlon);
colormap jet;
colorbar;
title('Declination D using IGRF-13');

figure;
axesm robinson;
pcolorm((pi/2-theta)/pi*180,phi/pi*180,I);
contourm((pi/2-theta)/pi*180,phi/pi*180,I,15);
load coastlines;
plotm(coastlat,coastlon)
colormap jet;
colorbar;
title('Inclination I using IGRF-13');

% Defination of functions using in this program
% potential V
function Potential = V(theta,phi)
    global g;
    global h;
    Potential = 0;
    for a = 1:4
        leg = legendre(a,cos(theta),'sch');
        for b = 0:a
            Potential = Potential + ...
                 ( g(a,b+1) * cos(b*phi) + h(a,b+1) * sin(b*phi) )* leg(b+1);
        end
    end
end

% the x componen
function [B_x] = Bx(theta,phi)
    dtheta = 0.00001;
    B_x = ( V(theta+dtheta,phi) - V(theta-dtheta,phi) )/(2 * dtheta);
end

% the y componen
function [B_y] = By(theta,phi)
    dphi = 0.00001;
    B_y = ( V(theta,phi+dphi) - V(theta,phi-dphi) )/(2 * dphi * sin(theta) );
end

% the z componen
function [B_z] = Bz(theta,phi)
    B_z = - Br(theta,phi);
end

% the B_theta component
function [B_theta] = Btheta(theta,phi)
    dtheta = 0.001;
    B_theta = (V(theta+dtheta,phi) - V(theta,phi) )/dtheta;
end

% the B_phi component
function [B_phi] = Bphi(theta,phi)
    dphi = 0.001;
    B_phi = -1/sin(theta) * (V(theta,phi+dphi) - V(theta,phi) )/dphi;
end

% the B_r component
function [B_r] = Br(theta,phi)
    global g;
    global h;
    temp = 0;
    for n = 1:4
        leg = legendre(n, cos(theta),'sch');
        for m = 0:n
            temp = temp...
                + ( (g(n,m + 1) * cos(m * phi)...
                + h(n,m + 1) * sin(m * phi) )...
                * leg(m+1) * ( n + 1 ) );
        end
    end
    B_r = temp;
end

% the geomagnetic field intensity in earth surface at (theta,phi);
function [intensity] = Intensity(theta,phi)
    intensity = sqrt(Br(theta,phi)^2 + Btheta(theta,phi)^2 + Bphi(theta,phi)^2);
end