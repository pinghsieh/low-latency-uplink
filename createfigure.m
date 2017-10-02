function createfigure(X1, YMatrix1, mode, N)
%CREATEFIGURE(X1, YMATRIX1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 15-Sep-2017 10:55:42

% Create figure
figure1 = figure('Color',[1 1 1]);

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'LineWidth',2,'Parent',axes1);
color_vec = {[1 0 0], [0 0 1], [0 1 0], [1 0 1], [1 0.8 0], [0.5 0.5 0], [1 0 0.5], [0 1 0.5], [0 1 1], [1 1 0]};
for i=1:min(N,size(color_vec,2))
set(plot1(i),'Color',color_vec{i});
set(plot1(i),'DisplayName', strcat('Link ', num2str(i)));
end

% Create xlabel
xlabel({'Frame Number'});

% Create ylabel
switch mode
    case 'throughput'
        ylabel({'Timely-Throughput (packet/frame)'});
    case 'deficit'
        ylabel({'Deficit'});
    otherwise
        ylabel({'Timely-Throughput (packet/frame)'});
end

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',17,'LineWidth',2,'XGrid','on','YGrid','on');

% Create legend
legend(axes1,'show');