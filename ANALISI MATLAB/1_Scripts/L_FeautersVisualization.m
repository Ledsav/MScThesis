% Feaut = {'GSR_total', 'PulsePulse_total', 'PP_total', 'PAT_total', 'POINT_total', 'F_OO_CLASS', 'RESP_total';
%     GSR_total, PulsePulse_total, PP_total, PAT_total, POINT_total, F_OO_CLASS, RESP_total};

% save('Feaut.mat')


clc,clear,close
load('Feaut.mat')


%% gsr
visualize_statisticplot3(Feaut,[1 1 1],[4 5 6])

