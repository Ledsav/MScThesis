function [slope_gsrbp,max_sign_amp_gsrbp,avg_der_gsrbp,sd_der_gsrbp,max_der_gsrbp]=gsrbp2(signal_filtered_down_bp)

%Fleureau, Julien, Philippe Guillotel, and Quan Huynh-Thu.
% "Physiological-based affect event detector for entertainment video applications." 
% IEEE Transactions on Affective Computing 3.3 (2012): 379-385.

% 
% Inputs:
% signal_bp = signal filtered between 0.5 and 1 Hz
% fs = sampling frequency
%  
% Outputs:
% slope_gsrbp = slope of the SC signal band pass filtered between 0.5 and 1
% Hz (SCbp) and downsampled at 8 Hz
% max_sign_amp_gsrbp = maximum signed amplitude between 2 consecutive extrema of band pass SC (maxmum range with sign between a consecutive max-min)
% avg_der_gsrbp = average of the first derivative of SCbp
% sd_der_gsrbp = sd of the first derivative of SCbp
% max_der_gsrbp = maximum of the first derivative of SCbp


% %Filtering
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
% 
% % fs=fs_new;
% f1=0.5;
% f2=1;
% [a,b] = butter(1,[f1 f2]/fs/2,'bandpass');
% signal_bp = filtfilt(a,b,signal); 


signal=signal_filtered_down_bp;
% signal=(signal-mean(signal))./std(signal);
[~,b]=findpeaks(signal);
% c=find(signal(b)>0);

len = length(signal);
zero = find(~signal);
len_zero = length(zero);

if(len_zero == len)
    slope_gsrbp = 0;
    max_sign_amp_gsrbp = 0;
    avg_der_gsrbp = 0;
    sd_der_gsrbp = 0;
    max_der_gsrbp = 0;

    
else
p1=polyfit(1:length(signal),signal',1);
x1=linspace(1,0.1,length(signal));
y11=polyval(p1,x1);

slope_gsrbp=p1(1);



pos_min=[];
for i=1:length(b)-1
    s=signal(b(i):b(i+1));
    [~,e]=min(s);
    pos_min=[pos_min;b(i)+e];
    
end

avg_der_gsrbp=mean(diff(signal));
sd_der_gsrbp=std(diff(signal));
max_der_gsrbp=max(diff(signal));


dist=0;
position=0;
for i=1:length(b)-1
    
    neg=abs(signal(b(i))-signal(pos_min(i)));
    pos=abs(signal(pos_min(i))-signal(b(i+1)));
    
    mat=[neg pos];
    
    [f,g]=max(mat);
    
    if g==1 && f>dist
        dist=f;
        flag=0;
  
    elseif g==2 && f>dist
        dist=f;
        flag=1; 
        
    end
    
end

if flag==0
    max_sign_amp_gsrbp=-dist;
else
    max_sign_amp_gsrbp=dist;
    
end

end
end


%plot(signal),hold on,plot(b,signal(b),'r*'), hold on, plot(pos_min,signal(pos_min),'g*'), hold on, plot(position, signal(position),'co')





