%RUNME MEG 
%
% MEG Full-field flicker experiment (steady state)
% ------
%   Run time per experiment = XX s
%   XX s (XX-s countdown + XX s)   
%   XX cycles at XX s each

%% Clear
% clear all; close all;



% initialize stim tracker for MEG
PTBInitStimTracker;
global PTBTriggerLength 
PTBTriggerLength = 0.001;
% debug mode
%   PsychDebugWindowConfiguration


%% Calibration
% cal = 'CBI_NYU_projector';
cal = 'meg_lcd';
% cal = '3T2_projector_2010_09_01';
d   = loadDisplayParams(cal);
hz  = FrameRate(d.screenNumber);
tr  = 1/hz*60;



% Default parameters
params = retCreateDefaultGUIParams;


%% Full field ONOFF
% params.modality         = 'MEG'; 
% params.prescanDuration  = 0;
% params.interleaves      = NaN;
% params.tr               = 1/hz*60;
% params.calibration      = cal;
% params.framePeriod      = tr;
% params.startScan        = 0;
% params.motionSteps      = 2;
% params.tempFreq         = 6/tr;
% params.repetitions      = 1;
% params.experiment       = 'full-field, on-off';
% params.period           = 12*params.tr;
% params.numCycles        = 6;
% params.loadMatrix       = 'MEG_OnOFF_balanced.mat';

%% Hemifield and ONOFF mixture
params.modality         = 'MEG'; 
params.prescanDuration  = 0;
params.interleaves      = NaN;
params.tr               = 1/hz*60;
params.calibration      = cal;
params.framePeriod      = tr;
params.startScan        = 0;
params.motionSteps      = 2;
params.tempFreq         = 6/tr;
params.repetitions      = 1;
params.experiment       = 'Experiment From File';
params.period           = 12*params.tr;
<<<<<<< HEAD
params.numCycles        = 1;
=======
params.numCycles        = 6;
params.loadMatrix       = 'MEG_OnOff_LeftRight1.mat';




%% mixture of full-field and half field
>>>>>>> 5df7966cc733d6bf844f4474bcda500ebc2b1d1d




%% ********************
%  ***** GO ***********
%  *********************
params.loadMatrix = 'onOffLeftRight_params1.mat';
P = ret(params);

params.loadMatrix = 'onOffLeftRight_params2.mat';
P = ret(params);

params.loadMatrix = 'onOffLeftRight_params3.mat';
P = ret(params);

%% Check timing results
f = dir('~/Desktop/2014*.mat');
load(fullfile('~', 'Desktop', f(end).name));
figure(101); clf

% desired inter-stimulus duration
plot(diff(stimulus.seqtiming));

% measured inter-stimulus duration
hold on; plot(diff(response.flip), 'r-'); 

ylim(median(diff(response.flip)) + [-.001 .001])
% frames between stimuli
frames = round(diff(response.flip) / (1/60)); 

% how many interstimulus frames differed from the median?
disp(sum(frames ~= median(frames)))