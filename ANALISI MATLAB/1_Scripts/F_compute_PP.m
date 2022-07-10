close,clear,clc

%where to save the struct 
path = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\';
%extracting the list of subjects from the folder
codes = dir('C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\');
code_list = {codes.name};
code_list_var = code_list(3:end);


for i = 1:length(code_list_var)
    save_list=strcat(path,code_list_var(i),'\');
    subject = strcat(code_list_var(i),'.txt_ecg_bvp_ann.mat');
    direc = strcat(path,code_list_var(i),'\',subject);
if isfile(direc{1}) && not(isfile(strcat(save_list,'FRR_',code_list_var(i),'.mat')))
    load(direc{1})
    F_RR=get_features_RR_1signal(data.annotations(1,:),'sel_EKGR',1,'fs',2048,'PPorderMono',9,'get_PP',1,'UndSampl',20,'get_spectra',1,'get_TimeDomain',1,'get_Freqs',1,'get_Compl',1);
    F_RR_name = strcat(save_list,'FRR_',code_list_var(i),'.mat');
    save(F_RR_name{1},'F_RR')
end
end





        