function hp = plotAccelerationBufferAndPrediction(x,y,z,t, actual, estimated)
% plotAccelerationBufferAndPrediction plot acceleration buffer and predicted activity
% 
% Copyright 2014-2015 The MathWorks, Inc.

g = 9.81;

persistent h
if(isempty(h))
    figure
    h = plot(t', g*[x',y',z'],'LineWidth',1.5);
    xlim([0 t(end)])
    ylim([-2*g 2*g])
    xlabel('Time offset (s)')
    ylabel('Acceleration (m \cdot s^{-2})')
    legend({'a_x','a_y','a_z'})
    grid on   
end

if ishandle(h(1))
    h(1).YData = g*x'; 
    h(2).YData = g*y'; 
    h(3).YData = g*z';

    title(sprintf('Estimated: %s\nActually: %s\n', ...
        estimated,actual))
    drawnow
end

hp = h;

