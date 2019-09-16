close all
clear all
clc

NumberTheta = 37;
NumberPhi = 72;
NumberFrequencyPoint = 7;
NumberAntenna = 4;

AmplitudeCoLine = zeros(NumberTheta*NumberPhi, NumberFrequencyPoint, NumberAntenna);
AmplitudeCrossLine = zeros(NumberTheta*NumberPhi, NumberFrequencyPoint, NumberAntenna);
PhaseCoLine = zeros(NumberTheta*NumberPhi, NumberFrequencyPoint, NumberAntenna);
PhaseCrossLine = zeros(NumberTheta*NumberPhi, NumberFrequencyPoint, NumberAntenna);

AmplitudeCo = zeros(NumberPhi,NumberTheta, NumberFrequencyPoint, NumberAntenna);
AmplitudeCross = zeros(NumberPhi,NumberTheta,  NumberFrequencyPoint, NumberAntenna);
PhaseCo = zeros(NumberPhi,NumberTheta, NumberFrequencyPoint, NumberAntenna);
PhaseCross = zeros(NumberPhi,NumberTheta, NumberFrequencyPoint, NumberAntenna);


for ant = 1:4
    for i = 1:7
        freq = 240 + i*5;
        filename = strcat('ant',num2str(ant),'GAIN_0',num2str(freq),'00.TXT');
        f = fopen(filename,'r');
        nLine = 0;
        k = 0;
        h = 0;
        while ~feof(f)
            line = fgets(f); %# read line by line
            sp_line = strsplit(line); 
            nLine = nLine + 1;

            if (nLine >= 12) && (nLine <= 2675)
                h = h + 1;
                AmplitudeCoLine(h,i,ant) = str2double(cell2mat(sp_line(4)))/1000; %Divided by 1000 due to the problem of converting european number to american number 
                PhaseCoLine(h,i,ant) = str2double(cell2mat(sp_line(5)))/1000;
            elseif (nLine >= 2676)
                k = k + 1;
                AmplitudeCrossLine(k,i,ant) = str2double(cell2mat(sp_line(4)))/1000;
                PhaseCrossLine(k,i,ant) = str2double(cell2mat(sp_line(5)))/1000;
            end
        end
        
        AmplitudeCo(:,:,i,ant) = reshape(AmplitudeCoLine(:,i,ant),NumberPhi,NumberTheta);
        PhaseCo(:,:,i,ant) = reshape(PhaseCoLine(:,i,ant),NumberPhi,NumberTheta);
        AmplitudeCross(:,:,i,ant) = reshape(AmplitudeCrossLine(:,i,ant),NumberPhi,NumberTheta);
        PhaseCross(:,:,i,ant) = reshape(PhaseCrossLine(:,i,ant),NumberPhi,NumberTheta);
        
        fclose(f);
    end
end

% Gain.AmplitudeCo = AmplitudeCo;
% Gain.PhaseCo = PhaseCo;
% Gain.AmplitudeCross = AmplitudeCross;
% Gain.PhaseCross = PhaseCross;
% 
% save('AntennaGain.mat', 'Gain')

