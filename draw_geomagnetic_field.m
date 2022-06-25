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
title('Total field intensity F');

figure;
axesm robinson;
pcolorm((pi/2-theta)/pi*180,phi/pi*180,-Z_val);
colormap jet;
contourm((pi/2-theta)/pi*180,phi/pi*180,-Z_val,20);
colorbar;
load coastlines;
plotm(coastlat,coastlon);
title('Radial component Br');

figure;
axesm robinson;
pcolorm((pi/2-theta)/pi*180,phi/pi*180,I_val);
colormap jet;
contourm((pi/2-theta)/pi*180,phi/pi*180,I_val,20);
colorbar;
load coastlines;
plotm(coastlat,coastlon);
title('Inclination I');

figure;
axesm robinson;
pcolorm((pi/2-theta)/pi*180,phi/pi*180,D_val);
colormap jet;
contourm((pi/2-theta)/pi*180,phi/pi*180,D_val,20);
colorbar;
load coastlines;
plotm(coastlat,coastlon);
title('Declination D');

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
    