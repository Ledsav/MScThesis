clear, close, clc

load('Feaut_ML.mat')

N_subj = length(string(Feaut{2,1}));
Dataset = table();

%insert features values
for j=2:length(Feaut)
    for k=2:size(Feaut{2,j},2)
        in=1;
        fin=N_subj;
        for i=1:4
            values=Feaut{2,j}{3,k}(:,i);
            if(std(Feaut{2,j}{3,k}(:,i))~=0)% delete feauters that are meaningless
                Dataset.(strcat(Feaut{2,j}{1,k},'_',strrep(Feaut{1,j},'_total','')))(in:fin) = values;
                in = in +N_subj;
                fin = fin +N_subj;
            end
        end
    end
end


[~ ,~ ,Pass] = xlsread('Votes_choerence.xlsx');
Row_del = length(Pass)-4:length(Pass);
Pass(Row_del,:) = [];
Pass_mat = cell2mat(Pass(2:end,2:end));
Pass_mat(isnan(Pass_mat))=0;
Pass_mat(Pass_mat<=3)=0.33;
Pass_mat(Pass_mat<=7 & Pass_mat>3)=0.66;
Pass_mat(Pass_mat<=10 & Pass_mat>7)=1;

%insert Emotion_choerence
in=1;
fin=N_subj;

for i =1:4
    Dataset.Emotion_choerence(in:fin) = Pass_mat(:,i);
    in = in +N_subj;
    fin = fin +N_subj;
end

%insert code
in=1;
fin=N_subj;

for i=1:4
    Dataset.Code(in:fin) = Feaut{2,:};
    in = in +N_subj;
    fin = fin +N_subj;
end


%insert target
in=1;
fin=N_subj;
for i=1:4
    Dataset.Target(in:fin) = i;
    in = in +N_subj;
    fin = fin +N_subj;
end

save('Dataset_ML','Dataset')