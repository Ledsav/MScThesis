function avg_PulsePulse=av_PulsePulse(syst_sample)

% syst_sample=uno;
% diast_sample=due;
% syst_amp=tre;
% diast_amp=quattro;

pp=diff(syst_sample/2048);

avg_PulsePulse=mean(pp);
