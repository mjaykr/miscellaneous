% Load experimental load-displacement data
filename = 'your_load_displacement_data.txt';
data = dlmread(filename);
load_data = data(:, 1);
displacement_data = data(:, 2);

% Constants
indenter_area_coefficient = 24.5; % Change this value based on your indenter geometry
temperature = 300; % Temperature in K

% Calculate maximum load (Pmax) and maximum displacement (hm)
Pmax = max(load_data);
hm = max(displacement_data);

% Calculate the stiffness (S) using the unloading curve
% Here we assume a simple linear fit of the unloading curve; you may need a more accurate method for your specific data
unloading_curve_start_index = find(load_data == Pmax, 1);
unloading_fit = polyfit(displacement_data(unloading_curve_start_index:end), load_data(unloading_curve_start_index:end), 1);
S = unloading_fit(1);

% Calculate contact depth (hc) using Oliver and Pharr method
hc = hm - Pmax / S;

% Calculate contact area (A) based on indenter geometry
A = indenter_area_coefficient * hc^2;

% Calculate hardness (H)
hardness = Pmax / A;

% Constants for activation volume calculation
k = 1.380649e-23; % Boltzmann's constant in J/K

% Define the relationship between hardness and loading rate
% Here we assume a simple linear relationship: H = a * log(P_dot) + b
% You should replace this with the actual relationship for your specific material
a = 1e8; % Linear coefficient (Pa)
b = 4e9; % Constant term (Pa)

% Calculate the derivative of hardness with respect to the logarithm of the loading rate
dH_dln_Pdot = a;

% Calculate activation volume
activation_volume = k * temperature * dH_dln_Pdot / hardness;

% Display the results
fprintf('The hardness calculated using the load-displacement data is: %.2e Pa\n', hardness);
fprintf('The activation volume for nanoindentation at a constant single loading rate is: %.2e m^3\n', activation_volume);
