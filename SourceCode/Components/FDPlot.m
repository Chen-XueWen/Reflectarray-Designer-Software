%Reference Paper: Aperture Efficiency Analysis
theta = (-pi):0.02:(pi);
q = 0.5;
%Feeding Beam
Uf = (cos(theta)).^(2*q);
Uf = 10*log10(Uf);
figure();
plot(theta,Uf,'-k');
hold on;
q = 1;
Uf = (cos(theta)).^(2*q);
Uf = 10*log10(Uf);
plot(theta,Uf,':k');
q = 6;
Uf = (cos(theta)).^(2*q);
Uf = 10*log10(Uf);
plot(theta,Uf,'--k');
q = 8;
Uf = (cos(theta)).^(2*q);
Uf = 10*log10(Uf);
plot(theta,Uf,'-.k');
legend("q = 0.5","q = 1","q = 6","q = 8");
xlabel("scan angle (radian)");
ylabel("power level (dB)");
title("Theorectical Feed Power Pattern");
%axis([-50/180*pi 50/180*pi -10 0]);
axis([-1.5 1.5 -10 0]);
%Directivity
counter = 0;
for q = 0:0.1:15
    counter = counter + 1;
    qC(counter) = q;
    fun = @(x) (cos(x)).^(2*q).*sin(x);
    Prad = 2*pi*integral(fun,0,pi/2);
    %4piUmax/Prad
    D(counter) = 10*log10((4*pi)/Prad);
end
figure();
plot(qC,D,'k');
xlabel("q");
ylabel("directivity (dB)");
title("Directivity");
axis([0 15 0 18]);

%Spillover Efficiency
HDRatio = 0.1:0.01:2;
HDLength = length(HDRatio);
NsMat = zeros(1,HDLength);
D = 224.4e-3;
%q = 4.5;
%q = 11.5;
q = 6.4;
Id = (2*pi)/(2*q + 1);
%Square
for i = 1:1:HDLength
    HDR = HDRatio(i);
    H = HDR*D;
    r0 = H;
    Pr = @(x,y) (H./((sqrt(x.^2+y.^2+H^2)).^3)).*(((r0^2+(sqrt(x.^2+y.^2+H^2)).^2-(sqrt(x.^2+y.^2)).^2)./(2*r0*(sqrt(x.^2+y.^2+H^2)))).^(2*q));
    In = integral2(Pr,-(D/2),(D/2),-(D/2),(D/2),'Method','iterated');
    Ns = In/Id;
    NsMat(i) = Ns; 
end

%Circular
% NsMat_C = zeros(1,HDLength);
% for i = 1:1:HDLength
%     HDR = HDRatio(i);
%     H = HDR*D;
%     r0 = H;
%     alpha = atan(((D/2)/H));
%     Ns_C = 1 - (cos(alpha))^(2*q+1);
%     NsMat_C(i) = Ns_C;
% end

%Illumination Efficiency
%Square
qe = 1;
NiMat = zeros(1,HDLength);
for i = 1:1:HDLength
    HDR = HDRatio(i);
    H = HDR*D;
    r0 = H;
    I_D = @(x,y) (((H^qe)./(sqrt(x.^2+y.^2+H^2).^(1+qe))).*((r0^2+(sqrt(x.^2+y.^2+H^2)).^2-(sqrt(x.^2+y.^2)).^2)./(2*r0.*(sqrt(x.^2+y.^2+H^2)))).^(q)).^2;
    Denominator = integral2(I_D,-(D/2),(D/2),-(D/2),(D/2),'Method','iterated');
    I_N = @(x,y) ((H^qe)./(sqrt(x.^2+y.^2+H^2).^(1+qe))).*((r0^2+(sqrt(x.^2+y.^2+H^2)).^2-(sqrt(x.^2+y.^2)).^2)./(2*r0.*(sqrt(x.^2+y.^2+H^2)))).^(q);
    Norminator = (abs(integral2(I_N,-(D/2),(D/2),-(D/2),(D/2),'Method','iterated')))^2;
    Aa = D*D;
    Ni = (1/Aa)*(Norminator/Denominator);
    NiMat(i) = Ni;
end

NMat = NsMat.*NiMat;
figure();
plot(HDRatio,NMat,'--ks','MarkerIndices',1:10:length(NMat),'MarkerSize',3,'MarkerFaceColor',[0 0 0])
hold on;
plot(HDRatio,NsMat,'--k*','MarkerIndices',1:10:length(NMat),'MarkerSize',3,'MarkerFaceColor',[0 0 0])
hold on;
plot(HDRatio,NiMat,'--k^','MarkerIndices',1:10:length(NMat),'MarkerSize',3,'MarkerFaceColor',[0 0 0])
legend("{\eta}_{a}","{\eta}_{s}","{\eta}_{i}")
xlabel("F/D");
ylabel("Efficiency");
axis tight;
%title("D = 135mm")
%title("D = 224.4mm, q = 4.5");
