function [] = plot_nodes(ax, parsed_osm, only_node_indices, show_id)
% File:         plot_nodes.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2012.04.24
% Language:     MATLAB R2012a
% Purpose:      plot (selected) nodes and label each with index and id
% Copyright:    Ioannis Filippidis, 2012-

if nargin < 4
    show_id = 0;
end

nodes = parsed_osm.node;
node_ids = nodes.id;
node_xys = nodes.xy;

% which nodes to plot ?
if nargin < 3
    n = size(node_xys, 2);
    only_node_indices = 1:n;
end

%% plot
held = takehold(ax);

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
