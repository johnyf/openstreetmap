function [route, dist] = route_planner(dg, S, T)
% File:         route_planner.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.17 - 2012.04.24
% Language:     MATLAB R2012a
% Purpose:      find shortest path in graph of road intersections (nodes)
% Copyright:    Ioannis Filippidis, 2010-

%% find path
[dist, route, ~] = graphshortestpath(dg, S, T, 'Directed', true,...
                                    'Method', 'Dijkstra');

%% report
disp('Distance: ')
disp(dist.')
