%PolarPlot
[file,path] = uigetfile('*.csv');
Directory = strcat(path,file);
Data = csvread(Directory);
Theta = Data(:,2);
Theta_Radian = Theta*(pi/180);
%MagdBE = Data(:,3);
subplot(2,1,1);
plot(Theta,Data(:,3)) %phi = 0 E plane
axis tight;
ylabel('Realized Gain / dB')
xlabel('Theta / Degree')
grid minor;
title('Phi = 90 degree, varying Theta')
%MagdBH = Data(:,4);
subplot(2,1,2);
plot(Theta,Data(:,4)) %phi = 90 H-plane
axis tight;
ylabel('Realized Gain / dB')
xlabel('Phi / Degree')
grid minor;
title('Theta = 17 degree, varying Phi')
%title("Pyramidal Horn Radiation Pattern");
%grid minor;