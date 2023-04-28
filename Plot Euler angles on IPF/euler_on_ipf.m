% clear all
hold on
CS = crystalSymmetry('m-3m');
SS = specimenSymmetry('orthorhombic');
Euler_angle_file  = 'EulerAngle.txt';
header_lines = 0;
delimiter = ' ';
input = importdata(Euler_angle_file, delimiter, header_lines);
Number_of_Euler_angle = size(input,1);
for i=1:Number_of_Euler_angle
    ori = orientation('Euler',input(i,1)*degree,input(i,2)*degree,input(i,3)*degree,CS,SS);
    plotIPDF(ori,zvector);
    hold on
end
hold off
