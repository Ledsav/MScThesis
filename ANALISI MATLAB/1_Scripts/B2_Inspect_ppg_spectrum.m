close,clear,clc

%where to save the struct
path = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\';
path_sbgjs= 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\ANALISI MATLAB\soggetti\';
%extracting the list of subjects from the folder
codes = dir('C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\');
code_list = {codes.name};
code_list_var = code_list(3:end);
scenes_x = ([0 300,600,900,1200,1500,1800,2100,2400]+120)*2048;

for i = 1:1%length(code_list_var)
    sbj = strcat(code_list_var(i),'.txt');
    save_list=strcat(path,code_list_var(i),'\');
    if  isfile(strcat(path_sbgjs,sbj)) 
        procomp=importdata(sbj{1});
        ppg=procomp.data(2:end,3);
        resp=procomp.data(2:end,end);
        
        for k=1:8
        %spect_ppg{i,k} = pyulear(ppg(scenes_x(k):scenes_x(k+1)),50);
        spect_ppg{i,k} = fft(ppg(scenes_x(k):scenes_x(k+1)));
        %spect_resp{i,k} = pyulear(resp(scenes_x(k):scenes_x(k+1)),3);
        end
    end
end


n = length(spect_ppg{1,8});          % number of samples
f = (0:n-1)*(2048/n);     % frequency range
power = abs(spect_ppg{1,8}).^2/n;    % power of the DFT

plot(f,power)
xlabel('Frequency')
ylabel('Power')