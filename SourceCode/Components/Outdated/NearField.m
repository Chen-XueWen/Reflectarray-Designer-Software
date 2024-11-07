%Programmed by Tan Xue Wen
%Program Title: NearField
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
%Direction of the beam 
%Since it is all perpendicular to plane hence all 0
theta = 0; %theta0
phi = 0; %theta0
lconstant = 403.56*0.001;
dconstant = 300*0.001;

for j = 1:1:27
    YCoord = YStart - YSteps;  
    for i = 1:1:27
        XCoord = XStart + XSteps;
        Ln = sqrt((XCoord-(-195))^2 + (YCoord-(0))^2 + (0-(353.32))^2);
        Dn = sqrt((XCoord-(102.6))^2 + (YCoord-(0))^2 + (0-(281))^2);
        Ln = Ln*0.001; %Ri in meter
        Dn = Dn*0.001;
        Phase = WaveNumber*(Ln + Dn - lconstant - dconstant);
        %Phase = WaveNumber*(Ln);
        Phase = Phase * 180/pi;
        NormalizedPhase = rem(Phase,360);
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
csvwrite('NearField.csv',Element)