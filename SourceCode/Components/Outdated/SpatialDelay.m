%Programmed by Tan Xue Wen
%Program Title: Spatial Delay Plot
%Please do not redistribution without the permission of the original owner
%(xuewen@u.nus.edu)

Element = zeros(29,29);
XStart = -210; %1st Element
YStart = 210;
YSteps = 0;
XSteps = 0;
YCoord = 0;
XCoord = 0;
GridWidth = 15;
CenterHeight = 376; %F =37.6cm in mm
WaveNumber = 209.44;

for j = 1:1:29
    YCoord = YStart - YSteps;  
    for i = 1:1:29
        XCoord = XStart + XSteps;
        DistCenter = sqrt(XCoord^2 + YCoord^2);
        DistFeed = sqrt(DistCenter^2 + CenterHeight^2);
        DistFeed = DistFeed*0.001;
        SpatialPhase = (-WaveNumber)*DistFeed; %In radian
        SpatialPhase = -SpatialPhase*(180/pi); %Converted to degree and positive
        NormalizedPhase = rem(SpatialPhase, 360);
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