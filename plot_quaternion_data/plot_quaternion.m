quat = dlmread('inc100_HW.txt');
CS = crystalSymmetry('422');
ori = orientation(quat,CS);
ori = loadOrientation_generic('inc100_HW.txt','CS',CS, 'ColumnNames', ...
	      {'Quat real','Quat i','Quat j','Quat k'},'Columns',[1,2,3,4],'Bunge');
odf = calcDensity(ori,'resolution',2.5*degree);
plot(odf,'phi2',[0 45 65]* degree,'contour','antipodal');
saveas(gcf,'odf.png'); % save the ODF sections
