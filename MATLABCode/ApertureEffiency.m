function ApertureEffiency(OpFreq,Gain_dB,AntennaArea)
    Gain = 10^(Gain_dB/10);
    EffAperture = ((299792458^2)/(OpFreq^2))*(Gain/(4*pi));
    ApertureEffiency = EffAperture/AntennaArea
end