function pred = classf(Xtrain,ytrain,Xtest)
mdl = fitglm(Xtrain,ytrain,'Distribution','normal');
yfit = predict(mdl,Xtest);
pred = yfit;
end

