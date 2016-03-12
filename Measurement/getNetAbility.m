
%% 计算Net Ability (其中包括电力传输因子计算)
function Ret = getNetAbility(Net)
%NetAbility Summary of this function goes here
%   Detailed explanation goes here
global Power0; 
len1=length(find(Power0(:,2)>0));
len2=length(find(Power0(:,2)<0));
Time=0;
NetAbi=0;
Pmax=9900/100;%换算成标幺值
for num=1:length(Net)   
    Bdc=Net(num).Bdc;
    Branch= Net(num).Branch;
    
    nb=size(Bdc,1);
    nl=size(Branch,1);
    CurNode=Bdc(:,1);
    power=Power0(CurNode,:);
    
    Bl=diag(Branch(:,4));%生成阻抗对角N*N矩阵   
    row=[(1:nl)';(1:nl)'];
    
    fun=@(x) find(Bdc(:,1)==x);   
    coltemp=[Branch(:,2);Branch(:,3)];
    col=arrayfun(fun,coltemp);
    
    value=[ones(nl,1);-ones(nl,1)];
    Adj = sparse(row,col,value,nl,nb);%%邻接矩阵
   
    Z=pinv(Bdc(:,2:end));
    C=Bl*Adj*Z;
         
    G=find(power(:,2)>0);
    D=find(power(:,2)<0);    

 for i=1:length(G)
    for j=1:length(D)
          Time=Time+1;
          Px=zeros(nb,1);
          Px(G(i))=1;
          Px(D(j))=-1;
          SumP=abs(C*Px);
          Cgd=min(Pmax./SumP);    
          NetAbi=NetAbi+Cgd/abs(Z(G(i),G(i))-2*Z(G(i),D(j))+Z(D(j),D(j)));
    end
 end
end
Ret=NetAbi/len1/len2;   

end











