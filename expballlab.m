
clc,clear 
% Simulates a bouncing golfball from data obtained by bouncing the ball one time through a photogate

%% Variables:

fontSize = 20; % Set phontsize
yc = 1.1557;% Initial drop height
v_oy = 0;	% Initial y velocity 
g = 9.807;	% Gravitational acceleration
t = 0;		% Initial time when dropped
dt = 0.001;	% Delta time
COR = 0.800;% Restitution
peak = yc;	% Rebound height
h = yc;		% Instantaneous height.
hstop = 0.01;	% Height to stop the plotting
T = 0 : dt : 1000; % Preallocated time vector
H = zeros(1, length(T)); % Preallocated height vector
maxIterations = 100000; % Used in loops to prevent infinite loop   
loopCounter = 1;

%% Code:

while (peak > hstop) && (loopCounter < maxIterations)
	% Compute new height.
	hNew = h + v_oy * dt - 0.5 * g * dt ^ 2;
	
	if(hNew<0) % When the ball its the ground
		
		% Find index of last time h was 0
		lastBounceIndex = find(H(1 : loopCounter-1) == 0, 1, 'last');
		if isempty(lastBounceIndex)
			% If it hasn't bounced yet, start looking from the beginning.
			lastBounceIndex = 1;
		end
		% Compute the greatest height since the last bounce, or the initial release.
		[peak, index] = max(H(lastBounceIndex : end)); % Record height
		% Find time when it was at that height.
		tMax = T(index + lastBounceIndex - 1);
		
		% Reflect it up for negative height
		h = 0; 
        % New velocity after bounce is the old times the COR
		v_oy = -v_oy * COR; 
		
	else
		% Ball is falling or rising.
		v_oy = v_oy - g*dt;
		h = hNew;
	end
	H(loopCounter) = h;
	loopCounter = loopCounter + 1;
end
% Crop vectors
T = T(1 : loopCounter - 1);
H = H(1 : loopCounter - 1);
% vector for line for photogate height
L = .518*ones(length(T),1);
%% Plots:
hold on;
plot(T, H, 'r.', 'MarkerSize', 5);
plot(T,L,'b');
xlabel('Time [seconds]', 'FontSize', fontSize)
ylabel('Ball Height [m]', 'FontSize', fontSize)
title('Simulated Bouncing Golf Ball', 'FontSize', fontSize)
t1 = text(1.69,.535,'Photogate Height','FontSize',14,'Color','b');
t2 = text(3.4,1.1,'COR = .800','FontSize',16,'Color','R');