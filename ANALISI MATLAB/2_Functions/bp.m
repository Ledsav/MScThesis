function [signal_bp]=bp(signal,fs)



fcut=2; %4
[B,A] = butter(4,fcut/(fs/2),'low');
y = filtfilt(B,A,signal);

%Downsampling at 8 Hz or around 8 Hz
signal=downsample(y,round(fs/8));

fs=fs/round(fs/8);

f1=0.5;
f2=1;
[a,b] = butter(1,[f1 f2]/fs/2,'bandpass');
signal_bp = filtfilt(a,b,signal); 