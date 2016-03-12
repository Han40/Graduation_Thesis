function [] = CreateCascFigure(Value,Para)

%% »æÍ¼²ÎÊý
if strcmp(Para{2},'lower')
    Beta=0:0.1:0.5;
elseif strcmp(Para{2},'higher')
    Beta=0.6:0.1:1;
end
color=[0.749019622802734 0.749019622802734 0;
       0.749019622802734 0 0.749019622802734;
       0 0.749019622802734 0.749019622802734;
       1 0 0;
       0 1 0;
       0 0 1];
shape={'*','p','o','d','s','h','<','>','^','v','.','+'};
figure1 = figure('Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1,...
    'FontSize',10);
%% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 100]);
%% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0 1]);
box(axes1,'on');
hold(axes1,'all');
plot1 = plot(Value(:,1),Value(:,2:end),'Parent',axes1,'LineWidth',2);
axis([0,Para{3},0,100]);

for i=1:2*length(Beta)
    ind=mod(i-1,length(Beta))+1;
    if i<6
        ModelName='RL';
    else
        ModelName='HL';
    end
    set(plot1(i),'Color',color(ind,:),...
    'Marker',shape{i},'MarkerSize',6,'DisplayName',[ModelName ': \beta=' num2str(Beta(ind))]);
end
xlabel('\alpha');
ylabel(Para{1});
legend1 = legend(axes1,'show');
%legend('boxoff');
set(legend1,...
    'Position',[0.733370751892945 0.249810441785071 0.140715795034337 0.157615309723743]);
grid on;

