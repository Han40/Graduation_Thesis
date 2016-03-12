function NodeOverList = sel(Lnode,Cap)
NodeOverList=[];
rho=1.4;
Sub1=(Lnode-rho*Cap);
Sub2=(Lnode-Cap);
ind1=find(Sub1>0);
ind2=find(Sub2>0);
if ~isempty(ind1)
    R=unidrnd(length(ind1));
    NodeOverList=ind1(R);
elseif ~isempty(ind2)
    probability=Sub2(ind2)./Cap(ind2)./(rho-1);
    NoP=prod(1-probability);%% ���������ϵĸ���
    
    Pro=[probability;NoP];
    ind2=[ind2;0];
    target=LunPan(Pro/sum(Pro),1);%% ���̶��㷨
    
    if ind2(target)~=0
        NodeOverList=ind2(target);
    end
end
end

