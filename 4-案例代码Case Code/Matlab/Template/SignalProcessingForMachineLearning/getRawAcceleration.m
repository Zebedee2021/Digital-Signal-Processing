function [acc, actid, actnames, t, fs] = getRawAcceleration(varargin) %#ok<STOUT>
% getRawAcceleration helps retrive acceleration data from relevant file
% Input arguments need to be Name,Value pairs. Acceptable names are
% - SubjectID: Subject ID, rangnig from 1 to 30
% - AccelerationType: Acceleration type, as a choice between 'total' and
% 'body' (with gravity contributions filtered out)
% - Component: Coordinate name, as a choice between 'x', 'y', or 'z'
% 
% Copyright 2014-2015 The MathWorks, Inc.

% getRawAcceleration帮助从相关文件中检索加速度数据
% 输入参数必须是Name，Value对。可接受的名称为
% -主题ID：主题ID，等级从1到30
% -加速度类型：加速度类型，在"总”和
% "身体”（过滤掉重力贡献）
% -组件：坐标名称，可在"x”、“y”或“z”之间选择

% Create: subjects, fs, actlabels
load('RecordedAccelerationsBySubject.mat')

p = inputParser;

defaultAccelerationType = 'total';
validAccelerationTypes = {'total','body'};
checkAccelerationType = @(x) any(validatestring(x,validAccelerationTypes));

defaultSubject = 1;

defaultComponent = 'x';
validComponents = {'x','y','z'};
checkComponent = @(x) any(validatestring(x,validComponents));

addParameter (p,'SubjectID',defaultSubject,@(x) x > 0 && x <= length(subjects));
addParameter (p,'AccelerationType',defaultAccelerationType,checkAccelerationType)
addParameter (p,'Component',defaultComponent,checkComponent)

parse(p,varargin{:})

subid = p.Results.SubjectID;
switch p.Results.AccelerationType
    case 'total', type = 'totalacc';
    case 'body', type = 'bodyacc';
end
switch p.Results.Component
    case 'x', component = 1;
    case 'y', component = 2;
    case 'z', component = 3;
end
        
acc = subjects(subid).(type)(:,component);
actid = subjects(subid).actid;
t = (1/fs) * (0:length(acc)-1)';