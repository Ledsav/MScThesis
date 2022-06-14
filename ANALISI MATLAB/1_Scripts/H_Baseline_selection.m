clear,close,clc

%% Analysisi of the signals variance divided per phases

%where to save the struct
path = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\';
path_sbgjs= 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\ANALISI MATLAB\soggetti\';
%extracting the list of subjects from the folder
codes = dir('C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\');
code_list = {codes.name};
code_list_var_ = code_list(3:end);

length_signals = (2520)*2048-120*2048;


Skin = zeros(length(code_list_var_),length_signals);
resp = zeros(length(code_list_var_),length_signals);
ppg= zeros(length(code_list_var_),length_signals);
ecg = zeros(length(code_list_var_),length_signals);




for i = 1:length(code_list_var_)
    sbj = strcat(code_list_var_(i),'.txt');
    
    [Time, EKGProFlex1A, HRBVPProFlex1B, SCProFlex1C, RespProFlex1D] = importfile_procomp(sbj{1});
    
    
    Skin(i,:) = SCProFlex1C(120*2048:(2520)*2048-1)';
    resp(i,:) = RespProFlex1D(120*2048:(2520)*2048-1)';
    ppg(i,:)= HRBVPProFlex1B(120*2048:(2520)*2048-1)';
    ecg(i,:) = EKGProFlex1A(120*2048:(2520)*2048-1)';
    
    
    
end
s = 0;
for k = 1:8
    Skin_var(k) = mean(var(Skin(:,1+s:length_signals/8*k),0,2));
    resp_var(k) = mean(var(resp(:,1+s:length_signals/8*k),0,2));
    ppg_var(k)= mean(var(ppg(:,1+s:length_signals/8*k),0,2));
    ecg_var(k) = mean(var(ecg(:,1+s:length_signals/8*k),0,2));
    
    s = length_signals/8*k;
    
end

signals_variance(1,:) = Skin_var;
signals_variance(2,:) = resp_var;
signals_variance(3,:) = ppg_var;
signals_variance(4,:) = ecg_var;


[M, I] = min(signals_variance,[],2);


%% Pat & PP

path = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\';

%visualization of pat and pp for every subject (sys PAT)
[PAT,PP]=PAT_PP_subjects(path);


for i=1:37
    vari(i,1) = var(PP{i+1,8},0,2) ;
end

close all
plot_individual_PAT_PP(1,PAT,PP)

%% fai plot segnali per ogni paziente (pat(nno),pp,resp,taco,PulsePulse,skin)
path = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\';
codes = dir(path);
code_list = {codes.name};
code_list_var = code_list(3:end);

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
    
    t_ann{i,1} = data.annotations(1,:)/2048;
    taco{i,1} = diff(ecg_samples/2048);
    a = tot_pat(onset,ecg_samples,2048,'nn');
    b = tot_pp(onset,dias_ann,sys_amp,dias_amp);
    pat{i,1} = a(2:end);
    pp{i,1} = b(2:end);
    pupu_ann{i,1} =  data.annotations(4,2:end)/2048;
    PulsePulse{i,1} = diff(sys_ann/2048);
    
    
    sbj = strcat(code_list_var(i),'.txt');
    path_sbgjs= 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\ANALISI MATLAB\soggetti\';
    if  isfile(strcat(path_sbgjs,sbj))
        procomp=importdata(sbj{1});
        t_sign{i,1} =  procomp.data(2:end,1);
        resp{i,1} = procomp.data(2:end,5);
        skin{i,1} = procomp.data(2:end,4);
    end
end

save('Signals_subjects','t_ann','taco','pupu_ann','PulsePulse','pat','pp','t_sign','resp','skin')    

% %the max is computed as the mean of the three highest values outside fear
% %in all the protocol
% for i=1:length(taco)
% col = cell2mat(t_ann(i)) >120 & cell2mat(t_ann(i)) < 2220;
% taco_i = cell2mat(taco(i));
% mean_3max(i,1) = mean(maxk(taco_i(col),3),2);
% 
% 
% pp_i = cell2mat(pp(i));
% mean_3max(i,2) = mean(maxk(pp_i(col),3),2);
% 
% 
% col = cell2mat(t_sign(i)) >120 & cell2mat(t_sign(i)) < 2220;
% sc_i = cell2mat(skin(i));
% mean_3max(i,3) = mean(maxk(unique(sc_i(col)),3),1);
% end
% 
% writematrix(mean_3max,'mean_3max.xlsx')
