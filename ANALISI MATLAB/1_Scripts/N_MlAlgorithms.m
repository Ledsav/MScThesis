clear, close, clc

load('Dataset_ML.mat')
writetable(Dataset,'Dataset.xlsx')
%% TRAIN TEST SPLIT
c = cvpartition(Dataset.Target,'HoldOut',0.2,'Stratify',true);


Data = table2array(Dataset(:,1:end-1));

Training_data = Data(c.training,:);
Training_label = Dataset.Target(c.training);
Test_data = Data(c.test,:);
Test_label = Dataset.Target(c.test);


Data_w_label = table2array(Dataset(c.training,:)); %used for correlation matrix
%% Feature selection (filter)
F_names = string(Dataset.Properties.VariableNames);
Corr_Mat = corrcoef(Data_w_label);

%find correlated features (corr>80)
[indx(:,1),indx(:,2)]=find(abs(Corr_Mat)>0.80 & abs(Corr_Mat)~= 1);
correlated_features = table();
correlated_features.F1 = F_names(indx(:,1))';
correlated_features.F2 = F_names(indx(:,2))';
correlated_features.corr = Corr_Mat(abs(Corr_Mat)>0.80 & abs(Corr_Mat)~= 1);

%delete_feaut from training and test
delet_feaut = unique(indx(:,2));
Training_data(:,delet_feaut)=[];
Test_data(:,delet_feaut)=[];

%% Train with K fold
kf = cvpartition(Training_label,'KFold',10,'Stratify',true);

% KNN
cvKnn = fitcknn(Training_data,Training_label,'NumNeighbors',10,'Standardize',1,'CVPartition',kf);
discrRate = kfoldLoss(cvKnn);
predictedEmotion = kfoldPredict(cvKnn);
confusionchart(Training_label,predictedEmotion)


%GLM
for k=1:10
    % training/testing indices for this fold
    tr_in = kf.training(k);
    te_in = kf.test(k);

    % train GLM model
    cvGlm = fitglm(Training_data(tr_in,:),Training_label(tr_in,:),'linear','Distribution','normal');


    % compute mean squared error
    Ymodel = loss(cvGlm,Training_data(te_in,:));
    
end

avrg_err = mean(err);
