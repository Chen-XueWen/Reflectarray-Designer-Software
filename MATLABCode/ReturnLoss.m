clear;
[file,path] = uigetfile('*.csv');
Directory = strcat(path,file);
UnitPhase = csvread(Directory);
[width,length]= size(UnitPhase);
ProcessedPhase = UnitPhase(:,2:length);
ProcessedReport = cat(2,UnitPhase(:,1),ProcessedPhase);
[~,Numplot] = size(ProcessedReport);

plot(ProcessedReport(:,1),ProcessedReport(:,2),'-k');
hold on;
plot(ProcessedReport(:,1),ProcessedReport(:,3),'--k');
hold on;
plot(ProcessedReport(:,1),ProcessedReport(:,4),':k');
hold on;
plot(ProcessedReport(:,1),ProcessedReport(:,5),'-.k');
hold on;
plot(ProcessedReport(:,1),ProcessedReport(:,6),'--k^','MarkerSize',3,'MarkerFaceColor',[0 0 0]);
hold on;
plot(ProcessedReport(:,1),ProcessedReport(:,7),'--k*','MarkerSize',3);
hold on;
plot(ProcessedReport(:,1),ProcessedReport(:,8),'--ks','MarkerSize',3,'MarkerFaceColor',[0 0 0]);
hold on;

xlabel("Dimension (R1) / mm");
ylabel("Return Loss / dB");
thetacount = 0;
counter = 1;
for i=2:1:Numplot
    legendstr{counter} = sprintf('\\theta = %d°',thetacount);
    thetacount = thetacount + 10;
    counter = counter + 1;
end
lgnd = legend(legendstr);
set(lgnd,'color','none');
colorbar('hide');
axis('tight');
hold off;