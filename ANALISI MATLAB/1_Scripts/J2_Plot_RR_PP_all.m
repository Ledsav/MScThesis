clear,clc,close
%Plot RR over PP

%where to save the struct 
path = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\';
%extracting the list of subjects from the folder
codes = dir('C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\');
code_list = {codes.name};
code_list_var = code_list(3:end);
scenes_x = ([0 300,600,900,1200,1500,1800,2100,2400]+120);
f1=figure();
for i = 1:length(code_list_var)
    save_list=strcat(path,code_list_var(i),'\');
    subject_ann = strcat(code_list_var(i),'.txt_ecg_bvp_ann.mat');
    subject_PP = strcat('FRR_',code_list_var(i),'.mat');
    direc{1} = strcat(path,code_list_var(i),'\',subject_ann{1});
    direc{2} = strcat(path,code_list_var(i),'\',subject_PP{1});
    file = strcat(save_list{1},code_list_var(i),'_ExRR_PPRR.fig');
    if isfile(direc{1}) && isfile(direc{2})
        
        % RR from annotations
        data_Ann = load(subject_ann{1});
        RR_tot = diff(data_Ann.data.annotations(1,:))/2048;
        
        
        t_RR_tot = data_Ann.data.annotations(1,2:end)/2048;
        %%taking only after DD scene (after 120s)
        start = find(t_RR_tot>=120 & t_RR_tot<122 );
        end_ = find(t_RR_tot>=2520 & t_RR_tot<2522);
        t_RR = t_RR_tot(start(1):end_(1));
        RR = RR_tot(start(1):end_(1));

        
        % RR from PP
        F_RR = load(subject_PP{1});
        t_PP_tot=F_RR.F_RR.PP.Mono.t0+(0:F_RR.F_RR.PP.Mono.delta:length(F_RR.F_RR.PP.Mono.Mu)*F_RR.F_RR.PP.Mono.delta-F_RR.F_RR.PP.Mono.delta);
        PP_tot = F_RR.F_RR.PP.Mono.Mu;
        %%taking only after DD scene (after 120s)
        start = find(t_PP_tot>=120 & t_PP_tot<122 );
        end_ = find(t_PP_tot>=2520 & t_PP_tot<2522);
        t_PP = t_PP_tot(start(1):end_(1));
        PP = PP_tot(start(1):end_(1));
        
        
        %plot the Tachogram and the PP togheter
        set(f1,'WindowState','maximized')
        plot(t_RR,RR)
%         hold on
%         plot(t_PP,PP)
         hold on
        
        if(i==1)
        %different scenes    
        for k=1:length(scenes_x)
            xline(scenes_x(k),'--b','LineWidth',1)
        end
        xlim([120 2520])
        xlabel('Time[s]')
        ylabel('RR[s]')
        title(strcat(code_list_var(i),' Extracted RR and PP RR'))
        %legend('Extracted RR','PP','Start scene')
        end

        
    end
end
