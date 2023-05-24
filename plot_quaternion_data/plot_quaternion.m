% Load the quaternion data from the text file named 'inc100_HW.txt'
quat = dlmread('inc100_HW.txt');

% Define the crystal symmetry as 422, which represents the symmetry of a 
% tetragonal system with a four-fold rotation axis and two two-fold rotation axes
CS = crystalSymmetry('422');

% Convert the quaternion data to orientations based on the defined crystal symmetry
ori = orientation(quat,CS);

% Load orientations from a generic source (here a text file 'inc100_HW.txt'), 
% using a crystal symmetry CS, and specifying column names and their order in the file.
% This step may not be necessary if you already have your orientations in 'ori' from the previous steps.
ori = loadOrientation_generic('inc100_HW.txt','CS',CS, 'ColumnNames', ...
		      {'Quat real','Quat i','Quat j','Quat k'},'Columns',[1,2,3,4],'Bunge');
% Calculate the orientation distribution function (ODF) from the orientations
% with a specified resolution of 2.5 degrees. The ODF describes the distribution 
% of crystal orientations in a polycrystalline material.
odf = calcDensity(ori,'resolution',2.5*degree);

% Plot the ODF for given sections of phi2 (0, 45, 65 degrees) using antipodal symmetry 
% (i.e., orientations and their inversions are considered identical)
% The sections are represented by contour plots
plot(odf,'phi2',[0 45 65]* degree,'contour','antipodal');

% Save the generated plot as an image file named 'odf.png'
saveas(gcf,'odf.png'); 
% Plot (111) pole figure
plotPDF(odf,[Miller(1,1,1,CS)],'contour','antipodal','complete','upper');
