%% 计算网络效率（阻抗倒数之和）
function  Efficiency= getNetEfficiency(Net)%k为移除后的节点个数
global N;
s=0;
Time=0;
for num=1:length(Net)
Bdc=Net(num).Bdc(:,2:end);

Time=Time+size(Bdc,1)*(size(Bdc,1)-1);

X=abs(1./Bdc);%%相邻边的电抗
Dis=all_shortest_paths(sparse(X));
ind=find(Dis>0);
Dis(ind)=1./Dis(ind);
s=s+sum(sum(Dis));
end
Efficiency=s/N/(N-1);
% Efficiency=s/Time;
end