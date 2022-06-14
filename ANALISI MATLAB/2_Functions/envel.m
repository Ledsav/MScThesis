function [env,area,yupper]=envel(phasic)

if (length(phasic)<20)
    env = 0;
    area = 0;
    yupper = 0;
else

% Modulo del segnale
% Calcolo l'inviluppo unendo i massimi --> yupper
% env=media dell'inviluppo
% area= area sottesa dall'inviluppo
signal=abs(phasic);
[yupper,~] = envelope(signal);
env=mean(yupper);
area=sum(yupper);
end
end

