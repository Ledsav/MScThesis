function total_pp = tot_pp(syst_sample,diast_sample,syst_amp,diast_amp)

% syst_sample=uno;
% diast_sample=due;
% syst_amp=tre;
% diast_amp=quattro;

pp=[];

if  syst_sample(1)<diast_sample(1)
    syst_sample=syst_sample(2:end);
    syst_amp=syst_amp(2:end);
end

if length(syst_sample)<length(diast_sample)
    diast_sample=diast_sample(1:end-1);
    diast_amp=diast_amp(1:end-1);
end

for i=1:length(syst_sample)
    
   
    pp=[pp syst_amp(i)-diast_amp(i)];
   
    
end

total_pp = pp;
end