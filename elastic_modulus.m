%% FILE NAME: elastic_modulus_BRANSON.m

% CLASS: FALL ME 3060

% DATE: Jan. 20, 2023

% AUTHOR: Jacob Branson

% PURPOSE: 
% Evaluate the elastic modulus of an array of atoms.

%!!!! any vars with name _m but the same name i.e. U_atom / U_atom_m
%     are designated _m for part 2 where I vary array size m.!!!!

%% CODE:
clc,clear

% Given Constants:
D   = 0.1656;  %eV
r_o = 0.26163; %nm
a   = 20.926;  %nm^(-1)
Morse_param = [D,a,r_o];

% Generates different spacings
r = linspace(r_o*.98,r_o*1.02,1461); 

% Preallocate
x = zeros(5,1);
y = zeros(5,1);
z = zeros(5,1);
for k = 1:length(r)

% Make the array:
% Spacing of atoms is previous coord plus whatever the current spacing is
    for i = 1:4
        x(i+1) = x(i)+r(k);
    end
    
    for i = 1:4
        y(i+1) = x(i)+r(k);
    end
    
    for i = 1:4
        z(i+1) = x(i)+r(k);
    end
    
    %Mesh for plot
    [X,Y,Z] = meshgrid(x,y,z);

    atom_centers(:,1) = X(:);
    atom_centers(:,2) = Y(:);
    atom_centers(:,3) = Z(:);

    % Send to function and get energies:
    [U_tot, U_atom] = Config_energy_Morse_BRANSON(atom_centers,Morse_param);

    % Store values in array columns: radius, total energy:
    data(k,1) = r(k); % Radius
    data(k,2) = U_tot; % Total energy all bonds
    data(k,3) = U_atom; % Avg atomic energy
    % Stores array of individual atom energies for each radius

end


%% Part i: determine equilibrium spacing.

% Equilibrium occours where energy is a minimum
% Row index of lowest energy value:
idx_min_energy = find(data(:,2)==min(data(:,2)));
% Get distance at the index of the min energy
equilibrium_distance = data(idx_min_energy,1);
% Just for giggles get min energies:
min_U_tot = min(data(:,2));
min_U_atom = min(data(:,3));


%% Thermal Coeifficent:
% avg radius between 2 equal energies
for n = 1:720
    % Get an energy, find the index onf the energy nearest that on the
    % other side of equilibrium. Get r at that index. Average the r values
    % for the same energies.
    [val,idx]=min(abs(data(1:idx_min_energy,2)-data(idx_min_energy+n,2)));
    r_ave(n,1) = (data(idx,1)+data(idx_min_energy+n,1))/2; % avg radius at energy
    r_ave(n,2) = data(idx_min_energy+n,2); % energy 

end

% The thermal coefficent is the slope of the line made by r_ave

for i = 50:length(r_ave)-55
   % array of slopes between points
   % had to do +55 b/c +1 was vertical sometimes giving inf
   thermal_coef(i-49,1) = (r_ave(i+55,2)-r_ave(i,2))/(r_ave(i+55,1)-r_ave(i,1));
   
end
avg_thermal_coeff = mean(thermal_coef)*(1.602176565*10^-19); %nm/eV;

% This just makes a centerline for the plot.
centerline_x = ones(length(data)-idx_min_energy,1).*data(idx_min_energy,1);
centerline_y = data(idx_min_energy:length(data)-1,2);

% Uncomment for plot of total energy vs R
%{
hold on
plot(data(:,1),data(:,2)) % radius vs energy
plot(r_ave(:,1),r_ave(:,2)) % avg radius between 2 equal energies
plot(centerline_x(:,1),centerline_y(:,1),'b--') %centerline
plot(equilibrium_distance,min(data(:,2)),'r*',LineWidth=2) % min vals
title('Total Bond Energy for Different Atomic Spacings')
xlabel('Atom Spacing (nm)')
ylabel('Total Energy (eV)')
legend('Total Energy','Avg Radius')

%}
% Uncomment to see lattice
%{
hold off
o = .26163/2;
[ux,vy,wz] = sphere;
ux = ux*o;
vy = vy*o;
wz = wz*o;
for i = 1:length(atom_centers)
    hold on
    surf(ux+atom_centers(i,1),vy+atom_centers(i,2),wz+atom_centers(i,3))
    drawnow();
end
%}
%% Part ii: U_atom for different arrays at r = equilibrium_distance

r_m = equilibrium_distance;
m = 2:1:6;

for k = 1:length(m)
x = zeros(m(k),1);
y = zeros(m(k),1);
z = zeros(m(k),1);
% Make the array:
% Spacing of atoms is previous coord plus whatever the current spacing is
    for i = 1:m(k)
        x(i+1) = x(i)+r_m;
        if i+1 == m(k)
            break
        end
    end
    
    for i = 1:m(k)
        y(i+1) = x(i)+r_m;
        if i+1 == m(k)
            break
        end
    end
    
    for i = 1:m(k)
        z(i+1) = x(i)+r_m;
        if i+1 == m(k)
            break
        end
    end
    
    %Mesh for plot
    [X,Y,Z] = meshgrid(x,y,z);
    atom_centers_m = zeros(m(k)^3,3);
    atom_centers_m(:,1) = X(:);
    atom_centers_m(:,2) = Y(:);
    atom_centers_m(:,3) = Z(:);

    % Send to function and get energies:
    [U_tot_m, U_atom_m] = Config_energy_Morse_BRANSON(atom_centers_m,Morse_param);

    % Store values in array columns: radius, total energy:
    data_m(k,1) = m(k); % Dimension mXmXm
    data_m(k,2) = U_tot_m; % Total energy all bonds in mXmXm array
    data_m(k,3) = U_atom_m; % Average bond energy per atom.
    
    
end

% Uncomment for plot of avg bond energy vs array size
%{
hold on
plot(data_m(:,1),data_m(:,3),'b--')
plot(data_m(:,1),data_m(:,3),'r*',linewidth=2)
title('Total Energy of Different Sized Lattices')
xlabel('Lattice Size (MxMxM)')
ylabel('Total Energy of System (eV)')
%}

%% Bulk Modulus
b = data(idx_min_energy,1)*4; %side length of cube

vo = (b)^3; % minimum volume (row 78 in data)
v1 = (data(idx_min_energy+1,1)*4)^3; % arbitrarilly chosen volume increase

perc_v = (v1-vo)/vo; %percent increase in volume

alpha = perc_v/3; % scale factor

del_p = (-1/3)*((data(idx_min_energy+1,2)-data(idx_min_energy,2))/(alpha*b^3));
% Change in press

bulk_mod = (-del_p/perc_v)*.1602176565; % bulk modulus in eV/nm^3
% .1602176565 converts to GPa from eV/nm^3

%{
clear  X atom_centers_m equilibrium_distance  vo...                  
Y b i perc_v x ...                    
U_atom Z idx_min_energy r y...            
U_atom_m data k r_m z...
U_tot alpha data_m m...                   
U_tot_m atom_centers del_p v1 a centerline_x...
centerline_y D idx Morse_param n r_ave r_o thermal_coef val

disp('DONE')
%}