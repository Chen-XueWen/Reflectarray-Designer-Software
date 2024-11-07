%Phase Comparison Code
Data = csvread('C:\Users\user\Desktop\TempSquare.csv');
Dim = Data(:,1);
Phase1 = Data(:,2);
plot(Dim,Phase1,'Color','black');
hold on;
Phase2 = Data(:,3);
plot(Dim,Phase2,'Color','red');
hold on;
Phase3 = Data(:,4);
plot(Dim,Phase3,'Color','blue');
hold on;
Phase4 = Data(:,5);
plot(Dim,Phase4,'Color','green');
hold on;
legend('Air Gap=0mm','Air Gap=0.5mm','Air Gap=1mm','Air Gap=3mm');
xlabel("L(mm)");
ylabel("phase shift(deg)");
