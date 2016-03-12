clc; clear all;close all;
tic;
%% %% 数据初始化
global Power0; 
global slack0;
global N;
global L;
global ATK;
global Net0;
global node2edge;
load case300.mat;
N=size(Power0,1);
L=size(Net0.Branch,1);
PerMax=10;%% 攻击节点个数百分比
TESTMAX=20;%试验次数

MaxScale0=N;
SumLoad0=-sum(Power0(Power0<0));
NodeBet0 = getNodeBet(Net0);
Efficiency0=getNetEfficiency(Net0);
NetAbi0=getNetAbility(Net0);
NetEffRes0=getNetEffRes(Net0);

RemNum1=fix(PerMax*N/100)+1;
RemNum2=fix(PerMax*L/100)+1;
ATK = struct('name',{'随机节点攻击','节点度攻击','节点电气度攻击','传统节点介数攻击','节点电气介数攻击',...
    '随机线路攻击','线路度攻击','传统节点介数攻击','线路电气介数攻击'},...%攻击方式名称；攻击目标（Target）
    'MaxScale',[repmat({zeros(RemNum1,1)},1,5),repmat({zeros(RemNum2,1)},1,4)],...%最大子集规模
    'LossLoad',[repmat({zeros(RemNum1,1)},1,5),repmat({zeros(RemNum2,1)},1,4)],...%最大失负荷
    'Efficiency',[repmat({zeros(RemNum1,1)},1,5),repmat({zeros(RemNum2,1)},1,4)],...%网络效率
    'NetAbi',[repmat({zeros(RemNum1,1)},1,5),repmat({zeros(RemNum2,1)},1,4)],...%网络传输能力
    'NetEffRes',[repmat({zeros(RemNum1,1)},1,5),repmat({zeros(RemNum2,1)},1,4)]);%基于网络有效阻抗的效率
%% 静态攻击
for AtkMode=1:9
    if AtkMode<6
        RemNum=RemNum1;
    else
        RemNum=RemNum2;
    end
    if (AtkMode==3)||(AtkMode==5)||(AtkMode==9)
        TestMax=1;
    else
        TestMax=TESTMAX;
    end   
    for AttackTest=1:TestMax
        %% 重新试验,状态变量初始化       
        CurNet=Net0;
        for AttackNum=1:RemNum
            %% 随机攻击—计算各个指标值           
            Measure(AtkMode,AttackNum,CurNet);            
            Target=SelectTarget(AtkMode,CurNet);
            CurNet=damage(AtkMode,CurNet,Target);         
        end
    end   
    ATK(AtkMode).MaxScale=ATK(AtkMode).MaxScale/TestMax;
    ATK(AtkMode).LossLoad=ATK(AtkMode).LossLoad/TestMax;
    ATK(AtkMode).Efficiency=ATK(AtkMode).Efficiency/TestMax;
    ATK(AtkMode).NetAbi=ATK(AtkMode).NetAbi/TestMax;
    ATK(AtkMode).NetEffRes=ATK(AtkMode).NetEffRes/TestMax;
end
save StaticData.mat ATK;


%% 绘图
% Per=((1:RemNum2)-1)/N*100;
load StaticData.mat;
AtkMode=1:5;
RemNum=RemNum1;
Per=((1:RemNum1)-1)'/N*100;
% creatfigure1(Per,(1-cell2mat({ATK(AtkMode).MaxScale})/MaxScale0)*100,...
%     (1-cell2mat({ATK(AtkMode).Efficiency})/Efficiency0)*100);


figure1=figure('Color',[1 1 1]);
subplot(1,2,1);
plot(Per,(1-cell2mat({ATK(AtkMode).MaxScale})/MaxScale0)*100);
title('IEEE-118节点破坏','FontWeight','bold','FontSize',14);
xlabel('节点破坏(%)','FontWeight','bold','FontSize',14);
ylabel('最大连通子集规模','FontWeight','bold','FontSize',14);
axis([0,PerMax,0,100]);
legend('随机节点攻击','节点度攻击','节点电气度攻击','传统节点介数攻击','节点电气介数攻击');

subplot(1,2,2);
plot(Per,(1-cell2mat({ATK(AtkMode).Efficiency})/Efficiency0)*100);
title('IEEE-118节点破坏','FontWeight','bold','FontSize',14);
xlabel('节点破坏(%)','FontWeight','bold','FontSize',14);
ylabel('网络平均效率','FontWeight','bold','FontSize',14);
axis([0,PerMax,0,100]);
legend('随机节点攻击','节点度攻击','节点电气度攻击','传统节点介数攻击','节点电气介数攻击');

figure2=figure('Color',[1 1 1]);
subplot(1,2,1);
plot(Per,cell2mat({ATK(AtkMode).LossLoad})/SumLoad0*100);
title('IEEE-118节点破坏','FontWeight','bold','FontSize',14);
xlabel('节点破坏(%)','FontWeight','bold','FontSize',14);
ylabel('电网供电能力','FontWeight','bold','FontSize',14);
axis([0,PerMax,0,100]);
legend('随机节点攻击','节点度攻击','节点电气度攻击','传统节点介数攻击','节点电气介数攻击');

subplot(1,2,2);
plot(Per,(1-cell2mat({ATK(AtkMode).NetAbi})/NetAbi0)*100);
title('IEEE-118节点破坏','FontWeight','bold','FontSize',14);
xlabel('节点破坏(%)','FontWeight','bold','FontSize',14);
ylabel('电网传输能力','FontWeight','bold','FontSize',14);
legend('随机节点攻击','节点度攻击','节点电气度攻击','传统节点介数攻击','节点电气介数攻击');

axis([0,PerMax,0,100]);

toc



