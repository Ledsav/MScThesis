clear,close,clc
%where to save the struct
path = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\';
path_sbgjs= 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\ANALISI MATLAB\soggetti\';
%extracting the list of subjects from the folder
codes = dir('C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\');
code_list = {codes.name};
code_list_var = code_list(3:end);


for i = 1:length(code_list_var)
    sbj = strcat(code_list_var(i),'.txt');
    save_list=strcat(path,code_list_var(i),'\');
    if  isfile(strcat(path_sbgjs,sbj)) && not(isfile(strcat(save_list{1},sbj{1},'_','ecg_bvp','.mat')))
        procomp=importdata(sbj{1});
        data.annotations.ecg=[];
        data.annotations.ppg=[];
        data.ecg=procomp.data(2:end,2);
        data.fs=2048;
        data.ppg=procomp.data(2:end,3);
        save(strcat(save_list{1},sbj{1},'_','ecg_bvp','.mat'),'data')
    end
end

