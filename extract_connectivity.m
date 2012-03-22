function [connectivity_matrix, intersection_nodes] = ...
    extract_connectivity(parsed_osm)
%EXTRACT_CONNECTIVITY   extract road connectivity from parsed OpenStreetMap
%   [connectivity_matrix, intersection_nodes] = EXTRACT_CONNECTIVITY(parsed_osm)
%   extracts the connectivity of the road network of the OpenStreetMap
%   file. This yields a set of nodes where the roads intersect.
%
%   Some intersections may appear multiple times, because different roads
%   may meet at the same intersection and because multiple directions are
%   considered different roads. For this reason, in addition to the
%   connectivity matrix, the unique nodes are also identified.
%
% usage
%   [connectivity_matrix, intersection_nodes] = ...
%                                   EXTRACT_CONNECTIVITY(parsed_osm)
%
% input
%   parsed_osm = parsed OpenStreetMap (.osm) XML file,
%                as returned by function parse_openstreetmap
%
% output
%   connectivity_matrix = adjacency matrix of the directed graph
%                         of the transportation network
%                       = adj(i, j) = 1 (if a road leads from node i to j)
%                                   | 0 (otherwise)
%   intersection_nodes = the unique nodes of the intersections
%
% See also PARSE_OPENSTREETMAP, PLOT_WAY.
%
% File:         extract_connectivity.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.20
% Language:     MATLAB R2011b
% Purpose:      extract road connectivity from parsed osm structure
% Copyright:    Ioannis Filippidis, 2010-

[~, node, way, ~] = assign_from_parsed(parsed_osm);

road_vals = {'motorway', 'motorway_link', 'trunk', 'trunk_link',...
             'primary', 'primary_link', 'secondary', 'secondary_link',...
             'tertiary', 'road', 'residential', 'living_street',...
             'service', 'services', 'motorway_junction'};

%% connectivity
Nsamends = 0;
connectivity_matrix = sparse([]);
for i=1:size(way.id, 2)
    waynd = way.nd{1,i};
    
    % highway?
    [key, val] = get_way_tag_key(way.tag{1,i} );
    if strcmp(key, 'highway') == 0
        continue;
    end
    
    % road?
    if isempty(ismember(road_vals, val) == 1) == 1
        continue;
    end
    
    nd1id = find(waynd(1,1) == node.id);
    
    % connected?
    for j=1:size(waynd, 2)
        % when directed this economy cannot be made
        for k=1:size(way.id, 2)
            % avoid same
            if way.id(1,k) == way.id(1,i)
                continue;
            end
            
            idx = find(way.nd{1,k} == waynd(1,j));
            if isempty(idx) == 0
                Nsamends = Nsamends +1;
                ndid = find(waynd(1,j) == node.id);
                connectivity_matrix(nd1id, ndid) = 1;
                nd1id = [nd1id, ndid];
                break; % link to at least one other way suffices to notice
            end
        end
    end
end

%% unique nodes
nnzrows = any(connectivity_matrix, 2);
nnzcmns = any(connectivity_matrix, 1);
nnznds = nnzrows' | nnzcmns;
intersection_nodes = nnznds;

figure;
    %spy(connectivity_matrix)

%% report
disp( ['Found ' num2str(Nsamends) ' common nodes.'] )
disp( ['Connectivity matrix contains ' num2str(nnz(connectivity_matrix) )...
       ' nonzero elements.'] )
disp( ['Although the unique ones were '...
        num2str(nnz(nnznds) ) '.'] )
