function []= plot_individual_PAT_PP(sub,pat_subjs,pp_subjs)

sub = sub+1;
% PAT plot
%preparing for boxplot

pat_lengths = [length(pat_subjs{sub,1}) length(pat_subjs{sub,2}) length(pat_subjs{sub,3}) length(pat_subjs{sub,4}) length(pat_subjs{sub,5}) length(pat_subjs{sub,6}) length(pat_subjs{sub,7}) length(pat_subjs{sub,8})];
pat_box = NaN(max(pat_lengths),8);


for i=1:8
pat_box(1:length(pat_subjs{sub,i}),i)=pat_subjs{sub,i};
end

baselines = [1 3 5 7];
phases = [2 4 6 8];

figure()
subplot(1,2,1)
boxplot(pat_box(:,baselines),'labels',{'b1','b2','b3','b4'})
title(strcat('PAT Baselines subject ',string(sub-1)))
subplot(1,2,2)
boxplot(pat_box(:,phases),'labels',{'sad','relax','happy','fear'});
title(strcat('PAT Phases subject ',string(sub-1)))

% PP plot

pp_lengths = [length(pp_subjs{sub,1}) length(pp_subjs{sub,2}) length(pp_subjs{sub,3}) length(pp_subjs{sub,4}) length(pp_subjs{sub,5}) length(pp_subjs{sub,6}) length(pp_subjs{sub,7}) length(pp_subjs{sub,8})];
pp_box = NaN(max(pp_lengths),8);


for i=1:8
pp_box(1:length(pp_subjs{sub,i}),i)=pp_subjs{sub,i};
end

baselines = [1 3 5 7];
phases = [2 4 6 8];

figure()
subplot(1,2,1)
boxplot(pp_box(:,baselines),'labels',{'b1','b2','b3','b4'})
title(strcat('PP Baselines subject ',string(sub-1)))
subplot(1,2,2)
boxplot(pp_box(:,phases),'labels',{'sad','relax','happy','fear'});
title(strcat('PP Phases subject ',string(sub-1)))

end

