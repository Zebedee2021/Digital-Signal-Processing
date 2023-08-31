function allavailable = isAllPreparedDataAvailable()
% isAllPreparedDataAvailable checks if all the data is available
% 
% Copyright 2014-2015 The MathWorks, Inc.

filelist = {'BufferedAccelerations.mat',...
    'BufferFeatures.mat',...
    'RecordedAccelerationsBySubject.mat',...
    'TrainedNetwork.mat'};

fcnpath = mfilename('fullpath');
bs = strfind(fcnpath, '\');
preparedDataPath = fullfile(fcnpath(1:bs(end)-1),'Data','Prepared');

stritemlist = dir(preparedDataPath);
itemlist = {stritemlist.name};

allavailable = true;
for k = 1:length(filelist)
    if(~any(strcmp(filelist{k},itemlist)))
        allavailable = false;
        fprintf('Data file %s not found\n',...
            filelist{k});
    end
end

% Add data folder to path
if allavailable
    addpath(preparedDataPath)
end

