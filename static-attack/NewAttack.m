clc; clear all;close all;
tic;
%% %% 数据初始化
len=40;
Alpha=linspace(0,1,len);

global Power0; 
global slack0;
global N;
global L;
global ATK;
global Net0;
global node2edge;
load case118.mat;
N=size(Power0,1);
L=size(Net0.Branch,1);
PerMax=20;%% 攻击节点个数百分比
MaxScale0=N;
SumLoad0=-sum(Power0(Power0<0));
NodeBet0 = getNodeBet(Net0);
Efficiency0=getNetEfficiency(Net0);
NetAbi0=getNetAbility(Net0);

RemNum=fix(PerMax*N/100)+1;


ATK = struct('MaxScale',repmat({zeros(RemNum,1)},1,len),...%最大子集规模
    'LossLoad',repmat({zeros(RemNum,1)},1,len),...%最大失负荷
    'Efficiency',repmat({zeros(RemNum,1)},1,len),...%网络效率
    'NetAbi',repmat({zeros(RemNum,1)},1,len));...%网络能力
%% 新型攻击
for AtkMode=1:len
        CurNet=Net0;
        for AttackNum=1:RemNum
            %% 随机攻击—计算各个指标值
            Measure(AtkMode,AttackNum,CurNet);
            %% 新型攻击方式
            DegVec=zeros(N,1);
            for i=1:length(CurNet)
                Adj=(CurNet(i).Bdc(:,2:end)~=0);
                Deg=degrees(Adj)-2;%%减掉自己的2次，加上自己的负荷虚拟节点
                DegVec(CurNet(i).Bdc(:,1))=Deg;
            end
            NodeBet=getNodeBet(CurNet);
            Compre=Alpha(AtkMode)*DegVec/sum(DegVec)+...
                (1-Alpha(AtkMode))*NodeBet/sum(NodeBet);
            [~,Target]=max(Compre);
            
            CurNet=damage(1,CurNet,Target);
        end
end
      
Per=((1:RemNum)-1)/N*100;



figure(1)
[X,Y]=meshgrid(Alpha,Per);
Z=zeros(length(Alpha),length(Per));
for AtkMode=1:len
    Z(AtkMode,:)=ATK(AtkMode).Efficiency/Efficiency0*100;
end
surf(X,Y,Z')
colorbar;


figure(2)
[X,Y]=meshgrid(Alpha,Per);
Z=zeros(length(Alpha),length(Per));
for AtkMode=1:len
    Z(AtkMode,:)=ATK(AtkMode).NetAbi/NetAbi0*100;
end
surf(X,Y,Z');

figure(3)
[X,Y]=meshgrid(Alpha,Per);
Z=zeros(length(Alpha),length(Per));
for AtkMode=1:len
    Z(AtkMode,:)=ATK(AtkMode).LossLoad/SumLoad0*100;
end
surf(X,Y,Z');
colorbar;
