% Load experimental load-displacement data
filename = 'your_load_displacement_data.txt';
data = dlmread(filename);
load_data = data(:, 1);
displacement_data = data(:, 2);

% Constants
indenter_area_coefficient = 24.5;
indenter_tip_radius = 100e-9; % Change this to the actual tip radius of your indenter

% Calculate stiffness (S) using CSM method
S = diff(load_data) ./ diff(displacement_data);

% Calculate contact depth (hc) and contact area (A) using Oliver and Pharr method
hc = displacement_data(1:end-1) - load_data(1:end-1) ./ S;
A = indenter_area_coefficient * hc.^2;

% Calculate hardness (H) and reduced modulus (Er) as a function of depth
hardness = load_data(1:end-1) ./ A;
reduced_modulus = sqrt(pi) * S ./ (2 * sqrt(A));

% Calculate the contact modulus (E) from the reduced modulus (Er)
% E = (1 - v^2) / ((1 - v1^2) / E1 + (1 - v2^2) / E2)
% Assume indenter properties (E1, v1) and sample properties (E, v)
E1 = 1141e9; % Diamond indenter elastic modulus
v1 = 0.07; % Diamond indenter Poisson's ratio
v = 0.3; % Sample Poisson's ratio (change this to the actual value for your sample)

E = (1 - v^2) ./ ((1 - v1^2) / E1 - (1 - v^2) ./ reduced_modulus);

% Calculate the equivalent stress and strain
stress = E .* strain;
strain = hc / indenter_tip_radius;

% Plot stress-strain curve
figure;
plot(strain, stress);
xlabel('Strain');
ylabel('Stress');
title('Stress-Strain Curve from CSM Technique');
grid on;
