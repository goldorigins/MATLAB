%% This function takes the run you want and analyses it.
% call it like : lab2_dayne_tory_jacob(run)
% 'run' is any integer between 1 and 6.

%% FILE NAME: lab2_dayne_tory_jacob.m
%% ME 3060

%% AUTHOR:  Jacob Branson

%% PURPOSE: 
%  Analizes data generated from a spring-cart system on a track.

%% ASSUMPTIONS: 

% The system is real and has values that can be empirically measured.
% The system is UNDERDAMPED.
% Cart Mass = 245g.
% Wheels D = 3.2cm, Thickness = 6cm, density = .95 g/cc
% Advertised spring constants; RED:10 BLUE:20 GREEN:40 (N/m)
% Using runs 2,4,5,6,7,8 for 6 runs total.
% Run 1 has incorrect frequency: discard from origional data.
% Run 3 the springs struck the track: discard from origional data.

% Starts were zeroed when right side edge was at recorded value then moved
% to a recorded displacement, recording then started and the cart was let
% go:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run 1: Start @ 66cm-->71cm, walls @ 10/110cm, long green/blue
% Run 2: Start @ 70cm-->75cm, walls @ 10/110cm, 2 srt gr, 1 lng blu
% Run 3: Start @ 70cm-->75cm, walls @ 10/110cm, 2 srt gr, 1 lng blu, +250g
% Run 4: Start @ 70cm-->75cm, walls @ 10/110cm, 2 srt gr, 1 lng blu, +500g
% Run 5: Start @ 66cm-->71cm, walls @ 10/110cm, long green/blue, +250g
% Run 6: Start @ 66cm-->71cm, walls @ 10/110cm, long green/blue, +500g
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A SHORT GREEN spring was hung and its displacemnt was measured:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unloaded: 4.0cm
% 100g Wt:  4.0cm
% 200g Wt:  5.5cm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This indicates that the springs have a pre-load requirement.

% APPARATUS:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% |                                                                       |
% |                                                                       |
% |                                                                       |
% |           SPRINGS        CART                   LONG BLUE             | 
% |---OOOOOOOOOOOOOOOOOOO---X====X---OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO--|
% |_________________________0----0________________________________________|
% |______________________________^_______^________________________________|
%                               x_o---->x_disp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%The app took x_disp as zero which is fine but all the steady state values
%are offset by 5cm.
%The app took to the right as negative

function lab2_dayne_tory_jacob(r)
%% CODE
n = r+1; %this controls what run is handled. take the run you want and add 1.

% Data Preperation:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
all_lab_data = readtable('all_sparkvue_data_lab2.csv'); %Imports data
positions = table2array(all_lab_data(:,[8 21 34 47 60 73])); %arry of pos

%makes steady state be zero
positions(:,1) = positions(:,1)-.0508;
positions(:,2) = positions(:,2)-.0462;
positions(:,3) = positions(:,3)-.0475;
positions(:,4) = positions(:,4)-.0525;
positions(:,5) = positions(:,5)-.0508;
positions(:,6) = positions(:,6)-.0506;

positions(isnan(positions)) = 0; %removes all nan
x_t = ([linspace(0,60.44,3023)' -positions]); 
    %matrix of runs 1-6 with standardized time.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculations: (pks, vlys, intercepts...)

pks = islocalmax(x_t);
vlys = islocalmin(x_t);

for i = 1:2000
    if abs(x_t(i,n)) < .0001
        x_int(i,1) = true;
    end  
end %x intercepts (doesnt get them all but enough for frequency)


% Plots:

hold on
plot(x_t(:,1),x_t(:,n))
plot(x_t(pks(:,n),1),x_t(pks(:,n),n),'r*'...
    ,x_t(vlys(:,n),1),x_t(vlys(:,n),n),'go') %plots min/max

plot(x_t(x_int,1),x_t(x_int,n),'b*')%plots a few x intercepts

title(['Displacement of a Cart-Spring System: Run #',num2str(n-1),''])
xlabel('Time (s)')
ylabel('Displacement (m)')
legend('Cart Displacement','Max','Min')

%plot(x_t(:,1),x_t(:,[2 3 4 5 6 7])) % plots everything 

 % determine b from coefficent of exponential
 % a line fit of these against eachother will give b
 x_max = x_t(pks(:,2),1);
 y_max = x_t(pks(:,2),2);
 
end






