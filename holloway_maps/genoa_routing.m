%% calculate
% name file
openstreetmap_filename = 'genoa.osm';

% parse data
[parsed_osm] = parse_openstreetmap(openstreetmap_filename);

% find which nodes are connected
[connectivity_matrix, intersection_node_indices] = extract_connectivity(parsed_osm);
intersection_nodes = get_unique_node_xy(parsed_osm, intersection_node_indices);

% plan a route
%{
start = 1105; % node id
target = 889;
dg = connectivity_matrix; % directed graph
[route, dist] = route_planner(dg, start, target);
%}

% try without the assumption of one-way roads
start = 1; % node global index
target = 9;
dg = or(connectivity_matrix, connectivity_matrix.'); % make symmetric
[route, dist] = route_planner(dg, start, target);

%% plot data
fig = figure;
ax = axes('Parent', fig);
hold(ax, 'on')

plot_way(ax, parsed_osm, 'genoa.png')
plot_route(ax, route, parsed_osm)
only_nodes = 1:10:1000; % to reduce graphics memory & clutter
plot_nodes(ax, parsed_osm, only_nodes)
%plot_nodes(ax, parsed_osm, intersection_node_indices) % this is actually useful

hold(ax, 'off')
