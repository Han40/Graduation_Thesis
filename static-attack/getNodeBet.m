%% 复杂网络的节点电气介数介数求解
function  Ret=getNodeBet(Net)
global Power0; 
global N;
global node2edge;
Ret=zeros(N,1);
Pline=getEdgeBet(Net);
for num=1:length(Net)
    CurNode=Net(num).Bdc(:,1);
    
    Branch= Net(num).Branch;
    
    G=intersect(find(Power0(:,2)>0),CurNode);
    D=intersect(find(Power0(:,2)<0),CurNode);    
    W=bsxfun(@min,Power0(G,2),(-Power0(D,2))');
    
   for i=1:length(CurNode)
        k=CurNode(i);
        if Power0(k,2)>0
           Ret(k)=Ret(k)+sum(W(k==G,:));
        elseif Power0(k,2)<0
           Ret(k)=Ret(k)+sum(W(:,k==D));
        end      
        s1=find(Branch(:,2)==k);
        s2=find(Branch(:,3)==k);
        L=union(s1,s2);
        Ret(k)=Ret(k)+sum(Pline(Branch(L,1)));
    end  
end
Ret=Ret/2;
end