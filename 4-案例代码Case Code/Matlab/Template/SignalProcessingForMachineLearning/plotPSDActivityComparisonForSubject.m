function plotPSDActivityComparisonForSubject(subject, act1name, act2name)
% plotPSDActivityComparisonForSubject Compare PSD of two activities
% Compare Power Spectral Density of activities labeled act1name and
% act2name for given subject ID
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
for k = 1:length(id) % length(id) = 2
    % Select portions of signal relevant to current activity
    sel = (actid == id(k));
    % Number all connected 1-D regions in selection (using helper function)
    reglabs = bwlabels1(sel);

    % Consider only one region to avoid combining inhomogeneous spectra
    sel = (reglabs == 1);
    d = ab(sel,:)';
    
    % Compute PSD
    [psd,fp] =  pwelch(d,[],[],[],fs);
    
    % Plot
    hp = plot(fp, db(psd),'-','Color',cmap(id(k),:));
    hp.LineWidth = 1.5;
    
    % Hold plot open so more lines can be added
    hold on
end

% Seal and customize plot appearance
hold off
grid on
set(gca,'Xlim',[0 10])
xlabel('Frequency (Hz)')
ylabel('Power/frequency (dB/Hz)')
title('Power Spectral Density Comparison')

addActivityLegend(id)
