clc;clear all;
load case118.mat;
load StaticData.mat;
global N;
global Power0;
N=118;
L=179;
MaxScale0=N;
SumLoad0=-sum(Power0(Power0<0));
Efficiency0=getNetEfficiency(Net0);
NetAbi0=getNetAbility(Net0);


AtkMode=6:9;
RemNum=36;
name={'�ڵ��ƻ�'};
Per=((1:RemNum)-1)'/L*100;
figure1=figure('Color',[1 1 1]);
subplot(1,2,1);
plot(Per,(1-cell2mat({ATK(AtkMode).MaxScale})/MaxScale0)*100);
title(['IEEE-118 ' name{1} '������Ӽ���ģ�½�����']);

subplot(1,2,2);
plot(Per,(1-cell2mat({ATK(AtkMode).Efficiency})/Efficiency0)*100);
title(['IEEE-118 ' name{1} '������ƽ���½�����']);

figure2=figure('Color',[1 1 1]);
subplot(1,2,1);
plot(Per,cell2mat({ATK(AtkMode).LossLoad})/SumLoad0*100);
title(['IEEE-118 ' name{1} '�����������½�����']);

subplot(1,2,2);
plot(Per,(1-cell2mat({ATK(AtkMode).NetAbi})/NetAbi0)*100);
title(['IEEE-118 ' name{1} '���������������½�����']);
toc









