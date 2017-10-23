function createfigure_3lines_case1(X1, Y1, X2, Y2, X3, Y3)
%CREATEFIGURE1(X1, Y1, X2, Y2, X3, Y3)
%  X1:  vector of x data
%  Y1:  vector of y data
%  X2:  vector of x data
%  Y2:  vector of y data
%  X3:  vector of x data
%  Y3:  vector of y data

%  Auto-generated by MATLAB on 22-Oct-2017 15:09:21

% Create figure
figure1 = figure('Color',[1 1 1], 'Position', [0 0 360 500], 'xlim', 'ON');

% Create axes
axes1 = axes('Parent',figure1);
axis([0.2 0.7 0 120]);
hold(axes1,'on');

% Create plot
plot(X1,Y1,'DisplayName','LDF','MarkerSize',12,'Marker','o','LineWidth',2.5,...
    'Color',[0 0 1]);

% Create plot
plot(X2,Y2,'DisplayName','DB-DP','MarkerSize',12,'Marker','square',...
    'LineWidth',2.5,...
    'Color',[1 0 1]);

% Create plot
plot(X3,Y3,'DisplayName','FCSMA','MarkerSize',12,'Marker','^',...
    'LineWidth',2.5,...
    'Color',[0 1 0]);

% Create xlabel
xlabel({'Arrival rate \lambda^*'},'FontSize',18,'FontName','Helvetica Neue');

% Create title
title({''});

% Create ylabel
ylabel({'Time-Average Delivery Debt'},'FontSize',18,'FontName','Helvetica Neue');

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 0.9]);
box(axes1,'on');
grid(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',17,'LineWidth',2);
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.240714285714285 0.742857142857143 0.178571428571429 0.158333333333333],...
    'FontSize',17,...
    'FontName','Helvetica Neue');
