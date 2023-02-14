%% FILE NAME: Config_energy_Morse_BRANSON.m

% CLASS: FALL ME 3060

% DATE: Jan. 20, 2023

% AUTHOR: Jacob Branson

% PURPOSE: 
% Outputs the total energy and total energy per atomic bond.

% HELP:
% This function takes an N x 3 array containing the X, Y, and Z 
% coordinates of each of the N atoms. As well as a 1 x 3 vector containing
% the parameters of the Morse potential [D,a,r].
% Returns a 1 x 2 vector containing the total bond energy of a ROW of atoms
% and the energy of the individual bond. Cubic lattuce.

%%CODE:

function [U_tot, U_atom]= Config_energy_Morse_BRANSON(atom_centers, Morse_param) 

% Pull data from Morse_param vec for convenience:
D = Morse_param(1,1);
a = Morse_param(1,2);
r_o = Morse_param(1,3);


% Loop to iterate over each point:
for i = 1:length(atom_centers)
        
        % Get index of pair from combos:
        idx1 = atom_centers(i,1:3);
        % Extract x,y,z coords of the first point:
        x = idx1(1,1);
        y = idx1(1,2);
        z = idx1(1,3);
        
        for j = i+1:length(atom_centers)
            
        idx2 = atom_centers(j,1:3);

        
        % Extract x,y,z coords of the second point:
        u = idx2(1,1);
        v = idx2(1,2);
        w = idx2(1,3);
        
        % Radius between pair: 
        tmpx = x - u; % x dist between pair
        tmpy = y - v; % y dist between pair
        tmpz = z - w; % z dist between pair
        
        rad = sqrt(tmpx^2+tmpy^2+tmpz^2);
        
        % Calculate bond strength between the pair (one bond):
        E_bond = D*(exp(-2*a*(rad-r_o))-2*exp(-a*(rad-r_o)));
        
        % Store bond energy between i and j
        tmp_bond_e(j,1) = E_bond;
        
        % Break before j runs over length
        if j == length(atom_centers)
            break
        end
        
        
        end
        % Sum energy between ith an j1,j2,j3... atom
        U_atom_act(i,1) = sum(tmp_bond_e(:,1));
        
        % Break before you crash the loop
        if i == length(atom_centers)-1
            break
        end
end
    % Sum energy of all bonds
    U_tot = sum(U_atom_act(:,1));
    
    % Get average atom energy
    U_atom = U_tot/length(atom_centers);
end