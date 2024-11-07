%Programmed by Tan Xue Wen
%Program Title: Reflectarray phase distribution
%Please do not redistribution without the permission of the original owner
%(xuewen@u.nus.edu)

Element = zeros(27,27);
XStart = -195; %1st Element
YStart = 195;
YSteps = 0;
XSteps = 0;
YCoord = 0;
XCoord = 0;
GridWidth = 15;
CenterHeight = 376; %F =37.6cm in mm
WaveNumber = 209.44; %K0
PhaseConstant = 168*pi/180; %Consult Dr Chia
XREF = -195;
YREF = 0;
%Direction of the beam 
%Since it is all perpendicular to plane hence all 0
theta = 0; %theta0
phi = 0; %theta0

for j = 1:1:27
    YCoord = YStart - YSteps;  
    for i = 1:1:27
        XCoord = XStart + XSteps;
        DistCenter = sqrt((XCoord-XREF)^2 + (YCoord-YREF)^2);
        DistFeed = sqrt(DistCenter^2 + CenterHeight^2);
        DistFeed = DistFeed*0.001; %Ri in meter
        PhaseRA = WaveNumber * (DistFeed - sin(theta) * (XCoord*cos(phi) + YCoord*sin(phi))) + PhaseConstant;
        PhaseRA = PhaseRA*(180/pi); %Convert to degree
        NormalizedPhase = rem(PhaseRA, 360);
        Element(j,i) = NormalizedPhase;
        XSteps = XSteps + GridWidth;
    end
    XSteps = 0;
    YSteps = YSteps + GridWidth;
end

figure;
imagesc(Element);
xlabel('x-axis [element number]');
ylabel('y-axis [element number]');
csvwrite('DoubleRingPhaseDistribution.csv',Element)