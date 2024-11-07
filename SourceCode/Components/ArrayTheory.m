%x-polarized ideal feed
Theta_Scan = -pi/2:0.1:pi/2;
Phi_Scan = -pi/2:0.1:pi/2;
OpFreq = 28e9;
Wavelength = 299792458/OpFreq;
k = (2*pi)/Wavelength;
r = 200e-3;
qval = 6;
for i = 1:1:length(Theta_Scan)
    for j = 1:1:length(Phi_Scan)
        EField_Theta(i,j) = ((sqrt(-1)*k*exp(-sqrt(-1)*k*r))/(2*pi*r))*(cos(Theta_Scan(i))^qval)*cos(Phi_Scan(j));
        EField_Phi(i,j) = ((sqrt(-1)*k*exp(-sqrt(-1)*k*r))/(2*pi*r))*(cos(Theta_Scan(i))^qval)*sin(Phi_Scan(j));
    end
end
%Transformation
EField_X

