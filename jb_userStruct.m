%% UserStruct Settings
%  The Polynomial model does not cover the entire flight envelope, and
%  asserts an error when it reaches a point outside its domain.  Hence, the
%  SFunction model is chosen here (slower, but contains full flight envelope).
userStruct.variants.fmType = ForceMomentEnum.SFunction;
userStruct.variants.turbType = TurbulenceEnum.Enabled;

%% Turbulence Settings
SimIn.Environment.Turbulence.IntensityLevel = 2; % 1 = off, 2 = light, 3 = moderate, 4 = severe
SimIn.Environment.Turbulence.WindAt5kft = 3; % m/s
SimIn.Environment.Turbulence.WindDirectionAt5kft = 0; % true, deg

%% Wind Settings
% SimIn.Environment.Winds.Gust_wHh = [];
% SimIn.Environment.Winds.Vel_wHh = [];
% SimIn.Environment.Winds.VelDtH_wHh = [];

%%
useL1 = 1;  % >0 for L1 on, 0 for L1 off