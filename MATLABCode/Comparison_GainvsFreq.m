[file,path] = uigetfile('*.csv');
Directory = strcat(path,file);
Data = csvread(Directory);
plot(Data(:,1),Data(:,2),'-k');
hold on;
plot(Data(:,1),Data(:,3),'--k');
ylabel('Maximum Gain / dB');
xlabel('Frequency / GHz');
legend('Measured','Simulated');