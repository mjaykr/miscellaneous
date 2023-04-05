% Load experimental load-displacement data
filename = 'your_load_displacement_data.txt';
data = dlmread(filename);
load_data = data(:, 1);
displacement_data = data(:, 2);

% Constants
indenter_area_coefficient = 24.5;

% Convert load-displacement data to stress-strain data using Oliver and Pharr method
[stress, strain, hc] = oliver_pharr(load_data, displacement_data, indenter_area_coefficient);

% Fit linear elastic region
elastic_region = 0.002; % Change this value to the appropriate strain value for the linear region
yield_index = find(strain >= elastic_region, 1);
E = stress(yield_index) / strain(yield_index);

% Fit power-law hardening
K = stress(yield_index);
N = 0.1; % Initial guess for N
power_law_fun = @(N, strain) K * strain.^N;
options = optimoptions('lsqcurvefit', 'Algorithm', 'trust-region-reflective');
N_fitted = lsqcurvefit(power_law_fun, N, strain(yield_index:end), stress(yield_index:end), [], [], options);

% Compute stress-strain curve using the elastic-plastic model
elastic_stress = E * strain(1:yield_index);
plastic_stress = power_law_fun(N_fitted, strain(yield_index:end));
model_stress = [elastic_stress; plastic_stress];

% Plot experimental and model stress-strain curves
figure;
plot(strain, stress, 'o', strain, model_stress, '-');
xlabel('Strain');
ylabel('Stress');
legend('Experimental', 'Elastic-Plastic Model');
title('Stress-Strain Curve and Elastic-Plastic Model Fit');
grid on;

function [stress, strain, hc] = oliver_pharr(load_data, displacement_data, indenter_area_coefficient)
    % Calculate maximum displacement (hm) and maximum load (Pmax)
    hm = max(displacement_data);
    Pmax = max(load_data);

    % Calculate contact depth (hc) using Oliver and Pharr method
    hc = hm - Pmax / S;

    % Calculate contact area (A)
    A = indenter_area_coefficient * hc^2;

    % Calculate stress and strain for each data point
    stress = load_data ./ A;
    strain = displacement_data / hm;
end
