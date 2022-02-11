%Script Automator is written by Tan Xue Wen
%Permission from the original owner is required before redistributing.

clear;
clc;

%Table Format
%In Diameter
%X Y R1 InnerRingInner InnerRingOuter  OuterRingInner OuterRingOuter
Dimension = csvread('ElementDim.csv');
Coordinates = csvread('Coordinates.csv');
Number = csvread('ElementNum.csv');
% W = 0.08*(Dimension(:,1));
% InnerRingInner = 2*(0.7*(Dimension(:,1))-W);
% InnerRingOuter = 2*(0.7*(Dimension(:,1)));
% OuterRingInner = 2*(Dimension(:,1)-W);
% OuterRingOuter = 2*(Dimension(:,1));

W = 0.15*(Dimension(:,1));
OuterRingInner = 2*(Dimension(:,1)-W);
OuterRingOuter = 2*(Dimension(:,1));
InnerRingOuter = 0.6*(Dimension(:,1));
InnerRingInner = zeros(841,1);

Report = cat(2,Coordinates,Dimension);
Report = cat(2,Report,InnerRingInner);
Report = cat(2,Report,InnerRingOuter);
Report = cat(2,Report,OuterRingInner);
Report = cat(2,Report,OuterRingOuter);
Script = fopen('ReflectarrayScript.scr','w');

for i = 1:1:841
    %Boundary Condition
    %Top Left
    if (Number(i,1) < 11 && Number(i,2) == 1)
        continue;
    end
    if (Number(i,1) < 9 && Number(i,2) == 2)
        continue;
    end
    if (Number(i,1) < 7 && Number(i,2) == 3)
        continue;
    end
    if (Number(i,1) < 6 && Number(i,2) == 4)
        continue;
    end
    if (Number(i,1) < 5 && Number(i,2) == 5)
        continue;
    end
    if (Number(i,1) < 4 && Number(i,2) == 6)
        continue;
    end
    if (Number(i,1) < 3 && Number(i,2) == 7)
        continue;
    end
    if (Number(i,1) < 3 && Number(i,2) == 8)
        continue;
    end
    if (Number(i,1) < 2 && Number(i,2) == 9)
        continue;
    end
    if (Number(i,1) < 2 && Number(i,2) == 10)
        continue;
    end
    
    %Top Right
    if (Number(i,1) > 19 && Number(i,2) == 1)
        continue;
    end
    if (Number(i,1) > 21 && Number(i,2) == 2)
        continue;
    end
    if (Number(i,1) > 23 && Number(i,2) == 3)
        continue;
    end
    if (Number(i,1) > 24 && Number(i,2) == 4)
        continue;
    end
    if (Number(i,1) > 25 && Number(i,2) == 5)
        continue;
    end
    if (Number(i,1) > 26 && Number(i,2) == 6)
        continue;
    end
    if (Number(i,1) > 27 && Number(i,2) == 7)
        continue;
    end
    if (Number(i,1) > 27 && Number(i,2) == 8)
        continue;
    end
    if (Number(i,1) > 28 && Number(i,2) == 9)
        continue;
    end
    if (Number(i,1) > 28 && Number(i,2) == 10)
        continue;
    end
    
    %Bottom Left
    if (Number(i,1) < 11 && Number(i,2) == 29)
        continue;
    end
    if (Number(i,1) < 9 && Number(i,2) == 28)
        continue;
    end
    if (Number(i,1) < 7 && Number(i,2) == 27)
        continue;
    end
    if (Number(i,1) < 6 && Number(i,2) == 26)
        continue;
    end
    if (Number(i,1) < 5 && Number(i,2) == 25)
        continue;
    end
    if (Number(i,1) < 4 && Number(i,2) == 24)
        continue;
    end
    if (Number(i,1) < 3 && Number(i,2) == 23)
        continue;
    end
    if (Number(i,1) < 3 && Number(i,2) == 22)
        continue;
    end
    if (Number(i,1) < 2 && Number(i,2) == 21)
        continue;
    end
    if (Number(i,1) < 2 && Number(i,2) == 20)
        continue;
    end
    
    %Bottom Right
     if (Number(i,1) > 19 && Number(i,2) == 29)
        continue;
    end
    if (Number(i,1) > 21 && Number(i,2) == 28)
        continue;
    end
    if (Number(i,1) > 23 && Number(i,2) == 27)
        continue;
    end
    if (Number(i,1) > 24 && Number(i,2) == 26)
        continue;
    end
    if (Number(i,1) > 25 && Number(i,2) == 25)
        continue;
    end
    if (Number(i,1) > 26 && Number(i,2) == 24)
        continue;
    end
    if (Number(i,1) > 27 && Number(i,2) == 23)
        continue;
    end
    if (Number(i,1) > 27 && Number(i,2) == 22)
        continue;
    end
    if (Number(i,1) > 28 && Number(i,2) == 21)
        continue;
    end
    if (Number(i,1) > 28 && Number(i,2) == 20)
        continue;
    end
    
    
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