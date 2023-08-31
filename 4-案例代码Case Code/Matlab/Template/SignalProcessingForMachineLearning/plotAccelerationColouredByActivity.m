function plotAccelerationColouredByActivity(t, acc, actid, varargin)
% plotAccelerationColouredByActivity Plots acceleration colored by activity
% Can accept an optional last argument: cell arrayof strings to use as
% plot title(s)
% Can accept concatenated column vectors for input acc. Each column is
% displayed in a different subplot
% 
% Copyright 2014-2015 The MathWorks, Inc.

% Distill and count number of activities available
acts = unique(actid);
nacts = max(length(acts),1);

% Plan to draw as many subplots as columns available in acc 
nplots = size(acc,2);

% Define colors to use, using built-in colormap with as many entries as
% the number of available activities
cmap = colormap(lines(nacts));

for kp = 1:nplots
    
    % Iterate through all the signals passed as input
    subplot(nplots,1,kp)
    
    % Iterate over activities
    for ka = 1:nacts
        % First select data relevant to each activity
        [aid, tsel, asel] = getDataForActivityId(ka);
        
        % Then plot each activity with a different color
        plot(tsel, asel, 'Color',cmap(aid,:),'LineWidth',1.5);
        % and keep axis on hold to overlay next plot 
        hold on
    end
    
    % Seal plots on current axis - plotting of current signal finished
    hold off
    
    % Customize axis box for current subplot
    grid on
    xlabel('time (s)')
    ylabel('a_z (m s^{-2})')
    xlim([t(1), t(end)])
    if(length(varargin) >= 1)
        if(iscell(varargin{1}))
            title(varargin{1}{kp})
        elseif(ischar(varargin{1}))
            title(varargin{1})
        end
    end
end

% To minimize visual clutter, only add legend to last plot
addActivityLegend(acts)
    
% Helper nested function to select signal portions relevant to given
% activity
    function [aid, tsel, asel] = getDataForActivityId(ka)
    aid = 1;
    try %#ok<TRYNC>
        aid = acts(ka);
    end
    sel = (actid == aid);
    tsel = t;
    tsel(~sel) = NaN;
    asel = acc(:,kp);
    asel(~sel) = NaN;
    end

end