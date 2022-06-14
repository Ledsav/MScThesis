clear,clc,close

%where to save the struct
path = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\';
%extracting the list of subjects from the folder
codes = dir('C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\');
code_list = {codes.name};
subjects = code_list(3:end);

annotation=strcat(subjects,'.txt_ecg_bvp_ann.mat');
str='F_RR.PP.Mono.';
features2={strcat(str,'RR.bal');strcat(str,'Mu');strcat(str,'s2');strcat(str,'Kappa');strcat(str,'RR.powLF');strcat(str,'RR.powHF');strcat(str,'RR.powTot');strcat(str,'RR.powVLF');};

%Seconds for markers
seconds_division=[120 420 720 1020  1320  1620 1920  2220 2520];

for k=1:size(subjects,2)
    if isfile (strcat(path,subjects{k},'\',annotation{k}))% && not(isfile(strcat(path,subjects{k},'\feauters\',subjects{k},'_feauters','.mat')))
        %data from annotation toolbox
        load(strcat(path,subjects{k},'\',annotation{k}))
        data2=data;
        %data from Procomp
        data=importdata(strcat(subjects{k},'.txt'));
        %data from Point Process
        load(strcat(path,subjects{k},'\','FRR_',subjects{k},'.mat'))
        
        
        %ECG
        time=data.data(2:end,1); %f=2048 Hz
        ecg=data.data(2:end,2);  %f=2048 Hz
        %BVP
        bvp=data.data(2:end,3);  %f=2048 Hz
        %SKIN
        time_skin=downsample(data.data(2:end,1),256); %f=8 Hz
        skin=data.data(2:end,4);
        sc=sc_filter(skin,2048); %filter and downsample the signal at 8 Hz
        sc_bp=bp(skin,2048); %filter band pass + downsample at 8 Hz
        sc_phasic=median2(sc,8); %extract phasic component
        %RESP
        time_resp=downsample(data.data(2:end,1),8); %f=256 Hz
        resp=downsample(data.data(2:end,5),8);      %f=256 Hz
        
        %Time division
        t_dadi=find(time<=seconds_division(1));
        t_dadi_skin=find(time_skin<=seconds_division(1));
        t_dadi_resp=find(time_resp<=seconds_division(1));
        t_dadi_RR=find(data2.annotations(1,:)<seconds_division(1)*2048);
        t_b1=find(time<=seconds_division(2));
        t_b1=t_dadi(end)+1:t_b1(end);
        t_b1_skin=find(time_skin<=seconds_division(2));
        t_b1_skin=t_dadi_skin(end)+1:t_b1_skin(end);
        t_b1_resp=find(time_resp<=seconds_division(2));
        t_b1_resp=t_dadi_resp(end)+1:t_b1_resp(end);
        t_b1_RR=find(data2.annotations(1,:)<=seconds_division(2)*2048);
        t_b1_RR=t_dadi_RR(end)+1:t_b1_RR(end);
        t_sad=find(time<=seconds_division(3));
        t_sad=t_b1(end)+1:t_sad(end);
        t_sad_skin=find(time_skin<=seconds_division(3));
        t_sad_skin=t_b1_skin(end)+1:t_sad_skin(end);
        t_sad_resp=find(time_resp<=seconds_division(3));
        t_sad_resp=t_b1_resp(end)+1:t_sad_resp(end);
        t_sad_RR=find(data2.annotations(1,:)<=seconds_division(3)*2048);
        t_sad_RR=t_b1_RR(end)+1:t_sad_RR(end);
        t_b2=find(time<=seconds_division(4));
        t_b2=t_sad(end)+1:t_b2(end);
        t_b2_skin=find(time_skin<seconds_division(4));
        t_b2_skin=t_sad_skin(end)+1:t_b2_skin(end);
        t_b2_resp=find(time_resp<seconds_division(4));
        t_b2_resp=t_sad_resp(end)+1:t_b2_resp(end);
        t_b2_RR=find(data2.annotations(1,:)<=seconds_division(4)*2048);
        t_b2_RR=t_sad_RR(end)+1:t_b2_RR(end);
        t_relax=find(time<=seconds_division(5));
        t_relax=t_b2(end)+1:t_relax(end);
        t_relax_skin=find(time_skin<seconds_division(5));
        t_relax_skin=t_b2_skin(end)+1:t_relax_skin(end);
        t_relax_resp=find(time_resp<seconds_division(5));
        t_relax_resp=t_b2_resp(end)+1:t_relax_resp(end);
        t_relax_RR=find(data2.annotations(1,:)<=seconds_division(5)*2048);
        t_relax_RR=t_b2_RR(end)+1:t_relax_RR(end);
        t_b3=find(time<=seconds_division(6));
        t_b3=t_relax(end)+1:t_b3(end);
        t_b3_skin=find(time_skin<=seconds_division(6));
        t_b3_skin=t_relax_skin(end)+1:t_b3_skin(end);
        t_b3_resp=find(time_resp<=seconds_division(6));
        t_b3_resp=t_relax_resp(end)+1:t_b3_resp(end);
        t_b3_RR=find(data2.annotations(1,:)<=seconds_division(6)*2048);
        t_b3_RR=t_relax_RR(end)+1:t_b3_RR(end);
        t_happy=find(time<=seconds_division(7));
        t_happy=t_b3(end)+1:t_happy(end);
        t_happy_skin=find(time_skin<=seconds_division(7));
        t_happy_skin=t_b3_skin(end)+1:t_happy_skin(end);
        t_happy_resp=find(time_resp<=seconds_division(7));
        t_happy_resp=t_b3_resp(end)+1:t_happy_resp(end);
        t_happy_RR=find(data2.annotations(1,:)<=seconds_division(7)*2048);
        t_happy_RR=t_b3_RR(end)+1:t_happy_RR(end);
        t_b4=find(time<=seconds_division(8));
        t_b4=t_happy(end):t_b4(end);
        t_b4_skin=find(time_skin<=seconds_division(8));
        t_b4_skin=t_happy_skin(end)+1:t_b4_skin(end);
        t_b4_resp=find(time_resp<=seconds_division(8));
        t_b4_resp=t_happy_resp(end)+1:t_b4_resp(end);
        t_b4_RR=find(data2.annotations(1,:)<=seconds_division(8)*2048);
        t_b4_RR=t_happy_RR(end)+1:t_b4_RR(end);
        t_fear=find(time<=seconds_division(9));
        t_fear=t_b4(end)+1:t_fear(end);
        t_fear_skin=find(time_skin<=seconds_division(9));
        t_fear_skin=t_b4_skin(end)+1:t_fear_skin(end);
        t_fear_resp=find(time_resp<=seconds_division(9));
        t_fear_resp=t_b4_resp(end)+1:t_fear_resp(end);
        t_fear_RR=find(data2.annotations(1,:)<=seconds_division(9)*2048);
        t_fear_RR=t_b4_RR(end)+1:t_fear_RR(end);
        
        times={'t_dadi';'t_dadi_skin';'t_dadi_resp';'t_dadi_RR';'t_dadi_PP';'t_b1';'t_b1_skin';'t_b1_resp';'t_b1_RR';'t_b1_PP';'t_sad';'t_sad_skin';'t_sad_resp';'t_sad_RR';'t_sad_PP';'t_b2';'t_b2_skin';'t_b2_resp';'t_b2_RR';'t_b2_PP';'t_relax';'t_relax_skin';'t_relax_resp';'t_relax_RR';'t_relax_PP';'t_b3';'t_b3_skin';'t_b3_resp';'t_b3_RR';'t_b3_PP';'t_happy';'t_happy_skin';'t_happy_resp';'t_happy_RR';'t_happy_PP';'t_b4';'t_b4_skin';'t_b4_resp';'t_b4_RR';'t_b4_PP';'t_fear';'t_fear_skin';'t_fear_resp';'t_fear_RR';'t_fear_PP'};
        phase={'dadi';'b1';'sad';'b2';'relax';'b3';'happy';'b4';'fear'};
        
        
        %ECG features
        j=0;
        for i=4:5:size(times,1)
            j=j+1;
            eval(['samples' '=' times{i,:} ';']);
            
            F_OO.(phase{j,:})=get_features_RR_1signal(data2.annotations(2,samples),'sel_EKGR',1,'fs',2048,'PPorderMono',9,'get_PP',0,'UndSampl',20,'get_spectra',0,'get_TimeDomain',1,'get_Freqs',1,'get_Compl',1);
            
        end
        


        %PP & PAT features
        j=0;
        for i=4:5:size(times,1)
            j=j+1;
            eval(['samples' '=' times{i,:} ';']);
            
            ecg_samples=data2.annotations(1,samples);
            onset=data2.annotations(2,samples);
            sys_ann=data2.annotations(4,samples);
            sys_amp=data2.annotations(5,samples);
            dias_ann=data2.annotations(6,samples);
            dias_amp=data2.annotations(7,samples);
            
            PulsePulse.(phase{j,:}) = av_PulsePulse(sys_ann);
            [PP.(phase{j,:}).avg_pp ,PP.(phase{j,:}).slope,PP.(phase{j,:}).var]= avpp(sys_ann,dias_ann,sys_amp,dias_amp);
            PAT.nno.(phase{j,:})=pat(onset,ecg_samples,2048,'nn');
            PAT.no.(phase{j,:})=pat(onset,ecg_samples,2048,'n');
            PAT.nns.(phase{j,:})=pat(sys_ann,ecg_samples,2048,'nn');
            PAT.ns.(phase{j,:})=pat(sys_ann,ecg_samples,2048,'n');
            PAT.nnd.(phase{j,:})=pat(dias_ann,ecg_samples,2048,'nn');
            PAT.nd.(phase{j,:})=pat(dias_ann,ecg_samples,2048,'n');
            
        end
        
        %POINT PROCESS features
        
        %Time division
        t=F_RR.PP.Mono.t0+(0:F_RR.PP.Mono.delta:length(F_RR.PP.Mono.Mu)*F_RR.PP.Mono.delta-F_RR.PP.Mono.delta);
        t_dadi_PP=find(t<seconds_division(1));
        t_b1_PP=find(t<=seconds_division(2));
        t_b1_PP=t_dadi_PP(end)+1:t_b1_PP(end);
        t_sad_PP=find(t<=seconds_division(3));
        t_sad_PP=t_b1_PP(end)+1:t_sad_PP(end);
        t_b2_PP=find(t<=seconds_division(4));
        t_b2_PP=t_sad_PP(end)+1:t_b2_PP(end);
        t_relax_PP=find(t<=seconds_division(5));
        t_relax_PP=t_b2_PP(end)+1:t_relax_PP(end);
        t_b3_PP=find(t<=seconds_division(6));
        t_b3_PP=t_relax_PP(end)+1:t_b3_PP(end);
        t_happy_PP=find(t<=seconds_division(7));
        t_happy_PP=t_b3_PP(end)+1:t_happy_PP(end);
        t_b4_PP=find(t<=seconds_division(8));
        t_b4_PP=t_happy_PP(end)+1:t_b4_PP(end);
        t_fear_PP=find(t<=seconds_division(9));
        t_fear_PP=t_b4_PP(end)+1:t_fear_PP(end);
        begin=find(t>90);
        
        %Remove Nans
        for z=1:8
            
            eval(['signal' '=' features2{z,:} ';']);
            %     interval=begin(1):length(signal);
            %     n_nan=isnan(signal(begin:end));
            %     if isempty(find(n_nan,1))
            %     else
            %         pos=find(n_nan>0);
            %         begin_nan=pos(1);
            %         end_nan=pos(end);
            %         signal(interval(begin_nan:end_nan))=linspace(signal(interval(begin_nan)-1),signal(interval(end_nan)+1),length(begin_nan:end_nan));
            %         eval([features2{z,:} '=' 'signal' ';']);
            %     end
            % end
            signal=fillmissing(signal,'linear');
            eval([features2{z,:} '=' 'signal' ';']);
            
        end
        
        j=0;
        for i=5:5:size(times,1)
            j=j+1;
            eval(['samples' '=' times{i,:} ';']);
            POINT.(phase{j,:}).mu=mean(F_RR.PP.Mono.Mu(samples));
            POINT.(phase{j,:}).s2=mean(F_RR.PP.Mono.s2(samples));
            POINT.(phase{j,:}).lf=mean(F_RR.PP.Mono.RR.powLF(samples));
            POINT.(phase{j,:}).hf=mean(F_RR.PP.Mono.RR.powHF(samples));
            POINT.(phase{j,:}).bal=mean(F_RR.PP.Mono.RR.bal(samples));
            POINT.(phase{j,:}).vlf=mean(F_RR.PP.Mono.RR.powVLF(samples));
            POINT.(phase{j,:}).tot=mean(F_RR.PP.Mono.RR.powTot(samples));
%             POINT.(phase{j,:}).lfn=mean(F_RR.PP.Mono.RR.powLF(samples)./(F_RR.PP.Mono.RR.powTot(samples)-F_RR.PP.Mono.RR.powVLF(samples)));
%             POINT.(phase{j,:}).hfn=mean(F_RR.PP.Mono.RR.powHF(samples)./(F_RR.PP.Mono.RR.powTot(samples)-F_RR.PP.Mono.RR.powVLF(samples)));
            POINT.(phase{j,:}).lfn=mean(F_RR.PP.Mono.RR.powLF(samples)./(F_RR.PP.Mono.RR.powLF(samples)+F_RR.PP.Mono.RR.powHF(samples)));
            POINT.(phase{j,:}).hfn=mean(F_RR.PP.Mono.RR.powHF(samples)./(F_RR.PP.Mono.RR.powLF(samples)-F_RR.PP.Mono.RR.powHF(samples)));
            
        end
        
        %SKIN CONDUCTANCE features
        j=0;
        for i=2:5:size(times,1)
            j=j+1;
            eval(['samples' '=' times{i,:} ';']);
            [~,~,~,GSR.(phase{j,:}).avg_amp_peaks,GSR.(phase{j,:}).avg_rise_time,GSR.(phase{j,:}).avg_rec_time,GSR.(phase{j,:}).n_peaks,GSR.(phase{j,:}).sd_amp_peaks]=feat_sc(sc(samples),8,sc_phasic(samples),1);
            [~,~,GSR.(phase{j,:}).max_sign_amp_gsrbp,GSR.(phase{j,:}).avg_der_gsrbp,GSR.(phase{j,:}).sd_der_gsrbp,GSR.(phase{j,:}).max_der_gsrbp]=gsrbp2(sc_bp(samples));
            [GSR.(phase{j,:}).slope_gsr,~,~,~,~]=gsrbp2(sc(samples));
            [GSR.(phase{j,:}).avg,GSR.(phase{j,:}).sd,GSR.(phase{j,:}).avg_abs1,GSR.(phase{j,:}).avg_abs1_norm,GSR.(phase{j,:}).avg_abs2,GSR.(phase{j,:}).avg_abs2_norm]=Picard(sc(samples));
            [GSR.(phase{j,:}).env,~,~]=envel(sc_phasic(samples));
        end
        
        %RESP features
        j=0;
        for i=3:5:size(times,1)
            j=j+1;
            eval(['samples' '=' times{i,:} ';']);
            
            SerieResp=CreaSerieResp(time_resp,resp(samples));
            RESP.(phase{j,:}).f_resp=size(SerieResp,1)/5;
        end
        
        
        direc = strcat(path,subjects{k},'\');
        mkdir(direc,'feauters')
        save(strcat(path,subjects{k},'\feauters\',subjects{k},'_feauters','.mat'),'F_OO','PP','PulsePulse','PAT','POINT','GSR','RESP')
        
        
        
    end
end




