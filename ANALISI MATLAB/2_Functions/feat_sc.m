function [onset_index,offset_index,peaks_index,avg_amp_peaks,avg_rise_time,avg_rec_time,n_peaks,sd_amp_peaks]=feat_sc(signal_filtered_down,fs_down,phasic,er)



% Inputs:
% signal = raw signal
% fs = sampling frequency
% phasic = phasic component of sc
% tonic = tonic component of sc
% er = if the experiment is event-related
%     
   
% Outputs:
% onset_index = occurences of onsets
% offset_index = occurences of offsets
% peaks_index = occurences of Tough-to-peaks (TTPs)
% avg_amp_peaks= average amplitude of TTPs
% avg_rise_time = average rise time of the SC dynamics
% avg_rec_time = average recovery time of the SC dynamics
% n_peaks = number of TTPs
% avg_tonic = average of the tonic component
% sd_amp_peaks = sd of the TTPs
% 

signal=signal_filtered_down;
fs=fs_down;
onset_index=[];
offset_index=[];
peaks_index=[];

%If the experiment is event-related (er=1), we don't consider responses (onset)
%before the first second of acquisition

flag=0;
for i=1:length(phasic)
    
     if phasic(i)>0.01 && flag==0 
         
         if er==1 && i<fs
         else 
         onset_index=[onset_index;i];
         flag=1;
         end
         
     elseif phasic(i)<0 && flag==1
             offset_index=[offset_index;i];
             flag=0;
     end
end

    

l1=length(onset_index);
l2=length(offset_index);
peaks_index=[];

if l1>l2
    onset_index=onset_index(1:end-1);

end
l=length(onset_index);

pos_delete=[];
for i=1:l
    
    if (offset_index(i)-onset_index(i))<2    
        pos_delete=[pos_delete;i];  
    else
    [~,pos]=max(signal(onset_index(i)+1:offset_index(i)-1));
    peaks_index=[peaks_index;onset_index(i)+1+pos];
    end
    
end
 
%If the onset and offset are distant less than 1 sample, they are discarded 
pos_delete=sort(pos_delete,'descend');
onset_index(pos_delete) = [];
offset_index(pos_delete) = [];


peaks=signal(peaks_index); %maybe zscore
amp_peaks=signal(peaks_index)-signal(onset_index);
avg_amp_peaks=mean(amp_peaks);
sd_amp_peaks=std(amp_peaks);


avg_rise_time=mean((peaks_index-onset_index)./fs);
avg_rec_time=mean((offset_index-peaks_index)./fs);
n_peaks=length(peaks_index);


feat={'avg_amp_peaks';'avg_rise_time';'avg_rec_time';'sd_amp_peaks'};

for i=1:size(feat,1)
    
    eval(['f' '=' feat{i,:} ';']);
    
    if isnan(f)
        
        f=0;
        
        eval([feat{i,:}  '=' 'f' ';']);
    end
    
    
end

    
    
    
    





