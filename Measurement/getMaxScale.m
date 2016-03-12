%% 计算最大子集规
function Ret= getMaxScale(Net)
Ret=0;
for num=1:length(Net)
    k=size(Net(num).Bdc,1);
    if Ret<k
        Ret=k;
    end
end
end
