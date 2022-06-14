function SerieResp = CreaSerieResp(tempo,sig_respiro)

    Fs=1/(tempo(2)-tempo(1)); %divrebbe essere 256Hz
    
    %% filtro il segnale
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
    
    sig_respiro=filtfilt(Hd.Numerator,1,sig_respiro);

    %% trovo i picchi e constrisco la serie 
 
    [pks,locs] = findpeaks(sig_respiro,'MinPeakProminence',0.3*std(sig_respiro),'MinPeakDistance',Fs*2); %'MinPeakDistance',0.5*16 così imezzo secondo di distanza
    %voglio i tempi non gli indici
    peak_t = tempo(locs);

    %costruisco la time series
    serie_resp=zeros(length(peak_t),2);
    serie_resp(1,1) =  peak_t(1);
    for i=1+1:length(peak_t)
        serie_resp(i,2)=peak_t(i)-peak_t(i-1);
        serie_resp(i,1) = peak_t(i);
    end
    
    %trasformo in frequenza
    serie_resp(:,2) = 1./(serie_resp(:,2));

    %filtro
     %Hampel per togliere quelli a caso
    serie_resp(:,2) = hampel(serie_resp(:,2),10);
    %media mobile per smussare
    serie_resp(:,2) = movmean(serie_resp(:,2),6);

    SerieResp=serie_resp;

end