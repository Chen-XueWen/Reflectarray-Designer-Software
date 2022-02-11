%PolarPlot
clear;
[file,path] = uigetfile('*.csv');
Directory = strcat(path,file);
Data = csvread(Directory);
Theta = Data(:,2);
Theta_Radian = Theta*(pi/180);
%MagdBE = Data(:,3);
plot(Theta,Data(:,3),'-k') %phi = 90 E-plane
hold on;
%MagdBH = Data(:,4);
plot(Theta,Data(:,4),'--k') %phi = 0 H plane
axis tight;
legend("E-plane","H-plane");
ylabel('Realized Gain / dB')
xlabel('Theta / Degree')
%title("Pyramidal Horn Radiation Pattern");
grid minor;