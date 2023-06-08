% Specify the name of the Excel file
filename = 'Book1.xlsx';

% Get the sheet names from the Excel file
sheets = sheetnames(filename);

% Loop over each sheet (sample)
for sheetIndex = 1:length(sheets)
    % Read the data from the current sheet
    data = xlsread(filename, sheets{sheetIndex});
    
    % Get the number of tests
    numTests = size(data, 2) / 2;
    
    % Create a figure for the current sample
    figure;
    hold on;
    
    % Loop over each test
    for testIndex = 1:numTests
        % Extract the temperature and heat flux columns for the current test
        temperature = data(:, 2*testIndex - 1);
        heatFlux = data(:, 2*testIndex);
        
        % Plot the temperature vs. heat flux for the current test
        plot(temperature, heatFlux);
    end
    
    % Set labels and title for the current sample's plot
    xlabel('Temperature');
    ylabel('Heat Flux');
    title(sheets{sheetIndex});
    
    % Add a legend for the tests in the current sample
    legend('Test 1', 'Test 2', 'Test 3', 'Test 4'); % Modify this line based on the number of tests
    
    % Turn on the upper and right axes
    box on;
    
    % Hold off the current figure
    hold off;
end
