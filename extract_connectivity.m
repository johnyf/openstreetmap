% File:         extract_connectivity.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.20
% Language:     MATLAB, program version: 7.11 (2010b)
% Purpose:      extract road connectivity from parsed osm structure
% Copyright:    Ioannis Filippidis, 2010-

function [node_connectivity, intersection_nodes] = ...
    extract_connectivity(parsed_osm)

[~, node, way, ~] = assign_from_parsed(parsed_osm);

road_vals = {'motorway', 'motorway_link', 'trunk', 'trunk_link',...
             'primary', 'primary_link', 'secondary', 'secondary_link',...
             'tertiary', 'road', 'residential', 'living_street',...
             'service', 'services', 'motorway_junction'};

%% connectivity
Nsamends = 0;
node_connectivity = sparse([]);
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
                node_connectivity(nd1id, ndid) = 1;
                nd1id = [nd1id, ndid];
                break; % link to at least one other way suffices to notice
            end
        end
    end
end

%% unique nodes
nnzrows = any(node_connectivity, 2);
nnzcmns = any(node_connectivity, 1);
nnznds = nnzrows' | nnzcmns;
intersection_nodes = nnznds;

figure;
    spy(node_connectivity)

%% report
disp( ['Found ' num2str(Nsamends) ' common nodes.'] )
disp( ['Connectivity matrix contains ' num2str(nnz(node_connectivity) )...
       'nonzero elements.'] )
disp( ['Although the unique ones were '...
        num2str(nnz(nnznds) ) '.'] )
