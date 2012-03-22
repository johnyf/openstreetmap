% File:         plot_way.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.06 - 
% Language:     MATLAB, program version: 7.11 (2010b)
% Purpose:      parse .osm file (OpenStreetMap)
% Copyright:    Ioannis Filippidis, 2010-

% ToDo
%   add double way roads

function [] = plot_way(hax, parsed_osm)

[bounds, node, way, relation] = assign_from_parsed(parsed_osm);

disp_info(bounds, size(node.id, 2), size(way.id, 2))
show_ways(hax, bounds, node, way);

function [] = show_ways(hax, bounds, node, way)
%figure;
show_map(hax, bounds)

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
disp('--')
disp('OpenStreetMap (.osm) MATLAB Parser v.0.2')
disp('Ioannis Filippidis & Georgios Karavas (c) 2010')
disp('--')
disp( ['Bounds: xmin = ' num2str(bounds(1,1)),...
    ', xmax = ', num2str(bounds(1,2)),...
    ', ymin = ', num2str(bounds(2,1)),...
    ', ymax = ', num2str(bounds(2,2)) ] )
disp( ['Number of nodes: ' num2str(Nnode)] )
disp( ['Number of ways: ' num2str(Nway)] )
