%% 本M文件为连锁故障
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
load case118.mat;
N=size(Power0,1);
L=size(Net0.Branch,1);
TestMax=80;%试验次数
len=20;
Alpha=linspace(0,1,len);
Beta=linspace(0,1,11);
MaxScale0=N;
SumLoad0=-sum(Power0(Power0<0));
NodeBet0 = getNodeBet(Net0);
Efficiency0=getNetEfficiency(Net0);
NetAbi0=getNetAbility(Net0);

Pline0=chaoliu(Net0);

ATK = struct('name',{'RL','HL','BL'},...%攻击方式名称
    'MaxScale',repmat({zeros(11,len)},1,3),...%最大子集规模
    'LossLoad',repmat({zeros(11,len)},1,3),...%最大失负荷
    'Efficiency',repmat({zeros(11,len)},1,3),...%网络效率
    'NetAbi',repmat({zeros(11,len)},1,3));%网络传输能力

for AtkMode=1:3
    for i=11
        %Lnode0=getInitalLoad(Net0,NodeBet0,Beta(i));
        Lnode0=NodeBet0;
        [~,ind]=sort(-Lnode0);
        for j=1:len
            Cnode=Lnode0*(1+Alpha(j));
            for AttackTest=1:TestMax
                %% 重新试验*,状态变量初始化
                Lnode=Lnode0;
                CurNet=Net0;
                switch AtkMode
                    case 1
                        NodeOverList = SelectTarget(1,CurNet);%%随机破坏初始节点
                    case 2
                        [~,NodeOverList]=max(Lnode0);
                    case 3
                        %[~,NodeOverList]=max(NodeBet0);
                        [~,NodeOverList]=min(Lnode0);
                end
                Net_1=damage(1,Net0,NodeOverList);%%为了计算破坏1个节点后的状态
                while ~isempty(NodeOverList)
                    Lnode=Redistribution(CurNet,Lnode,NodeOverList,NodeBet0);
                    CurNet=damage(1,CurNet,NodeOverList);%%AtkMode小于4属于节点攻击
                    %% 负荷指标待修改
                    NodeOverList=sel(Lnode,Cnode);
                end
                CascMeasure(AtkMode,i,j,CurNet,Net_1);
            end
        end
        
    end
    ATK(AtkMode).MaxScale=ATK(AtkMode).MaxScale/TestMax;
    ATK(AtkMode).LossLoad=ATK(AtkMode).LossLoad/TestMax;
    ATK(AtkMode).Efficiency=ATK(AtkMode).Efficiency/TestMax;
    ATK(AtkMode).NetAbi=ATK(AtkMode).NetAbi/TestMax;
end
 save CascData.mat ATK;
%
% load CascData.mat
% Data1=[ATK(1).NetAbi(1:5,:);ATK(2).NetAbi(1:5,:)]';
% Data2=[ATK(1).NetAbi(6:10,:);ATK(2).NetAbi(6:10,:)]';
% CreateCascFigure([Alpha' (1-Data1)*100],...
%     {'网络传输能力下降比例(%)','lower',max(Alpha)});
% CreateCascFigure([Alpha' (1-Data2)*100],...
%     {'网络传输能力下降比例(%)','higher',max(Alpha)});
% toc;
