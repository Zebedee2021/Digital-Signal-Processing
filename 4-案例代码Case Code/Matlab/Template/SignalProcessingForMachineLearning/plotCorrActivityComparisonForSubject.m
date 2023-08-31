function plotCorrActivityComparisonForSubject(subject, act1name, act2name)
% plotCorrActivityComparisonForSubject Compare autocorrelation of two activities
% Compare Autocorrelation of activities labeled act1name and act2name for
% given subject ID
% 
% Copyright 2014-2015 The MathWorks, Inc.

% Read data from file: x component of total acceleration for subject
[acc, actid, ~, ~, fs] = getRawAcceleration('SubjectID',subject);

% Remove gravitational contributions
fhp = hpfilter;
ab = filter(fhp,acc);

% Get all activity labels
s = load('BufferedAccelerations.mat','actnames');
actlabels = s.actnames;
% Identify ID of activity in act1name and act2name
id(1) = find(strcmp(actlabels,act1name));
id(2) = find(strcmp(actlabels,act2name));

% Create activity-specific colors (will only use the relevant two)
cmap = colormap(lines(6));

% Cycle through two activities
for k = 1:length(id)
    % Select portions of signal relevant to current activity
    sel = (actid == id(k));
    % Number all connected 1-D regions in selection (using helper function)
    reglabs = bwlabels1(sel);
    
    % Consider only one region to avoid combining inhomogeneous information
    sel = (reglabs == 1);
    d = ab(sel,:)';

    % Compute autocorrelation using xcorr with a single input signal
    [c,lags] =  xcorr(d);
    % Derive time lag vector
    tc = (1/fs)*lags;

    % Plot
    hp = plot(tc,c,'.-','Color',cmap(id(k),:));
    hp.LineWidth = 1.5;
    
    % Hold plot open so more lines can be added
    hold on
end

hold off
grid on
set(gca,'Xlim',[-5 5])
title('Autocorrrelation Comparison')
xlabel('Time lag (s)')
ylabel('Correlation')

addActivityLegend(id)
