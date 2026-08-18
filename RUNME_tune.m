% This script is a toplevel script that executes the users desired example case:

addpath('./Exec_Scripts/');
u_choice = 3;%input(sprintf('Specify the desired example case to run:\n\t(1) Sinusoidal Timeseries\n\t(2) Hover to Transition Timeseries\n\t(3) Cruise Climbing Turn Timeseries\n\t(4) Ramp demo\n\t(5) Piecewise Bezier Trajectory\nUser Input: '));

% L1_LPF_bw = 7 .* ones(6,1); % in rad/s [long1bw, long2bw, long3bw,lat1bw,lat2bw,lat3bw]
% As_lat = -90;
% As_lon = -90;
switch u_choice
    case 1
        exam_TS_Sinusoidal_traj;
    case 2
        exam_TS_Hover2Cruise_traj
    case 3
        exam_TS_Cruise_Climb_Turn_traj
    case 4
        exam_RAMP
    case 5 
        if ~exist("userStruct",'var')
            addpath('./Bez_Functions/');
        end
        exam_Bezier;
    otherwise
        fprintf('User needs to supply selection choice (1-5)\n')
        return
end

% Execute the model
sim(model);
% Create sample output plots
simPlots_GUAM;

% Add some error metrics
if SimIn.refInputType == RefInputEnum.TIMESERIES
    pos_des     = SimOut.RefInputs.pos_des.Data;
    vel_des     = SimIn.RefInputs.trajectory.vel_des; % NED frame?
    t_des       = SimIn.RefInputs.trajectory.refTime;
else
    pos_des     = SimOut.RefInputs.pos_des.Data;
    % Compute inertial velocity from heading frame velocity and desired heading
    q           = QrotZ(-SimOut.RefInputs.chi_des.Data);
    vel_des     = Qtrans(q,SimOut.RefInputs.Vel_bIc_des.Data);
    t_des       = time;
end

pos = squeeze(SimOut.Vehicle.EOM.InertialData.Pos_bii.Data);

% Calculate the error metrics for position
pos_error = pos - pos_des;
pos_error_rms = sqrt(mean(pos_error.^2, 1));
fprintf("Position errors:\n")
fprintf("\tX-position error: %.4f\n", pos_error_rms(:,1))
fprintf("\tY-position error: %.4f\n", pos_error_rms(:,2))
fprintf("\tZ-position error: %.4f\n", pos_error_rms(:,3))