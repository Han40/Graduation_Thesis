function Target = SelectTarget(AtkMode,Net)
global N;
global L;
global node2edge;
switch AtkMode
    case 1
        % ��������ڵ�ѡȡ
        TempNode=[];
        for i=1:length(Net)
            TempNode=cat(1,TempNode,Net(i).Bdc(:,1));
        end
        R=unidrnd(length(TempNode));
        Target=TempNode(R);
    case 2 %% ���ڵ�ȹ���
        DegVec=zeros(N,1);
        for i=1:length(Net)
            Adj=(Net(i).Bdc(:,2:end)~=0);
            Deg=degrees(Adj)-2;%%�����Լ���2�Σ������Լ��ĸ�������ڵ�
            DegVec(Net(i).Bdc(:,1))=Deg;
        end
        maxPos=find(DegVec==max(DegVec));
        R=unidrnd(length(maxPos));
        Target=maxPos(R);
        
    case 3 %% ���ڵ����Ȩ�ضȹ���
        DegVec=getEletricDegree(Net);
        [~,Target]=max(DegVec);
%         DegVec=zeros(N,1);     
%         for i=1:length(Net) 
%             Bdc=Net(i).Bdc(:,2:end);
%             Adj=(Bdc~=0);
%             Deg=degrees(Adj)-2;%%�����Լ���2�Σ������Լ��ĸ�������ڵ�
%             DegVec(Net(i).Bdc(:,1))=sqrt(Deg'.*diag(Bdc));
%         end
%         [~,Target]=max(DegVec);
        
    case 4  %% ��ͳ�ڵ��������
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
        
    case 5 %%�ڵ������������
        NodeBet=getNodeBet(Net);
        [~,Target]=max(NodeBet);
        
    case 6 %%�����·����
        TempEdge=[];
        for i=1:length(Net)
            TempEdge=cat(1,TempEdge,Net(i).Branch(:,1));
        end
        R=unidrnd(length(TempEdge));
        Target=TempEdge(R);
    case 7    %%��·�ȹ���
        DegVec=zeros(L,1);
        Deg=zeros(N,1);
        for i=1:length(Net)
            Adj=(Net(i).Bdc(:,2:end)~=0);
            Deg(Net(i).Bdc(:,1))=degrees(Adj)-2;%%�����Լ���2�Σ������Լ��ĸ�������ڵ�
        end  
        for i=1:length(Net)
            FBUS=Net(i).Branch(:,2);
            TBUS=Net(i).Branch(:,3);
            DegVec(Net(i).Branch(:,1))=sqrt(Deg(FBUS).*Deg(TBUS));%%��·�ȸ���
        end
        maxPos=find(DegVec==max(DegVec));
        R=unidrnd(length(maxPos));
        Target=maxPos(R);
    case 8%% ��ͳ��·����
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
    case 9%%��·������������
        SumP=getEdgeBet(Net);
        [~,Target]=max(SumP);       
end
end

