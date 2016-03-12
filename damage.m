function Net = damage(AtkMode,Net,Target)
global Net0;
if AtkMode<6 %%node break
    for i=1:length(Net)
        ind=find(Net(i).Bdc(:,1)==Target);
        if ~isempty(ind)
            break;
        end
    end
    Net(i).Bdc(:,ind+1)=[];
    Net(i).Bdc(ind,:)=[];
else %%line break
    for i=1:length(Net)
        row=find(Net(i).Bdc(:,1)==Net0.Branch(Target,2));
        col=find(Net(i).Bdc(:,1)==Net0.Branch(Target,3));
        if (~isempty(row))&&(~isempty(col))
            break;
        end
    end
    
    Net(i).Bdc(row,col+1)=0;
    Net(i).Bdc(col,row+1)=0;
    
end
BdcTemp=Net(i).Bdc(:,2:end);
BdcTemp(eye(size(BdcTemp,1))==1)=0;
BdcTemp(eye(size(BdcTemp,1))==1)=-sum(BdcTemp,2);%%对角元素重新建立
Net(i).Bdc(:,2:end)=BdcTemp;

if (~isempty(Net(i).Bdc))&&(~isempty(Net(i).Branch))
    NewNet=sys_part(Net(i));
    Net=cat(2,Net,NewNet);
end
Net(i)=[];

end

