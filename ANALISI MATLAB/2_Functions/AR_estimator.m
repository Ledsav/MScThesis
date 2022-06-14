function beta = AR_estimator(ser_diff)

P=8;

% RRintervals_dep=RRintervals-mean(RRintervals);
ser_diff_dep = ser_diff;%- mean(ser_diff);
Y=ser_diff_dep(P+1:end)';
X=[ones(length(Y),1),toeplitz(ser_diff_dep(P:end-1),ser_diff_dep(P:-1:1))];

beta=(X'*X)\(X'*Y);
beta(1)=0.7;

