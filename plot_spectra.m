clc;
clear;

spectra = zeros(13,1);
spectra1 = zeros(4,1);
igrf13 = load('IGRF13coeffs.dat');
coeffs = load('coeffs.dat');

index = 1;
for n = 1:13
    for m = 0:n
        spectra(n) = spectra(n) + (igrf13(index))^2;
        index = index + 1;
        spectra(n) = spectra(n) + (igrf13(index))^2;
        index = index + 1;
    end
    spectra(n) = (n + 1) * spectra(n);
end

index = 1;
for n = 1:4
    for m = 0:n
        spectra1(n) = spectra1(n) + (coeffs(index))^2;
        index = index + 1;
        spectra1(n) = spectra1(n) + (coeffs(index))^2;
        index = index + 1;
    end
    spectra1(n) = (n + 1) * spectra1(n);
end

x = 1:13;
y = 1:4;
plot(x,spectra,y,spectra1);