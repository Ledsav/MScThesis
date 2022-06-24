%function [GSR_total,PAT_total,F_OO_total,PP_total,POINT_total,RESP_total] = Statistics(option)

%option can be either depolarized_all_baselines ore not_depolarized
clear,close,clc
%option = "not_depolarized";
% option = "depolarized_all_baselines";
% option = 1; %depolarized in respect to baseline 1
 option = 2; %depolarized in respect to baseline 2
% option = 3; %depolarized in respect to baseline 3
% option = 4; %depolarized in respect to baseline 4

% STATISTICS (freedman-bonf)

%where to save the struct
path = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\';
%extracting the list of subjects from the folder
codes = dir('C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\');
code_list = {codes.name};
subjects = code_list(3:end);
%phases = ["b1","sad","b2","relax","b3","happy","b4","fear"];
delet = [];


%GSR

GSR_total = {};
GSR_total{2,1} = 'baselines';
GSR_total{3,1} = 'feauters';
GSR_total{4,1} = 'pvalues';
GSR_total{5,1} = 'stats';
GSR_total{6,1} = 'multicompare';
GSR_total{7,1} = 'variance of the features';

PAT_total = {};
PAT_total{2,1} = 'baselines';
PAT_total{3,1} = 'feauters';
PAT_total{4,1} = 'pvalues';
PAT_total{5,1} = 'stats';
PAT_total{6,1} = 'multicompare';
PAT_total{7,1} = 'variance of the features';

PulsePulse_total = {};
PulsePulse_total{2,1} = 'baselines';
PulsePulse_total{3,1} = 'feauters';
PulsePulse_total{4,1} = 'pvalues';
PulsePulse_total{5,1} = 'stats';
PulsePulse_total{6,1} = 'multicompare';
PulsePulse_total{7,1} = 'variance of the features';


PP_total = {};
PP_total{2,1} = 'baselines';
PP_total{3,1} = 'feauters';
PP_total{4,1} = 'pvalues';
PP_total{5,1} = 'stats';
PP_total{6,1} = 'multicompare';
PP_total{7,1} = 'variance of the features';


F_OO_total = {};
F_OO_total{2,1} = 'feauters types';

POINT_total = {};
POINT_total{2,1} = 'baselines';
POINT_total{3,1} = 'feauters';
POINT_total{4,1} = 'pvalues';
POINT_total{5,1} = 'stats';
POINT_total{6,1} = 'multicompare';
POINT_total{7,1} = 'variance of the features';

RESP_total = {};
RESP_total{2,1} = 'baselines';
RESP_total{3,1} = 'feauters';
RESP_total{4,1} = 'pvalues';
RESP_total{5,1} = 'stats';
RESP_total{6,1} = 'multicompare';
RESP_total{7,1} = 'variance of the features';

for k=1:length(subjects)
    if(not(isfile(strcat(path,subjects{k},'\feauters\',subjects{k},'_feauters','.mat'))))
        delet = [delet k] ;
    end
end

subjects(delet)=[];

%% GSR
%preload data to define struct
load(strcat(path,subjects{1},'\feauters\',subjects{1},'_feauters','.mat'));
phases = fieldnames(GSR);
gsr_feauters = fieldnames(GSR.sad);
var_features{1,1} = "baselines";
var_features{1,2} = "phases";

%path to save images
path_imgs = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\ANALISI MATLAB\5_figures\Statistics\GSR_planB';

for n=1:length(gsr_feauters)
    for i=2:9
        for k=1:length(subjects)
            %normalization in respect the baseline
            load(strcat(path,subjects{k},'\feauters\',subjects{k},'_feauters','.mat'));
            temp(k,i) = GSR.(phases{i}).(gsr_feauters{n});
            
        end
    end
    
    GSR_total{1,n+1} = gsr_feauters{n};
    
    %uploading the feauters unbiased by the baselines
    temp = temp(:,2:end);
    
    if  (class(option) ~= "double")
        if (option == "depolarized_all_baselines" )
            
            b_temp = temp(:,1:2:end);
            GSR_total{2,n+1} = b_temp;
            
            diff_temp = diff(temp,1,2);
            diff_temp(:,2:2:end)=[];
            GSR_total{3,n+1} = diff_temp;
            
            %uploading the p values
            [p_diff,tbl,stats] = friedman(diff_temp,1);
            GSR_total{4,n+1} = p_diff;
            %uploading stats
            GSR_total{5,n+1} = stats;
            %uploading the multcompare
            md = multcompare(stats,'CType','hsd');
            GSR_total{6,n+1} = md;
            
            close all
            
        elseif (option == "not_depolarized" )
            b_temp = temp(:,1:2:end);
            GSR_total{2,n+1} = b_temp;
            
            temp(:,1:2:end)=[];
            GSR_total{3,n+1} = temp;
            
            %uploading the p values
            [p,tbl,stats] = friedman(temp,1);
            GSR_total{4,n+1} = p;
            %uploading stats
            GSR_total{5,n+1} = stats;
            %uploading the multcompare
            md = multcompare(stats,'CType','hsd');
            GSR_total{6,n+1} = md;
            
            %computing the variance over the feauters
            var_b = var(b_temp,0,1);
            var_p = var(temp,0,1);
            
            
            var_features{2,1} = var_b;
            var_features{2,2} = var_p;
            
            GSR_total{7,n+1} = var_features;
            
            close all
        end
    else
        baselines = temp(:,[1 3 5 7]);
        GSR_total{2,n+1} = baselines;
        b = baselines(:,option);
        temp(:,1:2:end)=[];
        temp = temp - b;
        GSR_total{3,n+1} = temp;
        
        %uploading the p values
        [p_diff,tbl,stats] = friedman(temp,1);
        GSR_total{4,n+1} = p_diff;
        %uploading stats
        GSR_total{5,n+1} = stats;
        %uploading the multcompare
        md = multcompare(stats,'CType','hsd');
        GSR_total{6,n+1} = md;
        close all
    end
    
    
end

%plot_boxplot_and_stats(GSR_total,path_imgs)


% visualize boxplots

%treand avg means
% m_avg=[mean(GSR_total{2,12});mean(GSR_total{3,12})]';
% bar(m_avg)
% hold on
% plot(xlim-0.51,[mean([m_avg(:,1);m_avg(1:end-1,2)]) mean([m_avg(:,1);m_avg(1:end-1,2)])],'r','LineWidth',2)
% xticklabels({'b1 sad','b2 relax','b3 happy','b4 fear'})
% ylabel('Avarage Skin conductance [\muS]')
% xlabel('Bseline and Experience')
% title('Avarage Skin conductance along the protocol and mean visualization')
% txt = 'mean(experience - fear)';
% text(1,mean([m_avg(:,1);m_avg(1:end-1,2)])+0.15,txt)
% xlim([0.5 4.5])
% saveas(gcf,'Avarage Skin conductance along the protocol and mean visualization.fig')


% %difference study
%m_avg_diff= -mean(GSR_total{2,12})'+ mean(GSR_total{3,12})';
% bar(m_avg_diff)
% xticklabels({'sad-b1','relax-b2','happy-b3','fear-b4'})
% ylabel('Avarage Skin conductance [\muS]')
% xlabel('Experience-Baseline')
% title('Response SC emotions')
% saveas(gcf,'Response SC emotions.fig')
%reference = GSR_total{3,12}(:,4)- GSR_total{2,12}(:,)],2);
% writematrix(reference,'reference.xlsx')
%% PAT

%preload data to define struct
load(strcat(path,subjects{1},'\feauters\',subjects{1},'_feauters','.mat'));
phases = fieldnames(PAT.no);
var_features{1,1} = "baselines";
var_features{1,2} = "phases";

%pat to save images
path_imgs = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\ANALISI MATLAB\5_figures\Statistics\PAT_planB';

for n=1:length(PAT.no.(phases{1}))
    for i=2:9
        for k=1:length(subjects)
            %normalization in respect the baseline
            load(strcat(path,subjects{k},'\feauters\',subjects{k},'_feauters','.mat'));
            temp(k,i) = PAT.no.(phases{i});
            
        end
    end
    
    PAT_total{1,n+1} = 'PAT';
    
    %uploading the feauters unbiased by the baselines
    temp = temp(:,2:end);
    if  (class(option) ~= "double")
        if (option == "depolarized_all_baselines" )
            b_temp = temp(:,1:2:end);
            PAT_total{2,n+1} = b_temp;
            
            diff_temp = diff(temp,1,2);
            diff_temp(:,2:2:end)=[];
            PAT_total{3,n+1} = diff_temp;
            
            %uploading the p values
            [p_diff,tbl,stats] = friedman(diff_temp,1);
            PAT_total{4,n+1} = p_diff;
            %uploading stats
            PAT_total{5,n+1} = stats;
            %uploading the multcompare
            md = multcompare(stats,'CType','hsd');
            PAT_total{6,n+1} = md;
            
            close all
            
        elseif (option == "not_depolarized" )
            b_temp = temp(:,1:2:end);
            PAT_total{2,n+1} = b_temp;
            
            temp(:,1:2:end)=[];
            PAT_total{3,n+1} = temp;
            
            %uploading the p values
            [p,tbl,stats] = friedman(temp,1);
            PAT_total{4,n+1} = p;
            %uploading stats
            PAT_total{5,n+1} = stats;
            %uploading the multcompare
            md = multcompare(stats,'CType','hsd');
            PAT_total{6,n+1} = md;
            
            %computing the variance over the feauters
            var_b = var(b_temp,0,1);
            var_p = var(temp,0,1);
            
            
            var_features{2,1} = var_b;
            var_features{2,2} = var_p;
            
            PAT_total{7,n+1} = var_features;
            
            
            close all
        end
    else
        baselines = temp(:,[1 3 5 7]);
        PAT_total{2,n+1} = baselines;
        b = baselines(:,option);
        temp(:,1:2:end)=[];
        temp = temp - b;
        PAT_total{3,n+1} = temp;
        
        %uploading the p values
        [p_diff,tbl,stats] = friedman(temp,1);
        PAT_total{4,n+1} = p_diff;
        %uploading stats
        PAT_total{5,n+1} = stats;
        %uploading the multcompare
        md = multcompare(stats,'CType','hsd');
        PAT_total{6,n+1} = md;
        close all
    end
end

%plot_boxplot_and_stats(PAT_total,path_imgs)


% save('PAT_struct','PAT_total')
%visualize boxplots to identify the difference with all pat changes

% subplot(1,2,1)
% boxplot(PAT_total{2,2},'labels',{'b1','b2','b3','b4'})
% title('mean PAT Baselines normalized (dias)')
%
% subplot(1,2,2)
% boxplot(PAT_total{3,2},'labels',{'sad','relax','happy','fear'})
% title('mean PAT Phases normalized (dias)')
%
% %
% % saveas(gcf,'PAT_boxplot ns','fig')
% %
% %
% close all
%
% figure()
% boxplot(PAT_total{2,2},'Colors','g')
% title('mean PAT Baselines vs Phases normalized (dias)')
% hold on
% boxplot(PAT_total{3,2},'labels',{'b1_sad','b2_relax','b3_happy','b4_fear'})
% saveas(gcf,'PAT_boxplot nd hold on','fig')
%% PulsePulse
%preload data to define struct
load(strcat(path,subjects{1},'\feauters\',subjects{1},'_feauters','.mat'));
phases = fieldnames(PulsePulse);
var_features{1,1} = "baselines";
var_features{1,2} = "phases";



for n=1:length(PulsePulse.(phases{1}))
    for i=2:9
        for k=1:length(subjects)
            %normalization in respect the baseline
            load(strcat(path,subjects{k},'\feauters\',subjects{k},'_feauters','.mat'));
            temp(k,i) = PulsePulse.(phases{i});
            
        end
    end
    
    PulsePulse_total{1,n+1} = 'avg_PulsePulse';
    
    %uploading the feauters unbiased by the baselines
    temp = temp(:,2:end);
    if  (class(option) ~= "double")
        if (option == "depolarized_all_baselines" )
            b_temp = temp(:,1:2:end);
            PulsePulse_total{2,n+1} = b_temp;
            
            diff_temp = diff(temp,1,2);
            diff_temp(:,2:2:end)=[];
            PulsePulse_total{3,n+1} = diff_temp;
            
            %uploading the p values
            [p_diff,tbl,stats] = friedman(diff_temp,1);
            PulsePulse_total{4,n+1} = p_diff;
            %uploading stats
            PulsePulse_total{5,n+1} = stats;
            %uploading the multcompare
            md = multcompare(stats,'CType','hsd');
            PulsePulse_total{6,n+1} = md;
            
            close all
            
        elseif (option == "not_depolarized" )
            b_temp = temp(:,1:2:end);
            PulsePulse_total{2,n+1} = b_temp;
            
            temp(:,1:2:end)=[];
            PulsePulse_total{3,n+1} = temp;
            
            %uploading the p values
            [p,tbl,stats] = friedman(temp,1);
            PulsePulse_total{4,n+1} = p;
            %uploading stats
            PulsePulse_total{5,n+1} = stats;
            %uploading the multcompare
            md = multcompare(stats,'CType','hsd');
            PulsePulse_total{6,n+1} = md;
            
            %computing the variance over the feauters
            var_b = var(b_temp,0,1);
            var_p = var(temp,0,1);
            
            
            var_features{2,1} = var_b;
            var_features{2,2} = var_p;
            
            PulsePulse_total{7,n+1} = var_features;
            close all
        end
    else
        baselines = temp(:,[1 3 5 7]);
        PulsePulse_total{2,n+1} = baselines;
        b = baselines(:,option);
        temp(:,1:2:end)=[];
        temp = temp - b;
        PulsePulse_total{3,n+1} = temp;
        
        %uploading the p values
        [p_diff,tbl,stats] = friedman(temp,1);
        PulsePulse_total{4,n+1} = p_diff;
        %uploading stats
        PulsePulse_total{5,n+1} = stats;
        %uploading the multcompare
        md = multcompare(stats,'CType','hsd');
        PulsePulse_total{6,n+1} = md;
        close all
    end
end



%% PP

%preload data to define struct
load(strcat(path,subjects{1},'\feauters\',subjects{1},'_feauters','.mat'));
phases = fieldnames(PP);
var_features{1,1} = "baselines";
var_features{1,2} = "phases";
pp_feauters = fieldnames(PP.sad);

%pat to save images
path_imgs = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\ANALISI MATLAB\5_figures\Statistics\PP_planB';

for n=1:length(pp_feauters)
    for i=2:9
        for k=1:length(subjects)
            %normalization in respect the baseline
            load(strcat(path,subjects{k},'\feauters\',subjects{k},'_feauters','.mat'));
            temp(k,i) = PP.(phases{i}).(pp_feauters{n});
            
        end
    end
    
    PP_total{1,n+1} = pp_feauters{n};
    
    %uploading the feauters unbiased by the baselines
    temp = temp(:,2:end);
    if  (class(option) ~= "double")
        if (option == "depolarized_all_baselines" )
            b_temp = temp(:,1:2:end);
            PP_total{2,n+1} = b_temp;
            
            diff_temp = diff(temp,1,2);
            diff_temp(:,2:2:end)=[];
            PP_total{3,n+1} = diff_temp;
            
            %uploading the p values
            [p_diff,tbl,stats] = friedman(diff_temp,1);
            PP_total{4,n+1} = p_diff;
            %uploading stats
            PP_total{5,n+1} = stats;
            %uploading the multcompare
            md = multcompare(stats,'CType','hsd');
            PP_total{6,n+1} = md;
            
            close all
            
        elseif (option == "not_depolarized" )
            b_temp = temp(:,1:2:end);
            PP_total{2,n+1} = b_temp;
            
            temp(:,1:2:end)=[];
            PP_total{3,n+1} = temp;
            
            %uploading the p values
            [p,tbl,stats] = friedman(temp,1);
            PP_total{4,n+1} = p;
            %uploading stats
            PP_total{5,n+1} = stats;
            %uploading the multcompare
            md = multcompare(stats,'CType','hsd');
            PP_total{6,n+1} = md;
            
            %computing the variance over the feauters
            var_b = var(b_temp,0,1);
            var_p = var(temp,0,1);
            
            
            var_features{2,1} = var_b;
            var_features{2,2} = var_p;
            
            PP_total{7,n+1} = var_features;
            close all
        end
    else
        baselines = temp(:,[1 3 5 7]);
        PP_total{2,n+1} = baselines;
        b = baselines(:,option);
        temp(:,1:2:end)=[];
        temp = temp - b;
        PP_total{3,n+1} = temp;
        
        %uploading the p values
        [p_diff,tbl,stats] = friedman(temp,1);
        PP_total{4,n+1} = p_diff;
        %uploading stats
        PP_total{5,n+1} = stats;
        %uploading the multcompare
        md = multcompare(stats,'CType','hsd');
        PP_total{6,n+1} = md;
        
        close all
    end
end

%plot_boxplot_and_stats(PP_total,path_imgs)

%BOXPLOTS____________________________
% figure()
% subplot(1,2,1)
% boxplot(PP_total{2,2})
% title('mean PP Baselines ')
%
% subplot(1,2,2)
% boxplot(PP_total{3,2})
% title('mean PP Phases ')

%PLOT AVG_MEAN____________________________
% m_avg=[mean(PP_total{2,2});mean(PP_total{3,2})]';
% bar(m_avg)
% hold on
% plot(xlim-0.51,[mean([m_avg(:,1);m_avg(1:end-1,2)]) mean([m_avg(:,1);m_avg(1:end-1,2)])],'r','LineWidth',2)
% xticklabels({'b1 sad','b2 relax','b3 happy','b4 fear'})
% ylabel('Avarage PP [A.U.]')
% xlabel('Bseline and Experience')
% title('Avarage PP along the protocol and mean visualization')
% txt = 'mean(experience - fear)';
% text(2.5,mean([m_avg(:,1);m_avg(1:end-1,2)])+0.2,txt)
% xlim([0.5 4.5])
% saveas(gcf,'Avarage PP along the protocol and mean visualization.fig')

%PLOT_AVG____________________________
% m_avg=[mean(PP_total{2,2});mean(PP_total{3,2})]';
% bar(m_avg)
% xticklabels({'b1 sad','b2 relax','b3 happy','b4 fear'})
% ylabel('Avarage PP [A.U.]')
% xlabel('Baseline - Experience')
% title('Avarage PP along the protocol')
%
% minim = min(min(m_avg));
% [row,col]=find(m_avg==minim);
%
% saveas(gcf,'Avarage PP along the protocol.fig')


% %PLOT_DIFF____________________________
% m_avg_diff= -mean(PP_total{2,2})'+ mean(PP_total{3,2})';
% bar(m_avg_diff)
% xticklabels({'sad-b1','relax-b2','happy-b3','fear-b4'})
% ylabel('Avarage PP [A.U.]')
% xlabel('Experience-Baseline')
% title('Response PP emotions')
% saveas(gcf,'Response PP emotions.fig')

% reference = PP_total{3,2}-PP_total{2,2};
% writematrix(reference,'reference.xlsx')

% reference = mean([PP_total{3,2}(:,1:3),PP_total{2,2}(:,1:4)],2);
% writematrix(reference,'reference.xlsx')

%% POINT
%preload data to define struct
load(strcat(path,subjects{1},'\feauters\',subjects{1},'_feauters','.mat'));
phases = fieldnames(POINT);
point_feauters = fieldnames(POINT.sad);
%pat to save images
path_imgs = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\ANALISI MATLAB\5_figures\Statistics\POINT_planB';

for n=1:length(point_feauters)
    for i=2:9
        for k=1:length(subjects)
            %normalization in respect the baseline
            load(strcat(path,subjects{k},'\feauters\',subjects{k},'_feauters','.mat'));
            temp(k,i) = POINT.(phases{i}).(point_feauters{n});
            
        end
    end
    
    POINT_total{1,n+1} = point_feauters{n};
    
    %uploading the feauters unbiased by the baselines
    temp = temp(:,2:end);
    if  (class(option) ~= "double")
        if (option == "depolarized_all_baselines" )
            b_temp = temp(:,1:2:end);
            POINT_total{2,n+1} = b_temp;
            
            diff_temp = diff(temp,1,2);
            diff_temp(:,2:2:end)=[];
            POINT_total{3,n+1} = diff_temp;
            
            %uploading the p values
            [p_diff,tbl,stats] = friedman(diff_temp,1);
            POINT_total{4,n+1} = p_diff;
            %uploading stats
            POINT_total{5,n+1} = stats;
            %uploading the multcompare
            md = multcompare(stats,'CType','hsd');
            POINT_total{6,n+1} = md;
            
            close all
            
        elseif (option == "not_depolarized" )
            b_temp = temp(:,1:2:end);
            POINT_total{2,n+1} = b_temp;
            
            temp(:,1:2:end)=[];
            POINT_total{3,n+1} = temp;
            
            %uploading the p values
            [p,tbl,stats] = friedman(temp,1);
            POINT_total{4,n+1} = p;
            %uploading stats
            POINT_total{5,n+1} = stats;
            %uploading the multcompare
            md = multcompare(stats,'CType','hsd');
            POINT_total{6,n+1} = md;
            close all
        end
    else
        baselines = temp(:,[1 3 5 7]);
        POINT_total{2,n+1} = baselines;
        b = baselines(:,option);
        temp(:,1:2:end)=[];
        temp = temp - b;
        POINT_total{3,n+1} = temp;
        
        %uploading the p values
        [p_diff,tbl,stats] = friedman(temp,1);
        POINT_total{4,n+1} = p_diff;
        %uploading stats
        POINT_total{5,n+1} = stats;
        %uploading the multcompare
        md = multcompare(stats,'CType','hsd');
        POINT_total{6,n+1} = md;
        close all
    end
end

%plot_boxplot_and_stats(POINT_total,path_imgs)

% figure()
% subplot(1,2,1)
% boxplot(POINT_total{2,2})
% title('mean POINT_total Baselines env')
%
% subplot(1,2,2)
% boxplot(POINT_total{3,2})
% title('mean POINT_total Phases env')
%
%
% boxplot(POINT_total{3,2})
% title('mean POINT_total Phases env')
%% F_OO

path_imgs = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\ANALISI MATLAB\5_figures\Statistics\FOO_CLASSIC_planB';

%preload data to define struct
load(strcat(path,subjects{1},'\feauters\',subjects{1},'_feauters','.mat'));
phases = fieldnames(F_OO);

F_OO_SPEC = {};
F_OO_SPEC{2,1} = 'feauters';
F_OO_SPEC{3,1} = 'pvalues';
F_OO_SPEC{4,1} = 'stats';
F_OO_SPEC{5,1} = 'multicompare';

F_OO_CLASS = {};
F_OO_CLASS{2,1} = 'baselines';
F_OO_CLASS{3,1} = 'feauters';
F_OO_CLASS{4,1} = 'pvalues';
F_OO_CLASS{5,1} = 'stats';
F_OO_CLASS{6,1} = 'multicompare';


%CLASS
%preload data to define struct
load(strcat(path,subjects{1},'\feauters\',subjects{1},'_feauters','.mat'));
phases = fieldnames(F_OO);
CLASS = rmfield(F_OO.b1.CLASS,{'Alpha1','ApEn','SampEn'});
F_OO_feauters = fieldnames(CLASS);



for n=1:length(F_OO_feauters)
    for i=2:9
        for k=1:length(subjects)
            %normalization in respect the baseline
            load(strcat(path,subjects{k},'\feauters\',subjects{k},'_feauters','.mat'));
            temp(k,i) = F_OO.(phases{i}).CLASS.(F_OO_feauters{n});
            
        end
    end
    
    F_OO_CLASS{1,n+1} = F_OO_feauters{n};
    
    %uploading the feauters unbiased by the baselines
    temp = temp(:,2:end);
    if  (class(option) ~= "double")
        if (option == "depolarized_all_baselines" )
            b_temp = temp(:,1:2:end);
            F_OO_CLASS{2,n+1} = b_temp;
            
            diff_temp = diff(temp,1,2);
            diff_temp(:,2:2:end)=[];
            F_OO_CLASS{3,n+1} = diff_temp;
            
            %uploading the p values
            [p_diff,tbl,stats] = friedman(diff_temp,1);
            F_OO_CLASS{4,n+1} = p_diff;
            %uploading stats
            F_OO_CLASS{5,n+1} = stats;
            %uploading the multcompare
            md = multcompare(stats,'CType','hsd');
            F_OO_CLASS{6,n+1} = md;
            
            close all
            
        elseif (option == "not_depolarized" )
            b_temp = temp(:,1:2:end);
            F_OO_CLASS{2,n+1} = b_temp;
            
            temp(:,1:2:end)=[];
            F_OO_CLASS{3,n+1} = temp;
            
            %uploading the p values
            [p,tbl,stats] = friedman(temp,1);
            F_OO_CLASS{4,n+1} = p;
            %uploading stats
            F_OO_CLASS{5,n+1} = stats;
            %uploading the multcompare
            md = multcompare(stats,'CType','hsd');
            F_OO_CLASS{6,n+1} = md;
            close all
        end
    else
        baselines = temp(:,[1 3 5 7]);
        F_OO_CLASS{2,n+1} = baselines;
        b = baselines(:,option);
        temp(:,1:2:end)=[];
        temp = temp - b;
        F_OO_CLASS{3,n+1} = temp;
        
        %uploading the p values
        [p_diff,tbl,stats] = friedman(temp,1);
        F_OO_CLASS{4,n+1} = p_diff;
        %uploading stats
        F_OO_CLASS{5,n+1} = stats;
        %uploading the multcompare
        md = multcompare(stats,'CType','hsd');
        F_OO_CLASS{6,n+1} = md;
        close all
    end
    
end


%plot_boxplot_and_stats(F_OO_CLASS,path_imgs)

%SPEC

%preload data to define struct
load(strcat(path,subjects{1},'\feauters\',subjects{1},'_feauters','.mat'));
phases = fieldnames(F_OO);
SPEC = rmfield(F_OO.b1.SPEC.RR,{'fitting','OPT'});
F_OO_feauters = fieldnames(SPEC);



for n=1:length(F_OO_feauters)
    for i=2:9
        for k=1:length(subjects)
            %normalization in respect the baseline
            load(strcat(path,subjects{k},'\feauters\',subjects{k},'_feauters','.mat'));
            temp(k,i) = F_OO.(phases{i}).SPEC.RR.(F_OO_feauters{n});
            
        end
    end
    
    F_OO_SPEC{1,n+1} = F_OO_feauters{n};
    
    %uploading the feauters unbiased by the baselines
    temp = temp(:,2:end);
    
    if  (class(option) ~= "double")
        if (option == "depolarized_all_baselines" )
            b_temp = temp(:,1:2:end);
            F_OO_SPEC{2,n+1} = b_temp;
            
            diff_temp = diff(temp,1,2);
            diff_temp(:,2:2:end)=[];
            F_OO_SPEC{3,n+1} = diff_temp;
            
            %uploading the p values
            [p_diff,tbl,stats] = friedman(diff_temp,1);
            F_OO_SPEC{4,n+1} = p_diff;
            %uploading stats
            F_OO_SPEC{5,n+1} = stats;
            %uploading the multcompare
            md = multcompare(stats,'CType','hsd');
            F_OO_SPEC{6,n+1} = md;
            
            close all
            
        elseif (option == "not_depolarized" )
            temp(:,1:2:end)=[];
            F_OO_SPEC{2,n+1} = temp;
            
            %uploading the p values
            [p,tbl,stats] = friedman(temp,1);
            F_OO_SPEC{3,n+1} = p;
            %uploading stats
            F_OO_SPEC{4,n+1} = stats;
            %uploading the multcompare
            md = multcompare(stats,'CType','hsd');
            F_OO_SPEC{5,n+1} = md;
            close all
        end
    else
        baselines = temp(:,[1 3 5 7]);
        b = baselines(:,option);
        temp(:,1:2:end)=[];
        temp = temp - b;
        F_OO_SPEC{2,n+1} = temp;
        
        %uploading the p values
        [p,tbl,stats] = friedman(temp,1);
        F_OO_SPEC{3,n+1} = p;
        %uploading stats
        F_OO_SPEC{4,n+1} = stats;
        %uploading the multcompare
        md = multcompare(stats,'CType','hsd');
        F_OO_SPEC{5,n+1} = md;
        close all
    end
    
end

%BOXPLOTS___________________________________
% figure()
% boxplot(F_OO_CLASS{2,2},'Colors','k')
% title('mean AVN baselines')
% hold on
% boxplot(F_OO_CLASS{3,2})
% title('mean AVN phases')
%
%
% figure()
% boxplot(F_OO_CLASS{2,23},'Colors','g')
% hold on
% boxplot(F_OO_CLASS{3,23})
% title('mean SDNN baseline(g) and phases ' )

%PLOT_AVG_MEAN____________________________
% m_avg=[mean(F_OO_CLASS{2,3});mean(F_OO_CLASS{3,3})]';
% bar(m_avg)
% hold on
% plot(xlim-0.51,[mean([m_avg(:,1);m_avg(1:end-1,2)]) mean([m_avg(:,1);m_avg(1:end-1,2)])],'r','LineWidth',2)
% xticklabels({'b1 sad','b2 relax','b3 happy','b4 fear'})
% ylabel('Avarage RR [ms]')
% xlabel('Bseline and Experience')
% title('Avarage RR along the protocol and mean visualization')
% txt = 'mean(experience - fear)';
% text(2.26,mean([m_avg(:,1);m_avg(1:end-1,2)])-30,txt)
% xlim([0.5 4.5])
% saveas(gcf,'Avarage RR along the protocol and mean visualization.fig')


%PLOT_AVG____________________________
% m_avg=[mean(F_OO_CLASS{2,3});mean(F_OO_CLASS{3,3})]';
% bar(m_avg)
% xticklabels({'b1 sad','b2 relax','b3 happy','b4 fear'})
% ylabel('Avarage RR [ms]')
% xlabel('Baseline - Experience')
% title('Avarage RR along the protocol')


%PLOT_DIFF____________________________
% m_avg_diff= -mean(F_OO_CLASS{2,3})'+ mean(F_OO_CLASS{3,3})';
% bar(m_avg_diff)
% xticklabels({'sad-b1','relax-b2','happy-b3','fear-b4'})
% ylabel('Avarage RR [ms]')
% xlabel('Experience-Baseline')
% title('Response RR emotions')
% saveas(gcf,'Response RR emotions.fig')


% minim = min(min(m_avg));
% [row,col]=find(m_avg==minim);
%
% saveas(gcf,'Avarage RR along the protocol.fig')

% reference = [F_OO_CLASS{3,3},F_OO_CLASS{2,3}];
% writematrix(reference,'reference.xlsx')
%
% reference = mean([F_OO_CLASS{3,3}(:,1:3),F_OO_CLASS{2,3}(:,1:4)],2);
% writematrix(reference,'reference.xlsx')

%% RESP

path_imgs = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\ANALISI MATLAB\5_figures\Statistics\RESP_planB';

%preload data to define struct
load(strcat(path,subjects{1},'\feauters\',subjects{1},'_feauters','.mat'));
phases = fieldnames(RESP);
var_features{1,1} = "baselines";
var_features{1,2} = "phases";
RESP_feauters = fieldnames(RESP.sad);


for n=1:length(RESP_feauters)
    for i=2:9
        for k=1:length(subjects)
            %normalization in respect the baseline
            load(strcat(path,subjects{k},'\feauters\',subjects{k},'_feauters','.mat'));
            temp(k,i) = RESP.(phases{i}).(RESP_feauters{n});
            
        end
    end
    
    RESP_total{1,n+1} = RESP_feauters{n};
    
    %uploading the feauters unbiased by the baselines
    temp = temp(:,2:end);
    if  (class(option) ~= "double")
        if (option == "depolarized_all_baselines" )
            b_temp = temp(:,1:2:end);
            RESP_total{2,n+1} = b_temp;
            
            diff_temp = diff(temp,1,2);
            diff_temp(:,2:2:end)=[];
            RESP_total{3,n+1} = diff_temp;
            
            %uploading the p values
            [p_diff,tbl,stats] = friedman(diff_temp,1);
            RESP_total{4,n+1} = p_diff;
            %uploading stats
            RESP_total{5,n+1} = stats;
            %uploading the multcompare
            md = multcompare(stats,'CType','hsd');
            RESP_total{6,n+1} = md;
            
            close all
        elseif (option == "not_depolarized" )
            b_temp = temp(:,1:2:end);
            RESP_total{2,n+1} = b_temp;
            
            temp(:,1:2:end)=[];
            RESP_total{3,n+1} = temp;
            
            %uploading the p values
            [p,tbl,stats] = friedman(temp,1);
            RESP_total{4,n+1} = p;
            %uploading stats
            RESP_total{5,n+1} = stats;
            %uploading the multcompare
            md = multcompare(stats,'CType','hsd');
            RESP_total{6,n+1} = md;
            
            %computing the variance over the feauters
            var_b = var(b_temp,0,1);
            var_p = var(temp,0,1);
            
            
            var_features{2,1} = var_b;
            var_features{2,2} = var_p;
            
            RESP_total{7,n+1} = var_features;
            close all
        end
    else
        baselines = temp(:,[1 3 5 7]);
        RESP_total{2,n+1} = baselines;
        b = baselines(:,option);
        temp(:,1:2:end)=[];
        temp = temp - b;
        RESP_total{3,n+1} = temp;
        
        %uploading the p values
        [p_diff,tbl,stats] = friedman(temp,1);
        RESP_total{4,n+1} = p_diff;
        %uploading stats
        RESP_total{5,n+1} = stats;
        %uploading the multcompare
        md = multcompare(stats,'CType','hsd');
        RESP_total{6,n+1} = md;
        close all
    end
end

%plot_boxplot_and_stats(RESP_total,path_imgs)


% figure()
% subplot(1,2,1)
% boxplot(RESP_total{2,2})
% title('mean RESP Baselines ')
%
% subplot(1,2,2)
% boxplot(RESP_total{3,2})
% title('mean RESP Phases ')


%%

%writetable(table(PP_total{3,2}(:,4),PP_total{3,3}(:,4),PP_total{3,4}(:,4)),'data.xlsx')



%Feaut = {GSR_total, PulsePulse_total, PP_total, PAT_total, POINT_total, F_OO_CLASS, RESP_total};
