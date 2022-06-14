function [pat_subjs,pp_subjs] = PAT_PP_subjects(path)
%% Analysis of PAT per subject

%where to save the struct

%extracting the list of subjects from the folder
codes = dir(path);
code_list = {codes.name};
code_list_var = code_list(3:end);
phases = ["b1","sad","b2","relax","b3","happy","b4","fear"];

pat=[];
pat_subjs = cell(length(code_list_var),1);

for i = 1:length(phases)
pat_subjs{1,i} = phases(i);
end

pp=[];
pp_subjs = cell(length(code_list_var),1);

for i = 1:length(phases)
pp_subjs{1,i} = phases(i);
end

seconds_division=[120 420 720 1020  1320  1620 1920  2220 2520]*2048;

for i = 1:length(code_list_var)
    
    subject = strcat(code_list_var(i),'.txt_ecg_bvp_ann.mat');
    direc = strcat(path,code_list_var(i),'\',subject);
    
    if isfile(direc{1})
        load(direc{1})
    end
    
    ecg_samples=data.annotations(1,:);
    onset=data.annotations(2,:);
    sys_ann=data.annotations(4,:);
    sys_amp=data.annotations(5,:);
    dias_ann=data.annotations(6,:);
    dias_amp=data.annotations(7,:);
    
 for n=1:8


    
    
    ecg_RR =  ecg_samples(ecg_samples >= seconds_division(n) & ecg_samples < seconds_division(n+1));
    bvp_RR = sys_ann(sys_ann >= seconds_division(n) & sys_ann < seconds_division(n+1));
    fs=2048;
    
    
% pat computation
if bvp_RR(1)<ecg_RR(1)
    bvp_RR=bvp_RR(2:end);
end
if length(ecg_RR)>length(bvp_RR)
    ecg_RR=ecg_RR(1:end-1);
end
for k=1:length(ecg_RR)
    pat=[pat (bvp_RR(k)-ecg_RR(k))/fs];
end


    syst_sample = sys_ann(sys_ann >= seconds_division(n) & sys_ann < seconds_division(n+1));
    syst_amp = sys_amp(sys_ann >= seconds_division(n) & sys_ann < seconds_division(n+1));
    diast_sample = dias_ann(dias_ann >= seconds_division(n) & dias_ann < seconds_division(n+1));
    diast_amp = dias_amp(dias_ann >= seconds_division(n) & dias_ann < seconds_division(n+1));

% pp computation
if  syst_sample(1)<diast_sample(1)
    syst_sample=syst_sample(2:end);
    syst_amp=syst_amp(2:end);
end
if length(syst_sample)<length(diast_sample)
    diast_sample=diast_sample(1:end-1);
    diast_amp=diast_amp(1:end-1);
end
for j=1:length(syst_sample) 
    pp=[pp syst_amp(j)-diast_amp(j)];
end

% storing the pat and pp values for every subject divided in phases
pat_subjs{i+1,n} = pat;
pat = [];
pp_subjs{i+1,n} = pp;
pp = [];
 end
end

end


