function [avg,sd,avg_abs1,avg_abs1_norm,avg_abs2,avg_abs2_norm]=Picard(signal_filtered_down)

signal=signal_filtered_down;
avg=mean(signal);
sd=std(signal);
avg_abs1=mean(abs(diff(signal)));
avg_abs2=mean(abs(diff(diff(signal))));
avg_abs1_norm=mean(abs(diff((signal-mean(signal))./std(signal))));
avg_abs2_norm=mean(abs(diff(diff((signal-mean(signal))./std(signal)))));
