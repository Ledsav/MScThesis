clear,close,clc

%% load subject annotations
%where to save the struct 
path = 'C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\';
%extracting the list of subjects from the folder
codes = dir('C:\Users\megaa\OneDrive\Desktop\UNIVERSITA\POLIMI\TESI\Immagini_segnali\');
code_list = {codes.name};
code_list_var = code_list(3:end);
i=36;
subject = strcat(code_list_var(i),'.txt_ecg_bvp_ann.mat');
direc = strcat(path,code_list_var(i),'\',subject);
load(direc{1})

%% ECG
%visualization ecg
% figure()
% plot((1:length(data.ecg))/(2048*60),data.ecg)%in minutes
% for i=1:length(data.annotations(1,:))
%   hold on 
%   plot(data.annotations(1,i)/(2048*60),data.ecg(data.annotations(1,i)),'r*')  
% end
%compute tacogram
tac = diff(data.annotations(1,:));
ecg_annotations = data.annotations(1,:);
while  max(tac)/2048 > 1.2
index = find(tac == max(tac));
ecg_cut = data.ecg(ecg_annotations(1,index):ecg_annotations(1,index+1));

%visualization cutted ecg
plot(ecg_cut)
for i= index:index+1
  hold on 
  plot(ecg_annotations(1,i)-ecg_annotations(1,index),data.ecg(ecg_annotations(1,i)),'r*')  
end

corr_factor = 300;
a = ecg_annotations(index+1);
[pks,locs] = findpeaks(ecg_cut(corr_factor:end-corr_factor),'MinPeakHeight',mean(data.ecg(data.annotations(1,index:index+1))),'MinPeakDistance',1000,'MinPeakProminence',0.8);
loc_peak = round(locs+ecg_annotations(1,index)+corr_factor-1);
ecg_annotations = [ecg_annotations(1,1:index) loc_peak' ecg_annotations(1,index+1:end)];
b = a - ecg_annotations(index+1);


plot((1:length(data.ecg))/(2048*60),data.ecg)%in minutes
for i=1:length(ecg_annotations)
  hold on 
  plot(ecg_annotations(i)/(2048*60),data.ecg(ecg_annotations(i)),'r*')  
end
xlim([ecg_annotations(index)/(2048*60) (ecg_annotations(index)/(2048*60))+0.5])


tac = diff(ecg_annotations);
end
%% PPG

%onset-----------------------------------------------------
ons_annotations = zeros(1,length(data.annotations(2,:)));
ann=data.annotations(2,:);
val=data.annotations(3,:);
while length(ons_annotations)<length(ecg_annotations)
%estimation of the onset position
ons = diff(ann);
index = find(ons == max(ons));
%beta = AR_estimator(ons);
%est_pos = sum([ons(index-1:-1:index-9)].*beta');%underestimation
est_pos = mean([ons(index-1:-1:index-4)]);
ons_annotations = [ann(1:index) ann(index)+est_pos ann(index+1:end)];
ann=ons_annotations;
%estimation of the onset value
est_val = sum([val(index+1) val(index) val(index-1)].*[(mean(ons)/(ons(index)-ons(index+1))) 1 0.5])/sum([(mean(ons)/(ons(index)-ons(index+1))) 1 0.5]);%prova MOVING AVARAGE per il peso 
ons_values = [val(1:index) est_val val(index+1:end)];
val=ons_values;
end

%sys------------------------------------------------------
sys_annotations = zeros(1,length(data.annotations(4,:)));
ann=data.annotations(4,:);
val=data.annotations(5,:);
while length(sys_annotations)<length(ecg_annotations)
%estimation of the onset position
sys = diff(ann);
index = find(sys == max(sys));
%beta = AR_estimator(sys);
%est_pos = sum([sys(index-1:-1:index-9)].*beta');%underestimation
est_pos = mean([sys(index-1:-1:index-4)]);
sys_annotations = [ann(1:index) ann(index)+est_pos ann(index+1:end)];
ann=sys_annotations;
%estimation of the onset value
est_val = sum([val(index+1) val(index) val(index-1)].*[(mean(sys)/(sys(index)-sys(index+1))) 1 0.5])/sum([(mean(sys)/(sys(index)-sys(index+1))) 1 0.5]);
sys_values = [val(1:index) est_val val(index+1:end)];
val=sys_values;
end

%dias------------------------------------------------------
%visualization ppg
dias_annotations = zeros(1,length(data.annotations(6,:)));
ann=data.annotations(6,:);
val=data.annotations(7,:);
while length(dias_annotations)<length(ecg_annotations)
%estimation of the onset position
dias = diff(ann);
index = find(dias == max(dias));
%beta = AR_estimator(dias);
%est_pos = sum([dias(index-1:-1:index-9)].*beta');%underestimation
est_pos = mean([dias(index-1:-1:index-4)]);
dias_annotations =  [ann(1:index) ann(index)+est_pos ann(index+1:end)];
ann=dias_annotations;
%estimation of the onset value
est_val = sum([val(index+1) val(index) val(index-1)].*[(mean(dias)/(dias(index)-dias(index+1))) 1 0.5])/sum([(mean(dias)/(dias(index)-dias(index+1))) 1 0.5]);
dias_values = [val(1:index) est_val val(index+1:end)];
val=dias_values;
end

ons_annotations = round(ons_annotations);
sys_annotations = round(sys_annotations);
dias_annotations = round(dias_annotations);

close all

%visualization

figure()
plot((1:length(data.ppg))/(2048*60),data.ppg)%in minutes
for i=1:length(data.annotations(1,:))
  hold on 
  plot(data.annotations(2,i)/(2048*60),data.annotations(3,i),'go')
  plot(data.annotations(4,i)/(2048*60),data.annotations(5,i),'ro')
  plot(data.annotations(6,i)/(2048*60),data.annotations(7,i),'bo')
  
end
xlim([data.annotations(1,index)/(2048*60) (data.annotations(1,index)/(2048*60))+0.5])

figure()
plot((1:length(data.ppg))/(2048*60),data.ppg)%in minutes
for i=1:length(ecg_annotations)
  hold on 
  plot(ons_annotations(i)/(2048*60),ons_values(i),'go')
  plot(sys_annotations(i)/(2048*60),sys_values(i),'ro')
  plot(dias_annotations(i)/(2048*60),dias_values(i),'bo')
  
end
xlim([ecg_annotations(index)/(2048*60) (ecg_annotations(index)/(2048*60))+0.5])

%%
%------- how ot save annotations?
%replace infromation
data.annotations=zeros(7,length(ecg_annotations));

data.annotations(1,:)= ecg_annotations;
data.annotations(2,:)= ons_annotations;
data.annotations(3,:)= ons_values;
data.annotations(4,:)= sys_annotations;
data.annotations(5,:)= sys_values;
data.annotations(6,:)= dias_annotations;
data.annotations(7,:)= dias_values;
data.ann_struct.all = data.annotations;

save(direc{1},'data')