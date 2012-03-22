function [] = plot_way(ax, parsed_osm, map_img_filename)
%PLOT_WAY   plot parsed OpenStreetMap file
%
% usage
%   PLOT_WAY(ax, parsed_osm)
%
% input
%   ax = axes object handle
%   parsed_osm = parsed OpenStreetMap (.osm) XML file,
%                as returned by function parse_openstreetmap
%   map_img_filename = map image filename to load and plot under the
%                      transportation network
%                    = string (optional)
%
% See also PARSE_OPENSTREETMAP, EXTRACT_CONNECTIVITY.
%
% File:         plot_way.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.06
% Language:     MATLAB R2011b
% Purpose:      plot parsed OpenStreetMap file
% Copyright:    Ioannis Filippidis, 2010-

% ToDo
%   add double way roads

if nargin < 3
    map_img_filename = [];
end

[bounds, node, way, ~] = assign_from_parsed(parsed_osm);

disp_info(bounds, size(node.id, 2), size(way.id, 2))
show_ways(ax, bounds, node, way, map_img_filename);

function [] = show_ways(hax, bounds, node, way, map_img_filename)
show_map(hax, bounds, map_img_filename)

%plot(node.xy(1,:), node.xy(2,:), '.')

key_catalog = {};
for i=1:size(way.id,2)
    [key, val] = get_way_tag_key(way.tag{1,i} );
    
    % find unique way types
    if isempty( find(ismember(key_catalog, key) == 1, 1) )
        key_catalog(1,end+1) = {key};
    end
    
    flag = 0;
    switch key
        case 'highway'
            if strcmp(val,'bus_stop')
                disp('Bus stop found')
            end
            flag = 1;
        case 'amenity'
            if strcmp(val,'bus_station')
                disp('Bus station found')
            end
    end
    
    waynd = way.nd{1,i};
    nd = zeros(2,size(waynd,2));
    for j=1:size(waynd,2)
        nd(:,j) = node.xy(:, waynd(1,j) == node.id);
    end

    if flag == 1
        plot(hax, nd(1,:), nd(2,:), 'b-')
    end
    %waitforbuttonpress
end
disp(key_catalog')

function [] = disp_info(bounds, Nnode, Nway)
disp( ['Bounds: xmin = ' num2str(bounds(1,1)),...
    ', xmax = ', num2str(bounds(1,2)),...
    ', ymin = ', num2str(bounds(2,1)),...
    ', ymax = ', num2str(bounds(2,2)) ] )
disp( ['Number of nodes: ' num2str(Nnode)] )
disp( ['Number of ways: ' num2str(Nway)] )
