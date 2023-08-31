function extractAllFeatures
% extractAllFeatures Extract features from pre-saved buffered signals
% 
% Copyright 2014-2015 The MathWorks, Inc.

% Load pre-buffered acceleration data
s = load('BufferedAccelerations.mat','atx','aty','atz','fs');
fs = s.fs;
x = s.atx;
y = s.aty;
z = s.atz;
clear s

% Expect as many rows of features as number of available data buffers
newf = zeros(size(x,1),66); %#ok<*NODEF>

tstart = tic;

% Use of parfor instead of simple for will use all available workers in
% the local parallel pool (requires Parallel Computing Toolbox)
parfor n = 1:size(x,1)
    % Extract features for current data buffers
    newf(n,:) = featuresFromBuffer(x(n,:), y(n,:), z(n,:), fs); 
    fprintf('Buffer #%g\n',n)
end

disp('Done!')
fprintf('Total time elapsed: %g seconds\n', toc(tstart))

% Save extracted features to a data file
X = newf;
feat = X; %#ok<*NASGU>
featlabels = getFeatureNames;

save('BufferFeaturesNew.mat','feat','featlabels')


function featureNames = getFeatureNames

featureNames(1,1) = {'TotalAccXMean'};
featureNames(2,1) = {'TotalAccYMean'};
featureNames(3,1) = {'TotalAccZMean'};
featureNames(4,1) = {'BodyAccXRMS'};
featureNames(5,1) = {'BodyAccYRMS'};
featureNames(6,1) = {'BodyAccZRMS'};
featureNames(7,1) = {'BodyAccXCovZeroValue'};
featureNames(8,1) = {'BodyAccXCovFirstPos'};
featureNames(9,1) = {'BodyAccXCovFirstValue'};
featureNames(10,1) = {'BodyAccYCovZeroValue'};
featureNames(11,1) = {'BodyAccYCovFirstPos'};
featureNames(12,1) = {'BodyAccYCovFirstValue'};
featureNames(13,1) = {'BodyAccZCovZeroValue'};
featureNames(14,1) = {'BodyAccZCovFirstPos'};
featureNames(15,1) = {'BodyAccZCovFirstValue'};
featureNames(16,1) = {'BodyAccXSpectPos1'};
featureNames(17,1) = {'BodyAccXSpectPos2'};
featureNames(18,1) = {'BodyAccXSpectPos3'};
featureNames(19,1) = {'BodyAccXSpectPos4'};
featureNames(20,1) = {'BodyAccXSpectPos5'};
featureNames(21,1) = {'BodyAccXSpectPos6'};
featureNames(22,1) = {'BodyAccXSpectVal1'};
featureNames(23,1) = {'BodyAccXSpectVal2'};
featureNames(24,1) = {'BodyAccXSpectVal3'};
featureNames(25,1) = {'BodyAccXSpectVal4'};
featureNames(26,1) = {'BodyAccXSpectVal5'};
featureNames(27,1) = {'BodyAccXSpectVal6'};
featureNames(28,1) = {'BodyAccYSpectPos1'};
featureNames(29,1) = {'BodyAccYSpectPos2'};
featureNames(30,1) = {'BodyAccYSpectPos3'};
featureNames(31,1) = {'BodyAccYSpectPos4'};
featureNames(32,1) = {'BodyAccYSpectPos5'};
featureNames(33,1) = {'BodyAccYSpectPos6'};
featureNames(34,1) = {'BodyAccYSpectVal1'};
featureNames(35,1) = {'BodyAccYSpectVal2'};
featureNames(36,1) = {'BodyAccYSpectVal3'};
featureNames(37,1) = {'BodyAccYSpectVal4'};
featureNames(38,1) = {'BodyAccYSpectVal5'};
featureNames(39,1) = {'BodyAccYSpectVal6'};
featureNames(40,1) = {'BodyAccZSpectPos1'};
featureNames(41,1) = {'BodyAccZSpectPos2'};
featureNames(42,1) = {'BodyAccZSpectPos3'};
featureNames(43,1) = {'BodyAccZSpectPos4'};
featureNames(44,1) = {'BodyAccZSpectPos5'};
featureNames(45,1) = {'BodyAccZSpectPos6'};
featureNames(46,1) = {'BodyAccZSpectVal1'};
featureNames(47,1) = {'BodyAccZSpectVal2'};
featureNames(48,1) = {'BodyAccZSpectVal3'};
featureNames(49,1) = {'BodyAccZSpectVal4'};
featureNames(50,1) = {'BodyAccZSpectVal5'};
featureNames(51,1) = {'BodyAccZSpectVal6'};
featureNames(52,1) = {'BodyAccXPowerBand1'};
featureNames(53,1) = {'BodyAccXPowerBand2'};
featureNames(54,1) = {'BodyAccXPowerBand3'};
featureNames(55,1) = {'BodyAccXPowerBand4'};
featureNames(56,1) = {'BodyAccXPowerBand5'};
featureNames(57,1) = {'BodyAccYPowerBand1'};
featureNames(58,1) = {'BodyAccYPowerBand2'};
featureNames(59,1) = {'BodyAccYPowerBand3'};
featureNames(60,1) = {'BodyAccYPowerBand4'};
featureNames(61,1) = {'BodyAccYPowerBand5'};
featureNames(62,1) = {'BodyAccZPowerBand1'};
featureNames(63,1) = {'BodyAccZPowerBand2'};
featureNames(64,1) = {'BodyAccZPowerBand3'};
featureNames(65,1) = {'BodyAccZPowerBand4'};
featureNames(66,1) = {'BodyAccZPowerBand5'};
