function [sc_filtered]=sc_filter(signal,fs)

fcut=2; 
[B,A] = butter(4,fcut/(fs/2),'low');
sc = filtfilt(B,A,signal);
sc_filtered=downsample(sc,round(fs/8));