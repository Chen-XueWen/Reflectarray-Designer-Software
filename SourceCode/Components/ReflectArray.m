%RAScript
%Phase Distribution
OpFreq = 10e9;
ElementPhase = load('ElementPhase.csv');
NumElement1axis = 29;
ElementSize_mm = 15;
FeedDistance_mm = ElementSize_mm*NumElement1axis;

Element = zeros(NumElement1axis,NumElement1axis);
TotalElement = NumElement1axis*NumElement1axis;
ElementCoord = zeros(TotalElement,2);
Counter = 1;
XStart = -((floor(NumElement1axis/2))*ElementSize_mm); %1st Element
YStart = ((floor(NumElement1axis/2))*ElementSize_mm);
YSteps = 0;
XSteps = 0;
YCoord = 0;
XCoord = 0;
GridWidth = ElementSize_mm;
CenterHeight = FeedDistance_mm; %F =45.7cm in mm
Wavelength = 299792458/OpFreq;
WaveNumber = (2*pi)/Wavelength; %K0
PhaseConstant = 0;
ElementNum = zeros(TotalElement,2);

%Direction of the beam
%Since it is all perpendicular to plane hence all 0
theta = 20 * pi/180; %theta0
phi = 0 * pi/180; %theta0

for j = 1:1:NumElement1axis
    YCoord = YStart - YSteps;
    for i = 1:1:NumElement1axis
        XCoord = XStart + XSteps;
        DistFeed = sqrt(XCoord^2 + YCoord^2 + CenterHeight^2);
        DistFeed = DistFeed*0.001; %Ri in meter
        PhaseRA = WaveNumber * (DistFeed - sin(theta) * (XCoord*0.001*cos(phi) + YCoord*0.001*sin(phi))) + PhaseConstant;
        PhaseRA = PhaseRA*(180/pi); %Convert to degree
        Element(j,i) = PhaseRA;
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
PhaseConstant = min(min(Element));
%PhaseConstant = Element(ceil(NumElement1axis/2),ceil(NumElement1axis/2));
Element = Element - PhaseConstant;
Element = rem(Element, 360);

%figure;
%imagesc(Element);
%xlabel('x-axis [element number]');
%ylabel('y-axis [element number]');
%title('Phase Distribution')

%Mapping
Data = ElementPhase;
DistributionData = Element;
NormalizedPhase = Data(:,3) - min(Data(:,3));
ElementDim = zeros(NumElement1axis,NumElement1axis);
Dim = Data(:,1);
Phase = NormalizedPhase;
ElementDim1D = ElementDim(:);
for j = 1:1:NumElement1axis
    for i = 1:1:NumElement1axis
        Dimension = spline(NormalizedPhase,Dim,DistributionData(j,i));
        ElementDim(j,i) = Dimension;
    end
end

%Automating Script
%Table Format
%In Diameter
Dimension = ElementDim1D;
Coordinates = ElementCoord;
Number = ElementNum;

%Automating Script
%Table Format
%In Diameter
%X Y R1 InnerRingInner InnerRingOuter  OuterRingInner OuterRingOuter

%Choose Your Chosen Parameters
W = 0.15*(Dimension(:,1));
OuterRingInner = 2*(Dimension(:,1)-W);
OuterRingOuter = 2*(Dimension(:,1));
InnerRingOuter = 2*0.6*(Dimension(:,1));
InnerRingInner = zeros(TotalElement,1);

Report = cat(2,Coordinates,Dimension);
Report = cat(2,Report,InnerRingInner);
Report = cat(2,Report,InnerRingOuter);
Report = cat(2,Report,OuterRingInner);
Report = cat(2,Report,OuterRingOuter);
Script = fopen('ReflectarrayScript.scr','w');

for i = 1:1:TotalElement
    
    fprintf(Script,'DONUT\n');
    fprintf(Script,'%f\n',Report(i,4));
    fprintf(Script,'%f\n',Report(i,5));
    fprintf(Script,'%f,',Report(i,1));
    fprintf(Script,'%f\n',Report(i,2));
    fprintf(Script,'\n');
    
    fprintf(Script,'DONUT\n');
    fprintf(Script,'%f\n',Report(i,6));
    fprintf(Script,'%f\n',Report(i,7));
    fprintf(Script,'%f,',Report(i,1));
    fprintf(Script,'%f\n',Report(i,2));
    fprintf(Script,'\n');
end

fclose(Script);

