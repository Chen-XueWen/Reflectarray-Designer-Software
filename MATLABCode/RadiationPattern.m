%Equation based on Predicting the performance of Electricaly large
%reflectarray antennas by Dr Chia Tse Tong

%Phase Distribution
OpFreq = 28e9;
NumElement1axis = 51;
ElementSize_mm = 4.4;
%Feedpos = [0,0,224.4*0.9];
Feedpos = [60,0,192.84]; %x,y,z
Radius = ElementSize_mm*NumElement1axis/2;
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
Wavelength = 299792458/OpFreq;
WaveNumber = (2*pi)/Wavelength; %K0
PhaseConstant = 0;
Element = zeros(NumElement1axis,NumElement1axis);
ElementAngle = zeros(NumElement1axis,NumElement1axis);
ElementNum = zeros(TotalElement,2);

%Direction of the beam
theta_b = 0 * pi/180; %theta0
phi_b = 0 * pi/180; %theta0

for j = 1:1:NumElement1axis
    YCoord = YStart - YSteps;
    for i = 1:1:NumElement1axis
        
        XCoord = XStart + XSteps;
        DistFeed = sqrt((XCoord-Feedpos(1))^2 + (YCoord-Feedpos(2))^2 + (0-Feedpos(3))^2);
        DistFeed = DistFeed*0.001; %Ri in meter
        PhaseRA = WaveNumber * (DistFeed - sin(theta_b) * (XCoord*0.001*cos(phi_b) + YCoord*0.001*sin(phi_b))) + PhaseConstant;
        PhaseRA = PhaseRA*(180/pi); %Convert to degree
        Element(j,i) = PhaseRA;
        ElementCoord(Counter,1) = XCoord;
        ElementCoord(Counter,2) = YCoord;
        ElementNum(Counter,1) =i ;
        ElementNum(Counter,2) =j ;
        ElementDist = sqrt(XCoord^2+YCoord^2); 
        ElementAngle(j,i) = acos((Feedpos(3)*0.001)/DistFeed)*180/pi;
        Counter = Counter + 1;
        XSteps = XSteps + GridWidth; 
    end
    XSteps = 0;
    YSteps = YSteps + GridWidth;
end
PhaseConstant = min(min(Element));
Element = Element - PhaseConstant;
Element = rem(Element, 360); %Phi_R(x,y)

%Electric field on m,n element due to feed
%Amn
Feedpos = [0,0,224.4*0.9];
q = 2*6.4;
Counter = 1;
XStart = -((floor(NumElement1axis/2))*ElementSize_mm); %1st Element
YStart = ((floor(NumElement1axis/2))*ElementSize_mm);
YSteps = 0;
XSteps = 0;
YCoord = 0;
XCoord = 0;
ElementAngleFeed = zeros(NumElement1axis,NumElement1axis); 

for j = 1:1:NumElement1axis
    YCoord = YStart - YSteps;
    for i = 1:1:NumElement1axis
        XCoord = XStart + XSteps;
        DistFeed = sqrt((XCoord-Feedpos(1))^2 + (YCoord-Feedpos(2))^2 + (0-Feedpos(3))^2);
        DistFeed = DistFeed*0.001; %Ri in meter
        ElementDist = sqrt(XCoord^2+YCoord^2); 
        ElementAngleFeed(j,i) = acos((Feedpos(3)*0.001)/DistFeed)*180/pi;
        XSteps = XSteps + GridWidth; 
    end
    XSteps = 0;
    YSteps = YSteps + GridWidth;
end

ElementAngleRad = ElementAngleFeed * pi/180;
FeedRadiationOnAp = cos(ElementAngleRad).^(q); %A(M,N)

%Fields radiated by a reflectarray
ScanTheta = -pi:0.1:pi;
ScanPhi = -pi:0.1:pi;
Nx = NumElement1axis;
Ny = NumElement1axis;
k = WaveNumber;
Px = ElementSize_mm*1e-3;
Py = ElementSize_mm*1e-3;
r = 51*4.4/2*1e-3;
ElectricField_Sum = 0;

for j = 1:1:length(ScanPhi)
    for i = 1:1:length(ScanTheta)
        u = sin(ScanTheta(j))*cos(ScanPhi(i));
        v = u;
        K1 = exp((-j*k/2)*(u*(Nx)*Px + v*(Ny)*Py));
        for n = 1:1:length(Element)
            for m = 1:1:length(Element)
                Temp = FeedRadiationOnAp(n,m)*exp(sqrt(-1)*Element(n,m)*pi/180)*exp(sqrt(-1)*k*(u*m*Px+ v*n*Py));
                ElectricField_Sum = ElectricField_Sum + Temp;
            end
        end
        Spectral = K1*Px*Py*sinc(k*u*Px/2)*sinc(k*v*Py/2)*ElectricField_Sum;
        EField_ThetaArray(j,i) = ((sqrt(-1)*k*exp(-sqrt(-1)*k*r))/(2*pi*r))*(cos(ScanPhi(i))*Spectral+sin(ScanPhi(i))*Spectral);
        EField_PhiArray(j,i) = ((sqrt(-1)*k*exp(-sqrt(-1)*k*r))/(2*pi*r))*cos(ScanTheta(j))*(-sin(ScanPhi(i))*Spectral+cos(ScanPhi(i))*Spectral);       
    end
end




