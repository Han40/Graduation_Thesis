
%% �������������·�ϵ��й�����
function Ret=chaoliu(Net)%%RetΪ����·�ĳ���ֵ
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
       
    Bl=diag(Branch(:,4));%�����迹�Խ�N*N����   
    row=[(1:nl)';(1:nl)'];
    
    fun=@(x) find(Bdc(:,1)==x); 
    coltemp=[Branch(:,2);Branch(:,3)];
    col=arrayfun(fun,coltemp);

    
    value=[ones(nl,1);-ones(nl,1)];
    Adj = sparse(row,col,value,nl,nb);%%�ڽӾ���
    
    Breduced=Bdc(:,2:end);
    Z=pinv(Breduced);
    C=Bl*Adj*Z;
        
    Pn=power(:,2); 
    Ret(Branch(:,1))=C*Pn;
end
end






