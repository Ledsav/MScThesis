function [phasic]=median2(signal_filtered_down,fs_down)


%www.imotions.com

% Inputs:
% signal = raw signal
% fs = sampling frequency
% 
% Outputs:
% phasic = phasic component of SC raw signal found by means of a median filter
% signal_res = signal resempled at 5 Hz
% fs_new = new sampling frequency
% tonic= tonic component

% fcut=2; %4
% [B,A] = butter(4,fcut/(fs/2),'low');
% y = filtfilt(B,A,signal);
% 
% %Downsampling at 8 Hz or around 8 Hz
% if mod(fs,8)==0
%     x=fs/8;
%     fs_new=fs/x;
%     signal=y(1:x:end);
% else
%     x=floor(fs/8);
%     fs_new=fs/x;
%     signal=y(1:x:end);
% end
   
%Compute 4 seconds in samples
signal=signal_filtered_down;
samples=fs_down*4;

phasic=[];

% %Low pass filter
% fc=1;
% [a,b] = butter(3,fc/fs/2,'low');                                          
% signal = filtfilt(a,b,signal); 

%Median filter +/- 4 seconds
for i=1:length(signal)
    
    try
    m=median(signal(i-samples:i+samples));
     phasic(i)=m;
%  phasic(i)=m-mean(signal);
    
    catch
        if i>round(length(signal)/2)
             m=median(signal(i:end));
             phasic(i)=m;
%  phasic(i)=m-mean(signal);
             
        else
             m=median(signal(1:i));
             phasic(i)=m;
% phasic(i)=m-mean(signal);
        end
            
    end
end

phasic=signal-phasic';
% tonic=signal-phasic;
    
