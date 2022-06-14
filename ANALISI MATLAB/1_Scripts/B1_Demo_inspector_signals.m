close all
clear all

%inport data as column vectoer
events = load('events.mat');
events = events.events;
description_events = load('description_events.mat');
description_events = description_events.description_events;


[Time, EKGProFlex1A, HRBVPProFlex1B, SCProFlex1C, RespProFlex1D] = importfile_procomp('M828B.txt');


Skin = SCProFlex1C(2:end);
resp = RespProFlex1D(2:end);
ppg = HRBVPProFlex1B(2:end);
ecg = EKGProFlex1A(2:end);

Skin(Skin(1:120*2048)< mean(Skin((120*2048:end))))= mean(Skin((120*2048:end)));
resp(resp(1:120*2048)< mean(resp((120*2048:end))))= mean(resp((120*2048:end)));
ppg(ppg(1:120*2048)< mean(ppg((120*2048:end))))= mean(ppg((120*2048:end)));
ecg(ecg(1:120*2048)< mean(ecg((120*2048:end))))= mean(ecg((120*2048:end)));

offset = 120; 
scenes_x = ([0 300,600,900,1200,1500,1800,2100,2400]+120);
y=0:3;

corrfac =length(Skin)- length(events);
event_point_audio = find(events==1);
event_point_video = find(events==2);
event_point_both = find(events==3);

T = [1:length(Skin)- corrfac]'/2048;

%COLORS LEGEND 
%orange = audio / blue = video / green = both
blue = [0 0.4470 0.7410];
orange = [255,140,0]/255;
green = [0,128,0]/255;


figure('WindowState','maximized')
    subplot(2,2,1)
    plot(T,ppg(1:length(Skin)- corrfac),'k')
    title('PPG')
    xlim([0,2500])
    xlabel('Time [s]')
    ylabel('A.U.')
    hold on
    for i=1:length(event_point_audio)
        xline(event_point_audio(i)/2048,'color',orange)
    end
    hold on
    for i=1:length(event_point_video)
        xline(event_point_video(i)/2048,'color',blue)
    end
    hold on
    for i=1:length(event_point_both)
        xline(event_point_both(i)/2048,'color',green)
    end
    hold on
    for i=1:length(scenes_x)
        xline(scenes_x(i),'--r','LineWidth',1)
    end
    
    
    subplot(2,2,2)
    plot(T,Skin(1:length(Skin)- corrfac),'k')
    title('SKIN_Z')
    xlabel('Time [s]')
    ylabel('\mu S')
    xlim([0,2500])
    hold on
    for i=1:length(event_point_audio)
        xline(event_point_audio(i)/2048,'color',orange)
    end
    hold on
    for i=1:length(event_point_video)
        xline(event_point_video(i)/2048,'color',blue)
    end
    hold on
    for i=1:length(event_point_both)
        xline(event_point_both(i)/2048,'color',green)
    end
    hold on
    for i=1:length(scenes_x)
        xline(scenes_x(i),'--r','LineWidth',1)
    end
    
    
    subplot(2,2,3)
    plot(T,ecg(1:length(Skin)- corrfac),'k')
    title('ECG')
    xlim([0,2500])
    xlabel('Time [s]')
    ylabel('\mu V')
    hold on
    for i=1:length(event_point_audio)
        xline(event_point_audio(i)/2048,'color',orange)
    end
    hold on
    for i=1:length(event_point_video)
        xline(event_point_video(i)/2048,'color',blue)
    end
    hold on
    for i=1:length(event_point_both)
        xline(event_point_both(i)/2048,'color',green)
    end
    hold on
    for i=1:length(scenes_x)
        xline(scenes_x(i),'--r','LineWidth',1)
    end
    
    
    subplot(2,2,4)
    plot(T,resp(1:length(Skin)- corrfac),'k')
    title('RESP')
    xlabel('Time [s]')
    ylabel('A.U.')
    xlim([0,2500])
   
    hold on
    for i=1:length(event_point_audio)
        xline(event_point_audio(i)/2048,'color',orange)
    end
    hold on
    for i=1:length(event_point_video)
        xline(event_point_video(i)/2048,'color',blue)
    end
    hold on
    for i=1:length(event_point_both)
        xline(event_point_both(i)/2048,'color',green)
    end
    hold on
    for i=1:length(scenes_x)
        xline(scenes_x(i),'--r','LineWidth',1)
    end
    
    
    
    %% saving data 
    
    mkdir 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\M828B' 
    saveas(gcf,'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\M828B\M828B.png')
    saveas(gcf,'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\M828B\M828B.fig')
    
  %% extraction of phasic resp 
clc,clear,close


[Time, EKGProFlex1A, HRBVPProFlex1B, SCProFlex1C, RespProFlex1D] = importfile_procomp('M828B.txt');


Skin = SCProFlex1C(2:end);
resp = RespProFlex1D(2:end);
ppg = HRBVPProFlex1B(2:end);
ecg = EKGProFlex1A(2:end);


resp_RR_sampled = resp(data.annotations(1,:)');
Fs=2048;
 

 

 % filtro il segnale
    %parametri
    Fpass = 1;               % Passband Frequency
    Fstop = 1.5;             % Stopband Frequency
    Dpass = 0.057501127785;  % Passband Ripple
    Dstop = 0.001;           % Stopband Attenuation
    dens  = 20;              % Density Factor

    % Calculate the order from the parameters using FIRPMORD.
    [N, Fo, Ao, W] = firpmord([Fpass, Fstop]/(Fs/2), [1 0], [Dpass, Dstop]);

    % Calculate the coefficients using the FIRPM function.
    b  = firpm(N, Fo, Ao, W, {dens});
    Hd = dfilt.dffir(b);
    
    resp_lowpass=filtfilt(Hd.Numerator,1,resp);

%minmax normalization
resp_lowpass = (resp_lowpass-min(resp_lowpass))./(max(resp_lowpass)-min(resp_lowpass));
resp_min =  movmin(resp_lowpass,floor(length(resp)/1000));
resp_phase = resp_lowpass-resp_min;


figure()
plot(resp_min)
hold on 
plot(resp_lowpass)

figure
plot(resp_lowpass)
hold on 
plot(resp_min)
hold on 
plot(resp_phase)