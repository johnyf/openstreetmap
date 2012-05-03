function [] = plot_road_network(ax, connectivity_matrix, parsed_osm)
%
% usage
%   PLOT_ROAD_NETWORK(ax, connectivity_matrix, parsed_osm)
%
% input
%   ax = axes object handle.
%   connectivity_matrix = matrix representing the road network
%                         connectivity, as returned by the function
%                         extract_connectivity.
%   parsed_osm = MATLAB structure containing the OpenStreetMap XML data
%                after parsing, as returned by function
%                parse_openstreetmap.
%
%   See also EXTRACT_CONNECTIVITY, PARSE_OPENSTREETMAP, ROUTE_PLANNER.
%
% File:         plot_road_network.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2012.04.24
% Language:     MATLAB R2012a
% Purpose:      plot the nodes and edges connecting them
% Copyright:    Ioannis Filippidis, 2012-

nodes = parsed_osm.node;
node_ids = nodes.id;
node_xys = nodes.xy;

n = size(connectivity_matrix, 2);

held = takehold(ax);
nodelist = [];
for curnode=1:n
    curxy = node_xys(:, curnode);
    
    % find neighbors
    curadj = connectivity_matrix(curnode, :);
    neighbors = find(curadj == 1);
    neighbor_xy = node_xys(:, neighbors);
    
    % plot edges to each neighbor
    for j=1:size(neighbor_xy, 2)
        otherxy = neighbor_xy(:, j);
        xy = [curxy, otherxy];
        plotmd(ax, xy)
    end
    
    % is node connected ?
    if ~isempty(neighbor_xy)
        nodelist = [nodelist, curnode];
    end
end

%plot_nodes(ax, parsed_osm, nodelist)

givehold(ax, held)
