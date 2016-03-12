%% º∆À„ ß∏∫∫…
function Ret = getLossLoad(Net)
% global lineload;
% ind=find(lineload~=0);
% Pline=chaoliu(Bu);
% rate=Pline(ind)./lineload(ind);
% rate(rate<=1)=0;
% Ret=sum(rate);
global Power0;
global N;
Ret=0;
NodeList=[];
for num=1:length(Net)
    node=Net(num).Bdc(:,1);
    NodeList=cat(1,NodeList,node);
    Temp=sum(Power0(node,2));
    if Temp<0
        Ret=Ret-Temp;
    end
end
Des=setdiff(1:N,NodeList');
D=find(Power0(:,2)<0);
ind=intersect(D,Des);
Ret=Ret+sum(-Power0(ind,2));
end