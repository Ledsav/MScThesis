function avg_pat=pat(bvp_RR,ecg_RR,fs,type)
% type = 'nn' if you want not normalized version 
%type = 'n' if you want the normalized version

pat=[];

if bvp_RR(1)<ecg_RR(1)
    bvp_RR=bvp_RR(2:end);
end

if length(ecg_RR)>length(bvp_RR)
    ecg_RR=ecg_RR(1:end-1);
end

% we have two types, the not normalized and the normalized that changes
% based on the kth ecgRR sample.

if(type == "nn")
for i=1:length(ecg_RR)
    
   %not normalized
    pat=[pat (bvp_RR(i)-ecg_RR(i))/fs];
   
    
end
else
  for i=1:length(ecg_RR)-1  
    %normalized
    pat=[pat ((bvp_RR(i)-ecg_RR(i))/(ecg_RR(i+1)-ecg_RR(i)))];
  end  
end
avg_pat=mean(pat);
