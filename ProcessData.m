%Load structs of Gain and Directivity. They includes: AmplitudeCo, PhaseCo,
%AmplitudeCross, PhaseCross each one is a 4D matrix of 
%(NumberPhi, NumberTheta, NumberFrequencyPoint, NumberAntenna)

load(strcat(pwd,'\Directivity\AntennaDirectivity.mat'));
load(strcat(pwd,'\Gain\AntennaGain.mat'));

NumberPhi = 72;
NumberTheta = 37;
NumberFrequencyPoint = 7;
NumberAntenna = 4;

Efficiency = zeros(NumberFrequencyPoint, NumberAntenna);
for i = 1:NumberFrequencyPoint
    for j = 1:NumberAntenna
        Efficiency(i,j) = Directivity.AmplitudeCo(1,1,i,j) - Gain.AmplitudeCo(1,1,i,j);
    end
end

figure(1)
hold on
for i = 1:NumberAntenna
    plot(24.5:0.5:27.5,Efficiency(:,i));
end
legend('Element 1','Element 2','Element 3','Element 4')

figure(2)
hold on
for i = 1:NumberAntenna
    plot(-180:5:180,[Gain.AmplitudeCo(37,NumberTheta:-1:2,4,i) Gain.AmplitudeCo(1,:,4,i)]); % At 26GHz
    plot(-180:5:180,[Gain.AmplitudeCross(37,NumberTheta:-1:2,4,i) Gain.AmplitudeCross(1,:,4,i)],'--');
end
legend('GainCoAntenna1','GainCrossAntenna1','GainCoAntenna2',...
    'GainCrossAntenna2','GainCoAntenna3','GainCrossAntenna3','GainCoAntenna4','GainCrossAntenna4');

figure(3)
hold on
for i = 1:NumberAntenna
    plot(-180:5:180,[Gain.AmplitudeCo(55,NumberTheta:-1:2,4,i) Gain.AmplitudeCo(19,:,4,i)]); % At 26GHz
    plot(-180:5:180,[Gain.AmplitudeCross(55,NumberTheta:-1:2,4,i) Gain.AmplitudeCross(19,:,4,i)],'--');
end
legend('GainCoAntenna1','GainCrossAntenna1','GainCoAntenna2',...
    'GainCrossAntenna2','GainCoAntenna3','GainCrossAntenna3','GainCoAntenna4','GainCrossAntenna4');

% GainTotal = Gain.AmplitudeCo.*exp(-pi*1i*deg2rad(Gain.PhaseCo))
    
    