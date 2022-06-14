clear,close,clc

%% initialization

mkdir 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\ANALISI MATLAB\Passports'

passdir = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\ANALISI MATLAB\Passports';


%% plot signals
load('Signals_subjects.mat')
%where to save the struct
path = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\';
%extracting the list of subjects from the folder
codes = dir(path);
code_list = {codes.name};
code_list_var = code_list(3:end);


for sub=1:length(code_list_var)
    
    subject = strcat(code_list_var(sub),'.txt_ecg_bvp_ann.mat');
    direc = strcat(path,code_list_var(sub),'\',subject);
    
    %building the directory for the specific subject
    subjdir = strcat(passdir,'\',code_list_var(sub));
    qualsdir = strcat(subjdir{1},'\qualitative');
    mkdir(subjdir{1})
    mkdir(qualsdir)
    
    if isfile(direc{1})
        
        
        scenes_x = ([0 300,600,900,1200,1500,1800,2100,2400]+120);
        
        
        figure('WindowState','maximized')
        
        a = subplot(6,1,1);
        plot(t_ann{sub},taco{sub})
        title('RR')
        hold on
        for i=1:length(scenes_x)
            xline(scenes_x(i),'--r','LineWidth',1)
        end
        ylabel('Time [s]')
        
        b = subplot(6,1,2);
        plot(pupu_ann{sub},PulsePulse{sub})
        title('PulsePulse')
        hold on
        for i=1:length(scenes_x)
            xline(scenes_x(i),'--r','LineWidth',1)
        end
        ylabel('Time [s]')
        
        c = subplot(6,1,3);
        plot(t_ann{sub},pat{sub})
        title('PAT')
        hold on
        for i=1:length(scenes_x)
            xline(scenes_x(i),'--r','LineWidth',1)
        end
        ylabel('Time [s]')
        
        d = subplot(6,1,4);
        plot(t_ann{sub},pp{sub})
        title('PP')
        hold on
        for i=1:length(scenes_x)
            xline(scenes_x(i),'--r','LineWidth',1)
        end
        ylabel('A.U.')
        e = subplot(6,1,5);
        plot(t_sign{sub},resp{sub})
        title('RESP')
        hold on
        for i=1:length(scenes_x)
            xline(scenes_x(i),'--r','LineWidth',1)
        end
        ylabel('A.U.')
        f = subplot(6,1,6);
        plot(t_sign{sub},skin{sub})
        title('SKIN')
        hold on
        for i=1:length(scenes_x)
            xline(scenes_x(i),'--r','LineWidth',1)
        end
        xlabel('Time [s]')
        ylabel('\mu S')
        linkaxes([a,b,c,d,e,f],'x');
        xlim([120 2520])
        
        sgtitle(code_list_var(sub))
    end
    
    name1 = strcat(subjdir,'\',code_list_var(sub),'_signals','.png');
    name2 = strcat(subjdir,'\',code_list_var(sub),'_signals','.fig');
    saveas(gcf,name1{1})
    saveas(gcf,name2{1})
    
    close all
end

%% Plot single patient qualitative choiche

load('C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\ANALISI MATLAB\Matrixes_pre_post.mat')
%where to save the struct
path = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\';
%extracting the list of subjects from the folder
codes = dir(path);
code_list = {codes.name};
code_list_var = code_list(3:end);

% ----------------------------------- ALL ROW --------------------------------------


for i=1 : length(code_list_var)
    
    if any(strcmp(code_list_var(i),NAMES_POST))
    
    k = find(strcmp(code_list_var(i),NAMES_POST)==1);
    
    subjdir = strcat(passdir,'\',code_list_var(i));
    subjdir = subjdir{1};
    figure('WindowState','maximized')
    
    subplot(1,2,1)
    plot(MAT_POST(k,1),MAT_POST(k,2),'ro')
    axis([-1 1    -1 1])
    hold on
    a = plot(-1:1,[0 0 0 ],'k');
    hold on
    b = plot([0 0 0],-1:1,'k');
    legend('post')
    title('Image baseline 1.1')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    subplot(1,2,2)
    plot(MAT_POST(k,17),MAT_POST(k,18),'ro')
    axis([-1 1    -1 1])
    hold on
    a = plot(-1:1,[0 0 0 ],'k');
    hold on
    b = plot([0 0 0],-1:1,'k');
    legend('post')
    title('Audio baseline')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    name1 = strcat(subjdir,'\qualitative\','_b11','.png');
    name2 = strcat(subjdir,'\qualitative\','_b11','.fig');
    saveas(gcf,name1)
    saveas(gcf,name2)
    close all
    
    % plot S
    figure('WindowState','maximized')
    subplot(1,2,1)
    plot(MAT_POST(k,3),MAT_POST(k,4),'ro')
    axis([-1 1    -1 1])
    hold on
    a = plot(-1:1,[0 0 0 ],'k');
    hold on
    b = plot([0 0 0],-1:1,'k');
    legend('post')
    title('Image sadness')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    subplot(1,2,2)
    plot(MAT_POST(k,19),MAT_POST(k,20),'ro')
    axis([-1 1    -1 1])
    hold on
    a = plot(-1:1,[0 0 0 ],'k');
    hold on
    b = plot([0 0 0],-1:1,'k');
    legend('post')
    title('Audio sadness')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    name1 = strcat(subjdir,'\qualitative\','_s','.png');
    name2 = strcat(subjdir,'\qualitative\','_s','.fig');
    saveas(gcf,name1)
    saveas(gcf,name2)
    close all
    
    % plot B2.2
    figure('WindowState','maximized')
    plot(MAT_POST(k,5),MAT_POST(k,6),'ro')
    axis([-1 1    -1 1])
    hold on
    a = plot(-1:1,[0 0 0 ],'k');
    hold on
    b = plot([0 0 0],-1:1,'k');
    legend('post')
    title('Image baseline 2.2')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    name1 = strcat(subjdir,'\qualitative\','_b22','.png');
    name2 = strcat(subjdir,'\qualitative\','_b22','.fig');
    saveas(gcf,name1)
    saveas(gcf,name2)
    close all
    
    % plot R
    figure('WindowState','maximized')
    subplot(1,2,1)
    plot(MAT_POST(k,7),MAT_POST(k,8),'ro')
    axis([-1 1    -1 1])
    hold on
    a = plot(-1:1,[0 0 0 ],'k');
    hold on
    b = plot([0 0 0],-1:1,'k');
    legend('post')
    title('Image Relax')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    subplot(1,2,2)
    plot(MAT_POST(k,21),MAT_POST(k,22),'ro')
    axis([-1 1    -1 1])
    hold on
    a = plot(-1:1,[0 0 0 ],'k');
    hold on
    b = plot([0 0 0],-1:1,'k');
    legend('post')
    title('Audio Relax')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    name1 = strcat(subjdir,'\qualitative\','_r','.png');
    name2 = strcat(subjdir,'\qualitative\','_r','.fig');
    saveas(gcf,name1)
    saveas(gcf,name2)
    close all
    
    % plot B1.2
    figure('WindowState','maximized')
    plot(MAT_POST(k,9),MAT_POST(k,10),'ro')
    axis([-1 1    -1 1])
    hold on
    a = plot(-1:1,[0 0 0 ],'k');
    hold on
    b = plot([0 0 0],-1:1,'k');
    legend('post')
    title('Image B1.2')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    name1 = strcat(subjdir,'\qualitative\','_b12','.png');
    name2 = strcat(subjdir,'\qualitative\','_b12','.fig');
    saveas(gcf,name1)
    saveas(gcf,name2)
    close all
    
    % plot H
    figure('WindowState','maximized')
    subplot(1,2,1)
    plot(MAT_POST(k,11),MAT_POST(k,12),'ro')
    axis([-1 1    -1 1])
    hold on
    a = plot(-1:1,[0 0 0 ],'k');
    hold on
    b = plot([0 0 0],-1:1,'k');
    legend('post')
    title('Image Happyness')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    subplot(1,2,2)
    plot(MAT_POST(k,23),MAT_POST(k,24),'ro')
    axis([-1 1    -1 1])
    hold on
    a = plot(-1:1,[0 0 0 ],'k');
    hold on
    b = plot([0 0 0],-1:1,'k');
    legend('post')
    title('Audio Happyness')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    name1 = strcat(subjdir,'\qualitative\','_h','.png');
    name2 = strcat(subjdir,'\qualitative\','_h','.fig');
    saveas(gcf,name1)
    saveas(gcf,name2)
    close all
    
    % plot B2.1
    
    figure('WindowState','maximized')
    plot(MAT_POST(k,13),MAT_POST(k,14),'ro')
    axis([-1 1    -1 1])
    hold on
    a = plot(-1:1,[0 0 0 ],'k');
    hold on
    b = plot([0 0 0],-1:1,'k');
    legend('post')
    title('Image B2.1')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    name1 = strcat(subjdir,'\qualitative\','_b21','.png');
    name2 = strcat(subjdir,'\qualitative\','_b21','.fig');
    saveas(gcf,name1)
    saveas(gcf,name2)
    close all
    
    % plot F
    figure('WindowState','maximized')
    subplot(1,2,1)
    plot(MAT_POST(k,15),MAT_POST(k,16),'ro')
    axis([-1 1    -1 1])
    hold on
    a = plot(-1:1,[0 0 0 ],'k');
    hold on
    b = plot([0 0 0],-1:1,'k');
    legend('post')
    title('Image Fear')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    subplot(1,2,2)
    plot(MAT_POST(k,25),MAT_POST(k,26),'ro')
    axis([-1 1    -1 1])
    hold on
    a = plot(-1:1,[0 0 0 ],'k');
    hold on
    b = plot([0 0 0],-1:1,'k');
    legend('post')
    title('Audio Fear')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    name1 = strcat(subjdir,'\qualitative\','_f','.png');
    name2 = strcat(subjdir,'\qualitative\','_f','.fig');
    saveas(gcf,name1)
    saveas(gcf,name2)
    close all
    end 
end



