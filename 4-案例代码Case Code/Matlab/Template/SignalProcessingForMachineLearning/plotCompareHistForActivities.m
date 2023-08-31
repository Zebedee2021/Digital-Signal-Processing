function plotCompareHistForActivities(acc, actid, actname1, actname2)
% plotCompareHistForActivities Compare histograms of activity pairs
% Extract from vector acc only samples relevant to activity named in
% actname1 and actname2, respectively; Compute histograms for each of the
% two groups of samples and plot the two histograms in the same figure.
% Use MATLAB function histogram.
% 
% Copyright 2014-2015 The MathWorks, Inc.

% Customized histogram for activity #1
subplot(211)
plotHistogram(acc, actid, actname1);

% Customized histogram for activity #1
subplot(212)
plotHistogram(acc, actid, actname2);

% Helper function
function [ha, datasel] = plotHistogram(data, id, actstr)

% Get all activity labels
s = load('BufferedAccelerations.mat','actnames');
actlabels = s.actnames;
% Identify ID of activity in actstr
actid = find(strcmp(actlabels,actstr));
% Select only relevant data samples
sel = (id == actid);
datasel = data(sel);

% Plot histogram with predefine binwidth
h = histogram(datasel,'BinWidth',0.5); 

% Customizations - colouring and labeling
nacts = length(actlabels);

cmap = colormap(lines(nacts));
col = cmap(actid,:);

h.EdgeColor = col;
h.FaceColor = col;
h.FaceAlpha = 0.8;

xlabel('Acceleration Values (m \cdot s^{-2})')
ylabel('Occurencies')
xlim([min(data), max(data)])

addActivityLegend(actid)

ha = h.Parent;

