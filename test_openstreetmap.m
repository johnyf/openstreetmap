% test script for OpenStreetMap toolbox
%
% See also PARSE_OPENSTREETMAP, PLOT_WAY, EXTRACT_CONNECTIVITY,
%          GET_UNIQUE_NODE_XY.
%
% File:         test_openstreetmap.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.25
% Language:     MATLAB R2011b
% Purpose:      to illustrate usage of the OpenStreetMap Toolbox for MATLAB
% Copyright:    Ioannis Filippidis, 2010-

%openstreetmap_filename = 'test_map.osm';

%% convert XML -> MATLAB struct
% convert the OpenStreetMap XML Data file donwloaded as map.osm
% to a MATLAB structure containing part of the information describing the
% transportation network
[parsed_osm] = parse_openstreetmap(openstreetmap_filename);

%% plot
% plot the network, optionally a raster image can also be provided for the
% map under the vector graphics of the network
ax = gca;
plot_way(ax, parsed_osm)
%plot_way(ax, parsed_osm, map_img_filename) % if you also have a raster image

%% find connectivity
[connectivity_matrix, intersection_nodes] = extract_connectivity(parsed_osm);
[uniquend] = get_unique_node_xy(parsed_osm, intersection_nodes);
