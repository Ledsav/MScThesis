function AR_estimator(ser_diff)

P=8;
fs=1/mean(ser_diff);
% RRintervals_dep=RRintervals-mean(RRintervals);
RRintervals_dep=RRintervals;
Y=RRintervals_dep(P+1:end)';
X=[ones(length(Y),1),toeplitz(RRintervals_dep(P:end-1),RRintervals_dep(P:-1:1))];

beta=(X'*X)\(X'*Y);
beta(1)=0;
% beta=[beta(1);beta(end:-1:2)];
% beta=beta(2:end);
%% 

N=512;
FT=fft(beta,N*2);
S=1./(1-FT);
S=S.*conj(S);
S=2.*S(1:N,:).*var(RRintervals_dep)/fs;
freq=linspace(0,1/2,N).*fs;
figure,plot(freq,S)
hold on

[w,f]=periodogram(RRintervals_dep,[],N,fs);
plot(f,w)

[p,f]=pyulear(RRintervals_dep,P+1,N,fs);
plot(f,p)

legend('Manual AR','Periodogram','YW-AR')

%%
