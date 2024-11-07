%Programmed by Tan Xue Wen
%Program Title: Reflectarray Element Mapping
%Please do not redistribution without the permission of the original owner
%(xuewen@u.nus.edu

Data = csvread("RingPatchResult\PatchRingPhaseFinal.csv");
DistributionData = csvread("PhaseDistribution.csv");
ElementDim = zeros(29,29);
Dim = Data(:,1);
Phase = Data(:,4);
xx = linspace(min(Dim),max(Dim),200); 
yy = spline(Dim,Phase,xx);
figure;
plot(Dim,Phase,'o',xx,yy);
grid on;


%Normalized 2mm at -180
NormalizedDim = 1:0.01:7;
NormalizedPhase = spline(Dim,Phase,NormalizedDim);
NormalizedPhase = NormalizedPhase - 0;
figure;
plot(NormalizedDim,NormalizedPhase);
xlabel("R1(mm)");
ylabel("phase shift(deg)");
 for j = 1:1:29
     for i = 1:1:29
         Dimension = spline(NormalizedPhase,NormalizedDim,DistributionData(j,i));
         ElementDim(j,i) = Dimension;
     end
 end
 figure;
 
 h = imagesc(ElementDim);
 impixelregion(h)
 
 ElementDim1D = ElementDim(:);
 csvwrite('ElementDim.csv',ElementDim1D)
