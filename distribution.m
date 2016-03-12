% clc;clear all;close all;
% figure1 = figure('Color',[1 1 1]);
% load BA.mat 
% Deg_vector=degrees(Adj)-2;
% N=size(Adj,1);
% 
%     Dis=zeros(1,max(Deg_vector));
%     index=1;
%     for i=0:max(Deg_vector)-1
%         temp=find(Deg_vector>i);
%         Dis(index)=length(temp)/N;
%         index=index+1;
%     end
%     
%     y=log(Dis);%归一化
%     x=0:max(Deg_vector)-1;
%     fun=polyfit(x,y,1);
%     fun=roundn(fun,-2);
%      
%     a=linspace(0,max(Deg_vector),500);
%     b=exp(a.*fun(1)+fun(2));
%     axis([0,max(Deg_vector),0,1]);
%     Q1=semilogy(x,Dis,'*',...
%         a,b,'-');
%     set(Q1,'LineWidth',3);  
%     set(Q1(1),'Color',[0 1 0]);
%     set(Q1(2),'Color',[1 0 0]); 
%     legend('数据点','节点度分布');
%     xlabel('节点度');
%     ylabel('P(K)');
%     title(data{ind});
clc;clear all;close all;
global N;
global L;
global Power0;
data={'case118.mat' 'CaseUCTE.mat'};
figure1 = figure('Color',[1 1 1]);
for ind=1:length(data)
    subplot(1,length(data),ind);
    eval(['load ' data{ind}]); 
    L=size(Net0.Branch,1);
    N=size(Net0.Bdc,1);
    B=Net0.Bdc(:,2:end);
    Adj=(B~=0);
    cluster=clustering_coefficients(sparse(Adj));       
    Deg_vector=degrees(Adj)-2;
    
    clu=mean(cluster)%% 聚类系数 
       
    Dis=zeros(1,max(Deg_vector));
    index=1;
    for i=0:max(Deg_vector)-1
        temp=find(Deg_vector>i);
        Dis(index)=length(temp)/N;
        index=index+1;
    end
    
    y=log(Dis);%归一化
    x=0:max(Deg_vector)-1;
    fun=polyfit(x,y,1);
    fun=roundn(fun,-2);
     
    a=linspace(0,max(Deg_vector),500);
    b=exp(a.*fun(1)+fun(2));
    axis([0,max(Deg_vector),0,1]);
    Q1=semilogy(x,Dis,'*',...
        a,b,'-');
    set(Q1,'LineWidth',3);  
    set(Q1(1),'Color',[0 1 0]);
    set(Q1(2),'Color',[1 0 0]); 
    legend('数据点','节点度分布');
    xlabel('节点度');
    ylabel('P(K)');
    title(data{ind});
end



   