[file,path] = uigetfile('*.csv');
Directory = strcat(path,file);
Data = csvread(Directory);
plot(Data(:,1),Data(:,2));
ylabel('Maximum Gain / dB')
xlabel('Frequency / GHz')