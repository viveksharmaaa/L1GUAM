N = 11;
omega_values = linspace(1, pi*11, N); % Can't go above -460 here
rms_vals = zeros(N,3);

% currently at -315 for long, -310 for lat, filter was at 2

for ind = 1:N
    As = As_values(ind);
    As_lat = -350;
    As_lon = -90;
    L1_LPF_bw = omega_values(ind) .* ones(6,1); % in rad/s [long1bw, long2bw, long3bw,lat1bw,lat2bw,lat3bw]
    RUNME_tune;

    rms_vals(ind, 1) = pos_error_rms(:,1);
    rms_vals(ind, 2) = pos_error_rms(:,2);
    rms_vals(ind, 3) = pos_error_rms(:,3);
    close all
end
plot_inds = rms_vals >0;
plot(omega_values(:), rms_vals(:,:))
xlabel('Omega value')
ylabel("RMS error")
legend('X Error', 'Y Error', 'Z Error', 'Location','best')
title('Positional RMS Error vs Adaptation Gains')
subtitle('0.01 Scale on Angular Rate')