clc;
clear;

% draw the map of sites using calculating the Gauss coefficients
% ax = worldmap('World');
% land = shaperead('landareas', 'UseGeoCoords', true);
% geoshow(ax,land, 'FaceColor', [1 1 1]);
% location = load("latitude&longitude.dat");
% for index = 1:45
%     lat = location(index,2);
%     long = location(index,3);
%     scatterm(lat,long,100,'filled');
% end

% load the xyz components
coordinate = load("coordinate.dat");
% latitude & longitude
location = load("latitude&longitude.dat");
% the number of sites used in calculation
points = 45;
% g & h subscript
coefficient = load('coefficient.dat');
% theta and phi
angel = zeros(points,2);
for index = 1:points
    % theta
    angel(index,1) =( 90 - location(index,2) )/180 * pi;
    % phi
    angel(index,2) = location(index,3)/180 * pi;
end

% matrix A
matrix = zeros(points*3,28);

for x = 1:points
    for y = 1:14
        n = coefficient(2*y,1);
        m = coefficient(2*y,2);
        
        theta = angel(x,1);
        phi = angel(x,2);
        
        % Associated Legendre functions
        % legendre(n,cos(theta),'sch') computes functions of degree n and
        % order m = 0,1,2,...,n in cos(theta)
        % normalization sch
        ass_leg = legendre(n,cos(theta),'sch');
        % Derivative of associated legendre function of degree n in
        % cos(theta)
        diff_ass_leg = diff_leg(theta,n);
        
        matrix(3 * x - 2,2 * y -1) = cos(m * phi) * diff_ass_leg(m+1);
        matrix(3 * x - 2,2 * y   ) = sin(m * phi) * diff_ass_leg(m+1);
        
        matrix(3 * x -1,2 * y -1) =  m * sin(m * phi) ...
            * ass_leg(m+1) / sin(theta);
        matrix(3 * x -1,2 * y   ) = -m * cos(m * phi) ...
            * ass_leg(m+1) / sin(theta);
        
        matrix(3 * x,2 * y -1) = -cos(m * phi) * ass_leg(m+1) * (n + 1);
        matrix(3 * x,2 * y   ) = -sin(m * phi) * ass_leg(m+1) * (n + 1);
    end
end
format bank;
result = pinv( (matrix' * matrix) )* matrix' * coordinate;

idx = 1;
%global variations
global g;
global h;
g = zeros(4,5);
h = zeros(4,5);
for a = 1:4
    for b = 0:a
        g(a,b+1) = result(idx);
        idx = idx + 1;
        h(a,b+1) = result(idx);
        idx = idx +1;
    end
end

% write the Gauss Coefficients in a file named 3-coefficient.txt
fid = fopen('3-Gauss_coefficient.txt','w');
index = 1;
for i = 1:14
    fprintf(fid,'%s%d%d %c %-8.3f \r\n','g',...
        coefficient(index,1),coefficient(index,2),'=',result(index));
    index = index + 1;
    fprintf(fid,'%s%d%d %c %-8.3f \r\n','h',...
        coefficient(index,1),coefficient(index,2),'=',result(index));
    index = index + 1;
end
fclose(fid);

% Defination of functions using in this program
% Derivative of associated legendre function of degree n in cos(theta)
% f'(x) = f(x+delta_x) - f(x-delta_x) / 2 * delta_x
function [dif] = diff_leg(theta,n)
    dtheta = 0.0001;
    x1 = legendre(n,cos(theta - dtheta),'sch');
    x2 = legendre(n,cos(theta + dtheta),'sch');
    dif = (x2 - x1)./(2 * dtheta);
end