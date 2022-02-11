%Programmed by Tan Xue Wen
%Program Title: Reflectarray phase distribution
%Please do not redistribution without the permission of the original owner
%(xuewen@u.nus.edu)

Element = zeros(29,29);
ElementCoord = zeros(841,2);
Counter = 1;
XStart = -210; %1st Element
YStart = 210;
YSteps = 0;
XSteps = 0;
YCoord = 0;
XCoord = 0;
GridWidth = 15;
CenterHeight = 376; %F =37.6cm in mm
WaveNumber = 209.44; %K0
PhaseConstant = 168*pi/180;

%Direction of the beam 
%Since it is all perpendicular to plane hence all 0
theta = 0; %theta0
phi = 0; %theta0

for j = 1:1:29
    YCoord = YStart - YSteps;  
    for i = 1:1:29
        XCoord = XStart + XSteps;
        DistCenter = sqrt(XCoord^2 + YCoord^2);
        DistFeed = sqrt(DistCenter^2 + CenterHeight^2);
        DistFeed = DistFeed*0.001; %Ri in meter
        PhaseRA = WaveNumber * (DistFeed - sin(theta) * (XCoord*cos(phi) + YCoord*sin(phi))) + PhaseConstant;
        PhaseRA = PhaseRA*(180/pi); %Convert to degree
        NormalizedPhase = rem(PhaseRA, 360);
        Element(j,i) = NormalizedPhase;
        ElementCoord(Counter,1) = XCoord;
        ElementCoord(Counter,2) = YCoord;
        Counter = Counter + 1;
        XSteps = XSteps + GridWidth;
    end
    XSteps = 0;
    YSteps = YSteps + GridWidth;
end
[Xq,Yq] = meshgrid(1:0.01:29);

figure;
imagesc(Element);
xlabel('x-axis [element number]');
ylabel('y-axis [element number]');

csvwrite('DoubleRingPhaseDistribution.csv',Element)
csvwrite('Coordinates.csv',ElementCoord)