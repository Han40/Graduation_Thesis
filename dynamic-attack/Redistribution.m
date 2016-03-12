function Ret = Redistribution(Net,Lnode,target,W)
Ret=Lnode;
for k=1:length(Net)
    ind=find(Net(k).Bdc(:,1)==target,1);
    if ~isempty(ind)
        break;
    end
end
Bdc=Net(k).Bdc(:,2:end);

AdjBus=Net(k).Bdc(Bdc(ind,:)<0,1);
if ~isempty(AdjBus)
    Ret(AdjBus)=W(AdjBus)+W(AdjBus)./sum(W(AdjBus))*Lnode(target);
end
Ret(target)=0;
end