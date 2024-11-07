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
CenterHeight = 457; %F =45.7cm in mm
WaveNumber = 209.44; %K0
%PhaseConstant = 168*pi/180;
PhaseConstant = -84.01*pi/180;
ElementNum = zeros(841,2);

%Direction of the beam 
%Since it is all perpendicular to plane hence all 0
theta = 0 * pi/180; %theta0
phi = 0 * pi/180; %theta0

for j = 1:1:29
    YCoord = YStart - YSteps;  
    for i = 1:1:29
        XCoord = XStart + XSteps;
        DistCenter = sqrt(XCoord^2 + YCoord^2);
        DistFeed = sqrt(DistCenter^2 + CenterHeight^2);
        DistFeed = DistFeed*0.001; %Ri in meter
        PhaseRA = WaveNumber * (DistFeed - sin(theta) * (XCoord*0.001*cos(phi) + YCoord*0.001*sin(phi))) + PhaseConstant;
        PhaseRA = PhaseRA*(180/pi); %Convert to degree
        NormalizedPhase = rem(PhaseRA, 360);
        Element(j,i) = NormalizedPhase;
%     %Boundary Condition
%     %Top Left
%     if (i < 11 && j == 1)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 9 && j == 2)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 7 && j == 3)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 6 && j == 4)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 5 && j == 5)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 4 && j == 6)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 3 && j == 7)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 3 && j == 8)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 2 && j == 9)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 2 && j == 10)
%         Element(j,i) = NaN;
%         
%     end
%     
%     %Top Right
%     if (i > 19 && j == 1)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 21 && j == 2)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 23 && j == 3)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 24 && j == 4)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 25 && j == 5)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 26 && j == 6)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 27 && j == 7)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 27 && j == 8)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 28 && j == 9)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 28 && j == 10)
%         Element(j,i) = NaN;
%         
%     end
%     
%     %Bottom Left
%     if (i < 11 && j == 29)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 9 && j == 28)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 7 && j == 27)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 6 && j == 26)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 5 && j == 25)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 4 && j == 24)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 3 && j == 23)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 3 && j == 22)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 2 && j == 21)
%         Element(j,i) = NaN;
%         
%     end
%     if (i < 2 && j == 20)
%         Element(j,i) = NaN;
%         
%     end
%     
%     %Bottom Right
%     if (i > 19 && j == 29)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 21 && j == 28)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 23 && j == 27)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 24 && j == 26)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 25 && j == 25)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 26 && j == 24)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 27 && j == 23)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 27 && j == 22)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 28 && j == 21)
%         Element(j,i) = NaN;
%         
%     end
%     if (i > 28 && j == 20)
%         Element(j,i) = NaN;
%         
%     end
        ElementCoord(Counter,1) = XCoord;
        ElementCoord(Counter,2) = YCoord;
        ElementNum(Counter,1) =i ;
        ElementNum(Counter,2) =j ;
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

csvwrite('PhaseDistribution.csv',Element)
csvwrite('Coordinates.csv',ElementCoord)
csvwrite('ElementNum.csv',ElementNum)