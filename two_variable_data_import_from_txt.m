% Opens and imports x,y data to be used in the finite_difference_method.m function
% Was made for a specific purpose but could read any x,y data from a .txt file

function DATA = importdata()
filename = 'exp.txt';                       % SPECIFY THE FILE NAME AND DIRECTORY
fileID = fopen(filename,'r');               % OPEN THE FILE
l = fgetl(fileID);                          % SKIP THE HEADER LINE

formatspec = [2 inf];                       % FORMAT OF THE NUMERICAL DATA YOU EXPECT TO READ
DATA = fscanf(fileID,'%f %f\n',formatspec); % SCAN AND IMPORT THE DATA 
fclose(fileID);                             % CLOSE THE REFERENCE TO THE FILE

radx = DATA(2,:)';                          % TAKE RADIAN DATA
t = DATA(1,:)';                             % TAKE TIME DATA

%{
plot(t,radx)                               % PLOT THA DATA comented out 
title('Angular Position in Radians')       % because every time I run the test
xlabel('time')                             % the plot appears. But I did do
ylabel('Angular Position')                 % it so there it is 
end
%}


