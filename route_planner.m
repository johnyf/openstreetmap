function [route, dist] = route_planner(dg, S, T)
%
% usage
%   [route, dist] = ROUTE_PLANNER(dg, S, T)
%
% input
%   dg = directed graph of road network
%      = [N x N] matrix
%        (element i,j is non-zero when the connection between nodes
%         i->j exists). Use the connectivity_matrix returned by function
%        extract_connectivity.
%   S = route source (start) node
%     = node index (int)
%   T = route target (destination) node
%     = node index (int)
%
% output
%   route = matrix of subsequent nodes traversed
%   dist = total distance covered by route, counting as unit distance a
%          transition between nodes (Remark: this is NOT the actual
%          distance over the map for this route).
%
%   See also EXTRACT_CONNECTIVITY, PLOT_ROUTE, PLOT_ROAD_NETWORK, PLOT_NODES.
%
% File:         route_planner.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.17 - 2012.04.24
% Language:     MATLAB R2012a
% Purpose:      find shortest path in graph of road intersections (nodes)
% Copyright:    Ioannis Filippidis, 2010-

%% find path
[dist, route, ~] = graphshortestpath(dg, S, T, 'Directed', true,...
                                    'Method', 'Dijkstra');

% no path found ?
if isempty(route)
    warning('No route found by the route planner. Try without road directions.')
    return
end

%% report
disp('Distance: ')
disp(dist.')
