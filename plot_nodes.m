function [] = plot_nodes(ax, parsed_osm, only_node_indices, show_id)
%
% usage
%   PLOT_NODES(ax, parsed_osm, only_node_indices, show_id)
%
% input
%   ax = axes object handle where to plot the nodes.
%   parsed_osm = MATLAB structure containing the OpenStreetMap XML data
%                after parsing, as returned by function
%                parse_openstreetmap.
%   only_node_indices = selected node indices in the global node matrix.
%   show_id = select whether to show or not the ID numbers of nodes as text
%             labes within the plot
%           = 0 (do not show labels) | 1 (show labels)
%   
%   See also PARSE_OPENSTREETMAP, ROUTE_PLANNER.
%
% File:         plot_nodes.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2012.04.24 - 2012.05.03
% Language:     MATLAB R2012a
% Purpose:      plot (selected) nodes and label each with index and id
% Copyright:    Ioannis Filippidis, 2012-

% do not show node id (default)
if nargin < 4
    show_id = 0;
end

nodes = parsed_osm.node;
node_ids = nodes.id;
node_xys = nodes.xy;

% which nodes to plot ?
n = size(node_xys, 2);
if nargin < 3
    only_node_indices = 1:n;
end

%% plot
held = takehold(ax);

% nodes selected exist ?
if n < max(only_node_indices)
    warning('only_node_indices contains node indices which are too large.')
    return
end

% plot nodes
xy = node_xys(:, only_node_indices);
plotmd(ax, xy, 'yo')

% label plots
for i=only_node_indices
    node_id_txt = num2str(node_ids(1, i) );
    if show_id
        curtxt = {['index=', num2str(i) ], ['id=', node_id_txt] }.';
    else
        curtxt = ['index=', num2str(i) ];
    end
    textmd(node_xys(:, i), curtxt, 'Parent', ax)
end

givehold(ax, held)
