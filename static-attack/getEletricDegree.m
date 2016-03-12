function Ret = getEletricDegree(Net)
global Power0;
global N;
Ret=zeros(N,1);
power=Power0;
Pline=chaoliu(Net);
alpha=0.5;
for num=1:length(Net)
    Bdc=Net(num).Bdc;
    Branch= Net(num).Branch;
    CurNode=Bdc(:,1);
    
    for i=1:length(CurNode)
        k=CurNode(i);
        s1=find(Branch(:,2)==k);
        s2=find(Branch(:,3)==k);
        L=union(s1,s2);
        %% 求出度
        deg=length(find(Pline(L)>0));
        if power(k,2)<0
            deg=deg+1;%%负荷节点出度再加1
        end

        Ret(k)=sum(abs(Pline(Branch(L,1))))+abs(power(k,2));       
        Ret(k)=(Ret(k)^alpha)*(deg^(1-alpha));
    end
end
end
