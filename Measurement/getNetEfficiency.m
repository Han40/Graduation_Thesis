%% ��������Ч�ʣ��迹����֮�ͣ�
function  Efficiency= getNetEfficiency(Net)%kΪ�Ƴ���Ľڵ����
global N;
s=0;
Time=0;
for num=1:length(Net)
Bdc=Net(num).Bdc(:,2:end);

Time=Time+size(Bdc,1)*(size(Bdc,1)-1);

X=abs(1./Bdc);%%���ڱߵĵ翹
Dis=all_shortest_paths(sparse(X));
ind=find(Dis>0);
Dis(ind)=1./Dis(ind);
s=s+sum(sum(Dis));
end
Efficiency=s/N/(N-1);
% Efficiency=s/Time;
end