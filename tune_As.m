N = 20;
As_values = -logspace(1.95, 2.62, N); % Can't go above -460 here
rms_vals = zeros(N,3);

% currently at -315 for long, -310 for lat, filter was at 2

for ind = 1:N
    As = As_values(ind);
    % As_lat = -90;
    % As_lon = -350;
    As_lat = As;
    As_lon = As;
    RUNME_tune;

    rms_vals(ind, 1) = pos_error_rms(:,1);
    rms_vals(ind, 2) = pos_error_rms(:,2);
    rms_vals(ind, 3) = pos_error_rms(:,3);
    close all
end
plot_inds = rms_vals >0;
semilogx(As_values(1:18), rms_vals(1:18,:))
xlabel('As value')
ylabel("RMS error")
legend('X Error', 'Y Error', 'Z Error', 'Location','best')
title('Positional RMS Error vs Adaptation Gains')
subtitle('0.01 Scale on Angular Rate')