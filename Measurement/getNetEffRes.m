%% 计算网络有效阻抗值(基于特征值)
function Ret = getNetEffRes(Net)
global N;
s=0;
for num=1:length(Net)
    Bdc=Net(num).Bdc(:,2:end);
    Z=pinv(Bdc);
    k=size(Z,1);
    for i=1:k-1
        for j=(i+1):k
            s=s+1/(Z(i,i)-2*Z(i,j)+Z(j,j));
        end
    end
end
Ret=s/(N*(N-1));
% 
% for num=1:length(Net)
%     Bdc=Net(num).Bdc(:,2:end);
%     root=eig(Bdc);
%     root=-sort(-root);
%     Rg=size(Bdc,1)*sum(1./root(1:end-1));
%     s=s+Rg;
% end
% Ret=s;
end