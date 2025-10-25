% ==============================
% Define known data
% ==============================
% Example: you must already have these vectors in workspace
% time_100, voltage_100, time_95, voltage_95, ..., time_80, voltage_80
% Put them in a cell array for easier looping
time_all = {time_100, time_95, time_90, time_85, time_80};
volt_all = {voltage_100, voltage_95, voltage_90, voltage_85, voltage_80};
soh_levels = [100, 95, 90, 85, 80];
% Initialize feature matrix
X = [
    0.002571   123 ;   % SOH 100%
    0.002678   108 ;   % SOH 95%
    0.002812   100;   % SOH 90%
    0.002902   94 ;   % SOH 85%
    0.003298   81 ];  % SOH 80%
Y = [100; 95; 90; 85; 80];   % SOH labels
% ==============================
% Feature extraction from known profiles
% ==============================
for i = 1:length(soh_levels)
    time = time_all{i};
    voltage = volt_all{i};
    
    % --- Feature 1: Time to reach 4.0 V
    idx_4v = find(voltage >= 4.0, 1);
    if isempty(idx_4v)
        t_4v = max(time);  % fallback
    else
        t_4v = time(idx_4v);
    end
    
    % --- Feature 2: Slope between 3.8 V to 4.0 V
    idx_38 = find(voltage >= 3.8, 1);
    idx_40 = find(voltage >= 4.0, 1);
    
    if isempty(idx_38) || isempty(idx_40) || idx_40 <= idx_38
        continue;
    end
    
    t_seg = time(idx_38:idx_40);
    v_seg = voltage(idx_38:idx_40);
    coeffs = polyfit(t_seg, v_seg, 1);
    slope = coeffs(1);
    
    X = [X; slope, t_4v];
    Y = [Y; soh_levels(i)];
end
% ==============================
% Train ML model (SVR)
% ==============================
mdl = fitrsvm(X, Y, 'KernelFunction', 'rbf', 'Standardize', true);
% ==============================
% Predict SOH for unknown profile
% ==============================
% unknown voltage-time vectors
% (Assumed already in workspace as time_unknown, voltage_unknown)
% --- Feature 1: Time to reach 4.0 V
idx_4v_u = find(voltage_unknown >= 4.0, 1);
if isempty(idx_4v_u)
    t_4v_u = max(time_unknown);
else
    t_4v_u = time_unknown(idx_4v_u);
end
% --- Feature 2: Slope between 3.8 V to 4.0 V
idx_38_u = find(voltage_unknown >= 3.8, 1);
idx_40_u = find(voltage_unknown >= 4.0, 1);
if isempty(idx_38_u) || isempty(idx_40_u) || idx_40_u <= idx_38_u
    error('Cannot extract slope from unknown data.');
end
t_seg_u = time_unknown(idx_38_u:idx_40_u);
v_seg_u = voltage_unknown(idx_38_u:idx_40_u);
coeffs_u = polyfit(t_seg_u, v_seg_u, 1);
slope_u = coeffs_u(1);
% Predict
features_u = [slope_u, t_4v_u];
predicted_soh = predict(mdl, features_u);
fprintf('Predicted SOH of the unknown battery: %.2f%%\n', predicted_soh);