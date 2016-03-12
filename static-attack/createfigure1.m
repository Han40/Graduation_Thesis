function createfigure1(X1, YMatrix1, YMatrix2)
%CREATEFIGURE1(X1, YMATRIX1, YMATRIX2)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data
%  YMATRIX2:  matrix of y data

%  Auto-generated by MATLAB on 13-Jan-2016 23:56:26

% Create figure
figure1 = figure('Color',[1 1 1]);

% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.13 0.11 0.334659090909091 0.815]);
%% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 20]);
%% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0 100]);
box(axes1,'on');
hold(axes1,'all');

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'Parent',axes1,'LineWidth',3);
set(plot1(1),'Marker','o','DisplayName','�����·����');
set(plot1(2),'MarkerSize',8,'Marker','+','DisplayName','��ͳ��·��������');
set(plot1(3),'Marker','^','DisplayName','��·������������');

% Create title
title('IEEE-118��·�ƻ�');

% Create xlabel
xlabel('��·�ƻ���������(%)','FontWeight','bold','FontSize',14);

% Create ylabel
ylabel('�������������½�����','FontWeight','demi','FontSize',14);

% Create axes
axes2 = axes('Parent',figure1,...
    'Position',[0.570340909090909 0.11 0.334659090909091 0.815]);
%% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes2,[0 20]);
%% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes2,[0 100]);
box(axes2,'on');
hold(axes2,'all');

% Create multiple lines using matrix input to plot
plot2 = plot(X1,YMatrix2,'Parent',axes2,'LineWidth',3);
set(plot2(1),'Marker','o','DisplayName','����ڵ㹥��');
set(plot2(2),'Marker','+','DisplayName','��ͳ��·��������');
set(plot2(3),'Marker','^','DisplayName','��·������������');

% Create title
title('IEEE-118��·�ƻ�');

% Create xlabel
xlabel('��·�����ƻ�(%)','FontWeight','bold','FontSize',14);

% Create ylabel
ylabel('�������������½�����','FontWeight','bold','FontSize',14);

% Create legend
legend1 = legend(axes1,'show');
set(legend1,'YColor',[1 1 1],'XColor',[1 1 1],...
    'Position',[0.133072916666667 0.787931109081101 0.1703125 0.12272490899636],...
    'FontWeight','bold',...
    'FontSize',14);

% Create legend
legend2 = legend(axes2,'show');
set(legend2,'YColor',[1 1 1],'XColor',[1 1 1],...
    'Position',[0.577604166666669 0.786361250368386 0.1703125 0.12272490899636],...
    'FontWeight','bold',...
    'FontSize',14);
