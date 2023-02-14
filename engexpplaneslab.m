%% ME 3005
% Lab 4: Inclined planes

% To determine the plane equations first uncomment plot3 command.
% Then examine the plot3 for outliers or breaks.
% record the index of those breaks and use 3 points from each group
% for the cross and dot products.
clc, clear

%% CODE:
%box bounds
xmax = 7;
ymax = 3;
zmax = 6;

% Experemental data for planes p:
p = [0,0,3.15;2,1,3.72;4,0,4.45;6,0,5.06;8,0,5.83;...
    6,2,4.96;4,3,4.33;7,0,4.22;7,1,4.31];
px = p(:,1);
py = p(:,2);
pz = p(:,3);

%normalize
nor1 = cross(p(1,:)-p(2,:),p(1,:)-p(4,:));
nor2 = cross(p(5,:)-p(8,:),p(5,:)-p(9,:));

%equation plane 1
syms x y z
P = [x,y,z];
planefunction = dot(nor1, P-p(1,:));
zplane = solve(planefunction, z);

%equation plane 2 
syms u v w
o = [u,v,w];
planefunction2 = dot(nor2, o-p(5,:));
oplane = solve(planefunction2, w);

%% PLOTS:
fmesh(zplane, [0, 6, 0, 3],'MeshDensity',100), hold on
fmesh(oplane, [6, 8, 0, 3],'EdgeColor','#4DBEEE','MeshDensity',100), hold on
axis([0, 9, 0, 4, 0, 7])
plot3(px,py,pz,'r*')
title('Intersecting Planes')
xlabel('X AXIS')
ylabel('Y AXIS')
zlabel('Z AXIS')

