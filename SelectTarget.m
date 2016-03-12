function Target = SelectTarget(AtkMode,Net)
global N;
global L;
global node2edge;
switch AtkMode
    case 1
        % 随机攻击节点选取
        TempNode=[];
        for i=1:length(Net)
            TempNode=cat(1,TempNode,Net(i).Bdc(:,1));
        end
        R=unidrnd(length(TempNode));
        Target=TempNode(R);
    case 2 %% 按节点度攻击
        DegVec=zeros(N,1);
        for i=1:length(Net)
            Adj=(Net(i).Bdc(:,2:end)~=0);
            Deg=degrees(Adj)-2;%%减掉自己的2次，加上自己的负荷虚拟节点
            DegVec(Net(i).Bdc(:,1))=Deg;
        end
        maxPos=find(DegVec==max(DegVec));
        R=unidrnd(length(maxPos));
        Target=maxPos(R);
        
    case 3 %% 按节点电气权重度攻击
        DegVec=getEletricDegree(Net);
        [~,Target]=max(DegVec);
%         DegVec=zeros(N,1);     
%         for i=1:length(Net) 
%             Bdc=Net(i).Bdc(:,2:end);
%             Adj=(Bdc~=0);
%             Deg=degrees(Adj)-2;%%减掉自己的2次，加上自己的负荷虚拟节点
%             DegVec(Net(i).Bdc(:,1))=sqrt(Deg'.*diag(Bdc));
%         end
%         [~,Target]=max(DegVec);
        
    case 4  %% 传统节点介数攻击
        TradBet=zeros(N,1);
        for i=1:length(Net)
            Z=abs(1./Net(i).Bdc(:,2:end));
            Z(Z==inf)=0;
            [value,~]=betweenness_centrality(sparse(Z));
            TradBet(Net(i).Bdc(:,1))=value;
        end
        maxPos=find(TradBet==max(TradBet));
        R=unidrnd(length(maxPos));
        Target=maxPos(R);
        
    case 5 %%节点电气介数攻击
        NodeBet=getNodeBet(Net);
        [~,Target]=max(NodeBet);
        
    case 6 %%随机线路攻击
        TempEdge=[];
        for i=1:length(Net)
            TempEdge=cat(1,TempEdge,Net(i).Branch(:,1));
        end
        R=unidrnd(length(TempEdge));
        Target=TempEdge(R);
    case 7    %%线路度攻击
        DegVec=zeros(L,1);
        Deg=zeros(N,1);
        for i=1:length(Net)
            Adj=(Net(i).Bdc(:,2:end)~=0);
            Deg(Net(i).Bdc(:,1))=degrees(Adj)-2;%%减掉自己的2次，加上自己的负荷虚拟节点
        end  
        for i=1:length(Net)
            FBUS=Net(i).Branch(:,2);
            TBUS=Net(i).Branch(:,3);
            DegVec(Net(i).Branch(:,1))=sqrt(Deg(FBUS).*Deg(TBUS));%%线路度概念
        end
        maxPos=find(DegVec==max(DegVec));
        R=unidrnd(length(maxPos));
        Target=maxPos(R);
    case 8%% 传统线路介数
        TradBet=zeros(N,N);
        for i=1:length(Net)
            Z=abs(1./Net(i).Bdc(:,2:end));
            Z(Z==inf)=0;
            [~,value]=betweenness_centrality(sparse(Z));
            TradBet(Net(i).Bdc(:,1),Net(i).Bdc(:,1))=full(value);
        end
        TradBet=triu(TradBet);
        MaxValue=max(max(TradBet));
        [x,y]=find(TradBet==MaxValue);
        R=unidrnd(length(x));
        Target=node2edge([x(R),y(R)]*[200,1]');
    case 9%%线路电气介数攻击
        SumP=getEdgeBet(Net);
        [~,Target]=max(SumP);       
end
end

