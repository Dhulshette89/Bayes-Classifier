clear all; close all; clc;
data = dlmread('iris_dataset.dat');
%Shuffling data to get a random set
shuffled_data=data(randperm(150),:);
%saving total data size to count
DataSize=size(data,1);
%Number of folds
TotalFolds=10; 
Accuracy=zeros(TotalFolds,1);

for k=1:TotalFolds
    count=0;
    %take test and train data for k fold cross validation%
    if k==1
      training_data=shuffled_data(16: DataSize,:);
    else
      training_data=shuffled_data([1:(k*15)-15 (k*15)+1:DataSize],:) ;
    end
    testing_data=shuffled_data((k*15)-14:(k*15),:);
    
    % Take all training examples with class1
    index1=training_data(:,5)== 1;
    Total_u1=training_data(index1,1:4);
    
    %Take all training examples with class2%
    index2=training_data(:,5)== 2;
    Total_u2=training_data(index2,1:4);
    
    %Take all training examples with class3%
    index3=training_data(:,5)== 3;
    Total_u3=training_data(index3,1:4);
    
    %Calculating mean of each class
    
    mean_u1=mean(Total_u1);
    mean_u2=mean(Total_u2);
    mean_u3=mean(Total_u3);
    
    %Now calculating covriance of each class using covmle function
    
    cov1=covmle(training_data(:,1:4),mean_u1');
    cov2=covmle(training_data(:,1:4),mean_u2');
    cov3=covmle(training_data(:,1:4),mean_u3');
    
    for i=1:15
      %Calculate discriminant Functions %
      g1=Discriminant(testing_data(i,1:4),cov1,mean_u1);
      g2=Discriminant(testing_data(i,1:4),cov1,mean_u2);
      g3=Discriminant(testing_data(i,1:4),cov1,mean_u3);
      
      %check for the maximum value of discriminant function%
      if( g1 > g2 && g1 > g3)
        predicted=1;
      elseif (g2>g1 && g2 > g3)
        predicted=2;
      else
        predicted=3;
      end
      %check if the value predicted is same as the actual value%
      if predicted==testing_data(i,5)
        count=count+1;
      end
   
    end
    %Calculate accuracy%
    accuracyRes=(count/15);
    Accuracy(k)= accuracyRes;
    
end
Accuracy
x=mean(Accuracy);
fprintf('Average Accuarcy =%f \n',x)   