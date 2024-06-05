% Constants
voltage_kV = 40; % Operating voltage in kV
current_A = 40; % Current in A
target_material = 'Cu'; % Target material

% Parameters for Copper
rho_Cu = 8.96; % Density of Copper in g/cm^3
mu_rho_Cu = 50.3; % Mass attenuation coefficient for Copper at Cu Kα (8.048 keV) in cm^2/g

% Convert keV to energy in Joules (1 eV = 1.60218e-19 Joules)
energy_J = 8.048 * 1.60218e-16; % Energy of Cu Kα in Joules

% Calculate the linear attenuation coefficient (mu) for Copper
mu_Cu = mu_rho_Cu * rho_Cu; % in cm^-1

% Calculate penetration depth (delta) for Copper
penetration_depth_cm = 1 / mu_Cu; % in cm
penetration_depth_m = penetration_depth_cm / 100; % in meters

% Approximate interaction volume (assuming a simple spherical volume)
% V = (4/3) * pi * r^3 where r is the penetration depth
interaction_volume_m3 = (4/3) * pi * (penetration_depth_m)^3;

% Display results
fprintf('Penetration depth in Copper: %.4f cm\n', penetration_depth_cm);
fprintf('Interaction volume in Copper: %.4e m^3\n', interaction_volume_m3);

% For visualization, let's plot the attenuation as a function of depth
depth_cm = linspace(0, 3*penetration_depth_cm, 100); % Depth from 0 to 3 times the penetration depth
attenuation = exp(-mu_Cu * depth_cm); % Exponential decay of intensity

figure;
plot(depth_cm, attenuation, 'LineWidth', 2);
xlabel('Depth in Copper (cm)');
ylabel('Relative Intensity');
title('X-ray Attenuation in Copper');
grid on;
