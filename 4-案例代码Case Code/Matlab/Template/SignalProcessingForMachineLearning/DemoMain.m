%% Human Activity Classification based on Smartphone Sensor Signals
% 
% Copyright 2014-2015 The MathWorks, Inc.

%% Introduction
% This example describes an analysis approach on accelerometer signals
% captured with a smartphone. The smartphone is worn by a subject during 6
% different types of physical activity. 
% The goal of the analysis is to build an algorithm that automatically
% identifies the activity type given the sensor measurements. 
% 此示例描述了一种对使用智能手机捕获的加速度计信号的分析方法。 
% 受试者在 6 种不同类型的体育活动中佩戴智能手机。 
% 分析的目标是构建一种算法，根据传感器测量值自动识别活动类型。

% The example uses data from a recorded dataset, courtesy of:
%  Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L.
%  Reyes-Ortiz. Human Activity Recognition on Smartphones using a
%  Multiclass Hardware-Friendly Support Vector Machine. International
%  Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz,
%  Spain. Dec 2012
% 该示例使用来自记录数据集的数据，由以下人员提供：
% Davide Anguita、Alessandro Ghio、Luca Oneto、Xavier Parra和Jorge L. Reyes-Ortiz。 
% 使用多类硬件友好支持向量机在智能手机上进行人类活动识别。 
% 环境辅助生活国际研讨会 (IWAAL 2012)。 
% 西班牙维多利亚-加斯泰兹。

% The original dataset is available from
% <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
% 原始数据集可从
% <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

%% Check data availability
% The data need to be prepared prior to running the code in the rest of
% this script.
% To prepare the data run the script DataPreparation.m first. That guides
% through the process of downloading the data and preparing it for this
% example.
% 

% 检查数据可用性
% 在其余部分运行代码之前需要准备数据这个脚本。
% 要准备数据，首先运行脚本 DataPreparation.m
% 那指导通过下载数据并为此准备的过程例子。
%
% 在过程结束时，文件夹 .\Data\Prepared 必须包含
% 以下四个数据文件：
%
% * BufferedAccelerations.mat
% * BufferFeatures.mat
% * RecordedAccelerationsBySubject.mat
% * TrainedNetwork.mat

% 检查准备好的数据是否可用，添加数据文件夹到
% MATLAB 搜索路径

% At the end of the process, the folder .\Data\Prepared must contain
% the following four data files:
% 
% * BufferedAccelerations.mat
% * BufferFeatures.mat
% * RecordedAccelerationsBySubject.mat
% * TrainedNetwork.mat

% Check that the prepared data is available, and add the data folder to
% the MATLAB search path

if ~isAllPreparedDataAvailable
    disp('Some prepared data is not yet available. Please run DataPreparation.m first')
end

%% Objective of the example
% Let's take a look at what our final result may look like. This will give
% us a better feel for what we are trying to achieve.
% For the time being you do not need to understand how this is realized
% 例子的目的
% 让我们来看看我们的最终结果可能是什么样子。 这会给让我们更好地了解我们正在努力实现的目标。
% 暂时不需要了解这是如何实现的

runTrainedNetworkOnBufferedData

