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
load case300.mat;
N=size(Power0,1);
L=size(Net0.Branch,1);
PerMax=10;%% �����ڵ�����ٷֱ�
TESTMAX=20;%�������

MaxScale0=N;
SumLoad0=-sum(Power0(Power0<0));
NodeBet0 = getNodeBet(Net0);
Efficiency0=getNetEfficiency(Net0);
NetAbi0=getNetAbility(Net0);
NetEffRes0=getNetEffRes(Net0);

RemNum1=fix(PerMax*N/100)+1;
RemNum2=fix(PerMax*L/100)+1;
ATK = struct('name',{'����ڵ㹥��','�ڵ�ȹ���','�ڵ�����ȹ���','��ͳ�ڵ��������','�ڵ������������',...
    '�����·����','��·�ȹ���','��ͳ�ڵ��������','��·������������'},...%������ʽ���ƣ�����Ŀ�꣨Target��
    'MaxScale',[repmat({zeros(RemNum1,1)},1,5),repmat({zeros(RemNum2,1)},1,4)],...%����Ӽ���ģ
    'LossLoad',[repmat({zeros(RemNum1,1)},1,5),repmat({zeros(RemNum2,1)},1,4)],...%���ʧ����
    'Efficiency',[repmat({zeros(RemNum1,1)},1,5),repmat({zeros(RemNum2,1)},1,4)],...%����Ч��
    'NetAbi',[repmat({zeros(RemNum1,1)},1,5),repmat({zeros(RemNum2,1)},1,4)],...%���紫������
    'NetEffRes',[repmat({zeros(RemNum1,1)},1,5),repmat({zeros(RemNum2,1)},1,4)]);%����������Ч�迹��Ч��
%% ��̬����
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
        %% ��������,״̬������ʼ��       
        CurNet=Net0;
        for AttackNum=1:RemNum
            %% ����������������ָ��ֵ           
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


%% ��ͼ
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
title('IEEE-118�ڵ��ƻ�','FontWeight','bold','FontSize',14);
xlabel('�ڵ��ƻ�(%)','FontWeight','bold','FontSize',14);
ylabel('�����ͨ�Ӽ���ģ','FontWeight','bold','FontSize',14);
axis([0,PerMax,0,100]);
legend('����ڵ㹥��','�ڵ�ȹ���','�ڵ�����ȹ���','��ͳ�ڵ��������','�ڵ������������');

subplot(1,2,2);
plot(Per,(1-cell2mat({ATK(AtkMode).Efficiency})/Efficiency0)*100);
title('IEEE-118�ڵ��ƻ�','FontWeight','bold','FontSize',14);
xlabel('�ڵ��ƻ�(%)','FontWeight','bold','FontSize',14);
ylabel('����ƽ��Ч��','FontWeight','bold','FontSize',14);
axis([0,PerMax,0,100]);
legend('����ڵ㹥��','�ڵ�ȹ���','�ڵ�����ȹ���','��ͳ�ڵ��������','�ڵ������������');

figure2=figure('Color',[1 1 1]);
subplot(1,2,1);
plot(Per,cell2mat({ATK(AtkMode).LossLoad})/SumLoad0*100);
title('IEEE-118�ڵ��ƻ�','FontWeight','bold','FontSize',14);
xlabel('�ڵ��ƻ�(%)','FontWeight','bold','FontSize',14);
ylabel('������������','FontWeight','bold','FontSize',14);
axis([0,PerMax,0,100]);
legend('����ڵ㹥��','�ڵ�ȹ���','�ڵ�����ȹ���','��ͳ�ڵ��������','�ڵ������������');

subplot(1,2,2);
plot(Per,(1-cell2mat({ATK(AtkMode).NetAbi})/NetAbi0)*100);
title('IEEE-118�ڵ��ƻ�','FontWeight','bold','FontSize',14);
xlabel('�ڵ��ƻ�(%)','FontWeight','bold','FontSize',14);
ylabel('������������','FontWeight','bold','FontSize',14);
legend('����ڵ㹥��','�ڵ�ȹ���','�ڵ�����ȹ���','��ͳ�ڵ��������','�ڵ������������');

axis([0,PerMax,0,100]);

toc



