% Read data from text file
filename = 'your_file.txt';
data = dlmread(filename);

% Separate load and displacement columns
load_data = data(:, 1); % Load in first column
displacement_data = data(:, 2); % Displacement in second column

% Constants
indenter_area_coefficient = 24.5;
tabor_constant = 3; % This value can vary depending on the material

% Calculate maximum displacement (hm) and maximum load (Pmax)
hm = max(displacement_data);
Pmax = max(load_data);

% Calculate contact depth (hc) and contact area (A) using Oliver and Pharr method
hc = hm - Pmax / S;
A = indenter_area_coefficient * hc^2;

% Calculate hardness (H) and yield strength (σy) using Tabor's concept
hardness = Pmax / A;
yield_strength = hardness / tabor_constant;

% Calculate the equivalent stress and strain
stress = yield_strength * load_data / Pmax;
strain = displacement_data / hm;

% Plot stress-strain curve
figure;
plot(strain, stress);
xlabel('Strain');
ylabel('Stress');
title('Stress-Strain Plot using Tabor''s Concept');
grid on;