%% Open full "recording" for a single subject (e.g. #1)

% Use a custom function to retrieve a single acceleration component for a
% particular subject.

% 打开单个主题的完整“记录”（例如 #1）
% 使用自定义函数检索单个加速度分量特定主题。

[acc, actid, actlabels, t, fs] = getRawAcceleration('SubjectID',1,...
    'Component','x');

plot(t,acc)

%% A more detailed look into the data
% Let's look at the same data, colored based on the activity type.
% Given this data:
% 
% * We would like to be able to tell the difference between the different
%   activities, just based on the content of the signal. 
% * Note in this case the coloring is based on existing knowledge (actid)
% * Labeled data can be used to "train" a classification algorithm so it
%   can it later predict the class of new (unlabeled) data. 

% Visualize the same signal using a custom plotting function, which also
% uses the information in actid

% 更详细地查看数据
% 让我们看一下相同的数据，根据活动类型着色。
% 鉴于此数据：
%
% * 我们希望能够区分不同的活动，仅基于信号的内容。
% * 请注意，在这种情况下，着色是基于现有知识 (actid)
% * 标记数据可用于“训练”分类算法，因此它以后可以预测新（未标记）数据的类别。

% 使用自定义绘图函数可视化相同的信号，这也使用 actid 中的信息

plotAccelerationColouredByActivity(t, acc, actid, {'Vertical acceleration'})

%% First type of characterization - amplitude only
% Looking only at the raw values irrespective or their position is time can
% provide a first set of clues

% 第一类表征 - 仅振幅
% 只看原始值，不管它们的位置是时间
% 提供第一组线索

%% First example - Using a mean measure
% This can easily help separate e.g. Walking from Laying
% 第一个示例 - 使用平均度量
% 这可以很容易地帮助分离"走"从"躺"

figure
plotCompareHistForActivities(acc, actid,'Walking', 'Laying')

%% Second example - Using an RMS or standard deviation measure
% This can help separate things like e.g. Walking and Standing

% 第二个例子 - 使用 RMS 或标准偏差测量
% 这可以帮助分离事物，例如 走路和站立

plotCompareHistForActivities(acc, actid,'Walking', 'Standing')

%% What next? Amplitude-only methods are often not enough
% For example it would be very hard to distinguish between
% simply Walking and WalkingUpstairs (very similar statistical moments)
% 
% An initial conclusion is that simple statistical analysis is often not
% sufficient. 
% For signals one should also consider methods that measure signal
% variations over time

% 接下来是什么？ 仅振幅方法通常是不够的
% 例如很难区分
% 只是 Walking 和 WalkingUpstairs（非常相似的统计时刻）
%
% 一个初步的结论是，简单的统计分析往往不是充足的。
%对于信号，还应该考虑测量信号的方法随时间变化的百分比

plotCompareHistForActivities(acc, actid,'Walking', 'WalkingUpstairs')

%% Time-domain analysis - preliminary considerations
% There two main different types of causes behind our signals: 
% 
% * One to do with "fast" variations over time, due to body
%   dynamics (physical movements of the subject)
% * The other, responsible for "slow" variations over time, due to the
%   position of the body with respect to the vertical gravitational field
%
% As we focus on classifying the physical activities, we should focus
% time-domain analysis on the effects of body movements. These are 
% responsible for the most "rapid" (or frequent) variations in our signal.
% 
% In this specific case a simple average over a period of time would
% easily estimate the gravitational component, which could be then
% subtracted from the relevant samples to obtain the signal due to the
% physical movements.
% 
% For the sake of generality here we introduce an approach based on
% digital filters, which is much more general and can be reused in more
% challenging situations.

% 时域分析——初步考虑
% 我们的信号背后有两种主要不同类型的原因：
%
% * 一个与随着时间的“快速”变化有关，由于身体动态（主体的身体运动）
% * 另一个，负责随着时间的推移“缓慢”变化，由于身体相对于垂直重力场的位置
%
% 当我们专注于对身体活动进行分类时，我们应该关注对身体运动影响的时域分析。 
% 这些都是负责我们信号中最“快速”（或频繁）的变化。
%
% 在这种特定情况下，一段时间内的简单平均值将很容易估计引力分量，然后可以
% 从相关样本中减去以获得由于% 身体运动。
%
% 为了一般性，我们在这里介绍一种基于数字滤波器，它更通用，可以在更多地方重复使用
% 具有挑战性的情况。

%% Digital filtering workflow
% To isolate the rapid signal variations from the slower ones using digital
% filtering:
% 
% * Design a high-pass filter (e.g. using the Filter Design and Analysis
%   Tool, fdatool, in MATLAB)
% * Apply the filter to the original signal
% 数字滤波工作流程
% 使用数字过滤技术将快速信号变化与较慢信号变化隔离开来：
%
% * 设计高通滤波器（例如使用滤波器设计和分析工具，fdatool，在 MATLAB 中）
% * 对原始信号应用滤波器
%% Filter out gravitational acceleration
% As well as interactively, filters can be designed programmatically. 
% In this case the function hpfilter was generated automatically from
% the Filter Design and Analysis Tool, but it could have just as well been
% created manually
% 过滤掉重力加速度
% 除了交互式之外，还可以通过编程方式设计过滤器。
% 在这种情况下，函数 hpfilter 是从
% 滤波器设计和分析工具，但它本来也可以手动创建

% Design filter
fhp = hpfilter;

% "Decouple" acceleration due to body dynamics from gravity
ab = filter(fhp,acc);

% Compare the filtered signal with the original one
plotAccelerationColouredByActivity(t, [acc, ab], actid,...
    {'Original','High-pass filtered'})

%% Focus on a single activity first: select first portion of Walking signal
% Use logical indexing. In plain English, this is what we are trying to do:
% "Only select samples for which the activity was Walking and for which the
% time was less than 250 seconds"

% Assume we know the activity id for Walking is 1

% 首先关注单个活动：选择步行信号的第一部分
% 使用逻辑索引。 用简单的英语来说，这就是我们正在尝试做的事情：
% "只选择活动为步行的样本
% 时间少于 250 秒”

% 假设我们知道步行的活动 ID 是 1

walking = 1;
sel = (t < 250) & (actid == walking);

% Select only desired array segments for time vector
% and acceleration signal
tw = t(sel);
abw = ab(sel);

% Plot walking-only signal segment. Use interactive plot tools to zoom in
% and explore the signal. Note the quasi-periodic behavior.
figure
plotAccelerationColouredByActivity(tw, abw, [],'Walking')

%% Plot Power Spetral Density
% Use Welch method with its default options, using known sample frequency

% When called without output arguments, the function pwelch plots the PSD

% 绘制功率谱密度
% 使用 Welch 方法及其默认选项，使用已知的采样频率
% 在没有输出参数的情况下调用时，函数 pwelch 绘制 PSD

figure
pwelch(abw,[],[],[],fs)

%% Validate potential of PSD to differentiate between different activities
% E.g. are position and height in the two respsctive sets of peaks
% different for different activities?
% 验证 PSD 区分不同活动的潜力
% 例如 是两组响应峰中的位置和高度不同活动的百分比不同？

plotPSDActivityComparisonForSubject(1, 'Walking', 'WalkingUpstairs')

%% Validate consistency of PSD information across different subjects
% Compare Power Spectral Density of walking signals across all subjects in
% the dataset.

% This helper function uses a linear amplitude scale so PSD peaks
% visually stand out better
plotPSDForGivenActivity(walking)

%% Automate peak identification
% The function findpeaks in Signal Processing Toolbox can be used to
% identify amplitude and location of spectral peaks

% Compute numerical values of PSD and frequency vector. When called with
% one or two output arguments, the function pwelch does not automatically
% plot the PSD
[p,f] = pwelch(abw,[],[],[],fs);

% Use findpeaks to identify values (amplitude) and index locations of peaks
[pks,locs] = findpeaks(p);

% Plot PSD manually and overlay peaks
plot(f,db(p),'.-')
grid on
hold on
plot(f(locs),db(pks),'rs')
hold off
addActivityLegend(1)
title('Power Spectral Density with Peaks Estimates')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')

%% Refine peak finding by adding more specific requirements

% PSD with numerical output
[p,f] = pwelch(abw,[],[],[],fs);

% Find max 8 peaks, at least 0.25Hz apart from each other and with a given
% prominence value

fmindist = 0.25;                    % Minimum distance in Hz
N = 2*(length(f)-1);                % Number of FFT points
minpkdist = floor(fmindist/(fs/N)); % Minimum number of frequency bins

[pks,locs] = findpeaks(p,'npeaks',8,'minpeakdistance',minpkdist,...
    'minpeakprominence', 0.15);

% Plot PSD and overlay peaks
plot(f,db(p),'.-')
grid on
hold on
plot(f(locs),db(pks),'rs')
hold off
addActivityLegend(1)
title('Power Spectral Density with Peaks Estimates')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')


%% Autocorrelation as a feature
% Autocorrelation can also be powerful for frequency estimation.
% It is especially effective for estimating low-pitch fundamental
% frequencies

% xcorr with only one input will compute the autocorrelation 
[c, lags] = xcorr(abw);

% Highlight the main t=0 peak (overal energy) and a few secondary peaks
% The position of the second highest peaks identifies the main period
tmindist = 0.3;
minpkdist = floor(tmindist/(1/fs));
[pks,locs] = findpeaks(c,'minpeakprominence',1e4,...
    'minpeakdistance',minpkdist);

% Plot autocorrelation and three key peaks
tc = (1/fs)*lags;
plot(tc,c,'.-')
grid on
hold on
plot(tc(locs),c(locs),'rs')
hold off
xlim([-5,5])
addActivityLegend(1)
title('Autocorrrelation with Peaks Estimates')
xlabel('Time lag (s)')
ylabel('Correlation')

%% Check position of first peak varies between different activities
% Compare autocorrelation plots for same subject and different activity
% By zooming into the secong highest peaks, note how the respective
% second-peak positions are still spaced apart by more than a few samples.

plotCorrActivityComparisonForSubject(1, 'WalkingUpstairs', 'WalkingDownstairs')

%% Feature summary
% After exploring interactively a few different techniques to extract
% descriptive features from this type of signals, we can collect
% all the analysis methods identified into a single function.
% The responsibility of this function is to extract a fixed number
% of features for each signal buffer provided as input.

featureExtractionFcn = 'featuresFromBuffer';

edit(featureExtractionFcn)

%% Count number of actual code lines of function featuresFromBuffer.m
% Using MATLAB Central submission "sloc" by Raymond Norris, available at
% <http://www.mathworks.co.uk/matlabcentral/fileexchange/3900-sloc>

count = sloc(featureExtractionFcn);

fprintf('\n%d lines of source code found in %s.m\n', ...
    count, featureExtractionFcn);

%% Prepare data to train neural network
% To train the network, assume we:
% 
% * Re-organise the acceleration signals into shorter buffers of fixed
%   length L, each labeled with a single activity ID
% * Extract a vector of features for each Lx3 signal buffer [ax, ay, az]
%   using the function featuresFromBuffer 
% * Provide the network with two sets of feature vectors and corresponding
%   activity ID
% 
% The buffered data is already available and stored in
% the file BufferedAccelerations.mat
% 
% Computing the features is a fairly efficient process, but it takes a
% while in this case because of the high number fo signal vectors
% available.
% The pre-computed set of feature vectors for all available signal buffers
% is available in the file BufferFeatures.mat
% To re-compute all features use the function extractAllFeatures, which
% will
% 
% * Read the buffered signals from BufferedAccelerations.mat
% * Compute a feature vector for each buffer using featuresFromBuffer
% * Save all feature vectors into the file BufferFeatures.mat
% 
% extractAllFeatures can distribute the computations to a pool of workers
% if Parallel Computing Toolbox is installed
% 
% Now simply clear all variables that are not relevant anymore, and load
% pre-saved variables

% Clear nonrelevant variables
clear all %#ok<CLSCR>

% Load set of feature vectors (feat) and cell array of feature names
% (featlabels)
load('BufferFeatures.mat')

% Load buffered signals (here only using known activity IDs for buffers)
load('BufferedAccelerations.mat')

%% Train neural network for signal classification

% Reset random number generators
rng default

% Initialize a Neural Network with 18 nodes in hidden layer
% (assume the choice of the number 18 here is arbitrary)
net = patternnet(18);

% Organize features and known activity IDs so they can be consument by the
% train function
% NOTE: for real problems consider partitioning your dataset into training,
% validation and test subsets. This step has been left out here for
% simplicity.
X = feat';
tgtall = dummyvar(actid)';

% Train network
% For details about customizing the training function refer to the
% following:
% web(fullfile(docroot, 'nnet/ug/choose-a-multilayer-neural-network-training-function.html'))
net = train(net, X, tgtall);

%% Run Neural Network on buffered data
% We have now completed all the algorithmic steps necessary to implement
% the classification system presented at the very beginning of this
% example.
% 
% Opening the function runTrainedNetworkOnBufferedData will reveal the same
% code in this script section.
% 
% To use a pre-trained networ use (uncomment) the following line
% load('TrainedNetwork.mat')

% Re-initialize plot
clear plotAccelerationBufferAndPrediction

for k = 1:size(atx,1)
    % Get data - one buffer for each acceleration component
    ax = atx(k,:);
    ay = aty(k,:);
    az = atz(k,:);
    
    % Extract feature vector
    f = featuresFromBuffer(ax, ay, az, fs);
    
    % Classify with neural network
    scores = net(f');
    % Interpret result: use index of maximum score to retrieve the name of
    % the activity
    [~, maxidx] = max(scores);
    estimatedActivity = actnames{maxidx};
    actualActivity = actnames{actid(k)};

    % Plot three signals and display prediction result as title
    h = plotAccelerationBufferAndPrediction(ax,ay,az,t,...
        actualActivity,estimatedActivity);
    
    if ~ishandle(h)
        break
    end
end

%% Validate network more systematically, using a confusion matrix
% In the previous code cell we validated the predictive behavior of our
% trained neural network use a visual and qualitative approach.
% To quantitatively asses the performance of a classification algorithm one
% would normally measure the predictions over a whole test dataset, and
% compare them against the known class values.
% 
% The ultimate prediction performance can be represented visually in a
% number of different ways. Below we present the confusion matrix. The
% confusion matrix is a square matrix that summarizes the cumulative
% prediction results for all couplings between actual and predicted
% classes, respectively.
% 
% Normally it is good practice to use a test set different from the
% training set. This ensures that the results are not biased by the
% particular training dataset used.
%
% Even though we have ignored this principle so far, the Neural Network
% Toolbox includes the function dividerand, which automates most of
% the dataset partition mechanism.

% Randomly partition data between training, test and validation sets
[trainInd,valInd,testInd] = dividerand(size(X,2),0.7,0.15,0.15);
Xval = X(:,testInd);
yval = actid(testInd,:);
tgtval = dummyvar(yval)';

% Run network on validation set. This time predictions for all the
% different feature vectors are all produced and concatenated at once
scoreval = net(Xval);

% Display confusion matrix using prediction results
figure
plotconfusion(tgtval,scoreval)

