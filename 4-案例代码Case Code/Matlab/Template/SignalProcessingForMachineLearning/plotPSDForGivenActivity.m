function plotPSDForGivenActivity(activityid)
% plotPSDForGivenActivity Compare PSD of one activitiy across all subjects
% Compare Power Spectral Density of signals coming from the same activity
% across all subjects in the dataset
% 
% Copyright 2014-2015 The MathWorks, Inc.

% Create activity-specific colors (will only use the relevant two)
cmap = colormap(lines(6));

% Design digital filter ones (same filter to be applied across all subjects)
fhp = hpfilter;

for subject = 1:30
    % Read data from file: x component of total acceleration for subject
    [acc, actid, ~, ~, fs] = getRawAcceleration('SubjectID',subject);
    
    % Remove gravitational contributions
    ab = filter(fhp,acc);

    % Select portions of signal relevant to current activity
    sel = (actid == activityid);
    % Number all connected 1-D regions in selection (using helper function)
    reglabs = bwlabels1(sel);

    % Consider only one region to avoid combining inhomogeneous spectra
    sel = (reglabs == 1);
    d = ab(sel,:)';

    % Compute PSD
    [psd,fp] =  pwelch(d,[],[],[],fs);
    
    % Add PSD plot for current subject
    hp = plot3(fp,subject*ones(size(fp)), (psd),...
        '-','Color',cmap(activityid,:));
    hp.LineWidth = 1.5;
    
    % Hold plot open so more lines can be added
    hold on
end

% Seal and customize plot appearance
hold off
grid on
set(gca,'Xlim',[0 10])
xlabel('Frequency (Hz)')
ylabel('Subject ID')

addActivityLegend(activityid)

