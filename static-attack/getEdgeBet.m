
%% 潮流计算各个线路上的有功功率
function  Ret=getEdgeBet(Net)
global Power0;
global L;
Ret=zeros(L,1);
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
    
    Breduced=Bdc(:,2:end);
    Z=pinv(Breduced);
    C=Bl*Adj*Z;
    
    G=find(power(:,2)>0);
    D=find(power(:,2)<0);
    
    for i=1:length(G)
        for j=1:length(D)
            Pn=zeros(nb,1);
            Pn(G(i))=1;
            Pn(D(j))=-1;
            
            Ret(Branch(:,1))=Ret(Branch(:,1))+(C*Pn)*min(power(G(i),2),-power(D(j),2));
        end
    end
end
Ret=abs(Ret);
end
