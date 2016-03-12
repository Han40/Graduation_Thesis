%% ��M�ļ�Ϊ��������
clc; clear all;close all;
tic;
%% %% ���ݳ�ʼ��
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
TestMax=80;%�������
len=20;
Alpha=linspace(0,1,len);
Beta=linspace(0,1,11);
MaxScale0=N;
SumLoad0=-sum(Power0(Power0<0));
NodeBet0 = getNodeBet(Net0);
Efficiency0=getNetEfficiency(Net0);
NetAbi0=getNetAbility(Net0);

Pline0=chaoliu(Net0);

ATK = struct('name',{'RL','HL','BL'},...%������ʽ����
    'MaxScale',repmat({zeros(11,len)},1,3),...%����Ӽ���ģ
    'LossLoad',repmat({zeros(11,len)},1,3),...%���ʧ����
    'Efficiency',repmat({zeros(11,len)},1,3),...%����Ч��
    'NetAbi',repmat({zeros(11,len)},1,3));%���紫������

for AtkMode=1:3
    for i=11
        %Lnode0=getInitalLoad(Net0,NodeBet0,Beta(i));
        Lnode0=NodeBet0;
        [~,ind]=sort(-Lnode0);
        for j=1:len
            Cnode=Lnode0*(1+Alpha(j));
            for AttackTest=1:TestMax
                %% ��������*,״̬������ʼ��
                Lnode=Lnode0;
                CurNet=Net0;
                switch AtkMode
                    case 1
                        NodeOverList = SelectTarget(1,CurNet);%%����ƻ���ʼ�ڵ�
                    case 2
                        [~,NodeOverList]=max(Lnode0);
                    case 3
                        %[~,NodeOverList]=max(NodeBet0);
                        [~,NodeOverList]=min(Lnode0);
                end
                Net_1=damage(1,Net0,NodeOverList);%%Ϊ�˼����ƻ�1���ڵ���״̬
                while ~isempty(NodeOverList)
                    Lnode=Redistribution(CurNet,Lnode,NodeOverList,NodeBet0);
                    CurNet=damage(1,CurNet,NodeOverList);%%AtkModeС��4���ڽڵ㹥��
                    %% ����ָ����޸�
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
%     {'���紫�������½�����(%)','lower',max(Alpha)});
% CreateCascFigure([Alpha' (1-Data2)*100],...
%     {'���紫�������½�����(%)','higher',max(Alpha)});
% toc;
