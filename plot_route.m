function [] = plot_route(ax, route, parsed_osm)
%
% usage
%   PLOT_ROUTE(ax, route, parsed_osm)
%
% input
%   ax = axes object handle.
%   route = matrix of nodes traversed along route, as returned by the
%           route_planner function.
%   parsed_osm = parsed OpenStreetMap XML data, as returned by the
%                parse_openstreetmap function.
%
%   See also ROUTE_PLANNER, PARSE_OPENSTREETMAP.
%
% File:         plot_route.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2012.04.24
% Language:     MATLAB R2012a
% Purpose:      plot (over map) the route found by route planner
% Copyright:    Ioannis Filippidis, 2012-

% empty path ?
if isempty(route)
    warning('path is empty. This means that the planner found no path.')
    return
end

nodexy = parsed_osm.node.xy;
start_xy = nodexy(:, route(1, 1) );
path_xy = nodexy(:, route);
path_end = nodexy(:, route(1, end) );

held = takehold(ax);

plotmd(ax, start_xy, 'Color', 'm', 'Marker', 'o', 'MarkerSize', 15)
plotmd(ax, path_xy, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 5)
plotmd(ax, path_end, 'Color', 'c', 'Marker', 's', 'MarkerSize', 15)

givehold(ax, held)
