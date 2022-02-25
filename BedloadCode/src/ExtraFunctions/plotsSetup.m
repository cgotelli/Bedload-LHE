% Color palettes taken from here:
% https://github.com/OrdnanceSurvey/GeoDataViz-Toolkit/blob/master/Colours/GDV%20colour%20palettes%200.7.pdf


% Divergent colors
d1 = '#045275';
d2 = '#089099';
d3 = '#7CCBA2';
d4 = '#FCDE9C';
d5 = '#F0746E';
d6 = '#DC3977';
d7 = '#7C1D6F';

e1 = '#009392';
e2 = '#39B185';
e3 = '#9CCB86';
e4 = '#E9E29C';
e5 = '#EEB479';
e6 = '#E88471';
e7 = '#CF597E';

% Qualitative colors
q1 = '#FF1F5B';
q2 = '#00CD6C';
q3 = '#009ADE';
q4 = '#AF58BA';
q5 = '#FFC61E';
q6 = '#F28522';
q7 = '#A6761D';


set(0,'defaultFigurePosition',[100 500 1500 200]);

set(groot,'defaultTextFontName','CMU Serif'); % 'CMU Serif'
set(groot,'defaultAxesFontName','CMU Serif');
set(groot,'defaultTextInterpreter','Latex');  % write using Latex commands
set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');

% GRL = 8 pt minimum for figures
set(groot,'defaultTextFontSize', 12);
set(groot,'defaultAxesFontSize', 12);

set(groot,'defaultLineLineWidth', 1.5);    % curve width
set(groot,'defaultAxesLineWidth', 0.5);     % axes width
set(groot,'DefaultAxesLayer','top');        % axes above curve

set(groot,'defaultLineMarkerSize', 5);
set(groot,'defaultLineMarkerEdgeColor', 'k');
set(groot,'defaultLineMarkerFaceColor', '#cccccc');



