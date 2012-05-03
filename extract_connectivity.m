function [connectivity_matrix, intersection_node_indices] = ...
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

ways_num = size(way.id, 2);
ways_node_sets = way.nd;
node_ids = node.id;
for curway=1:ways_num
    % highway?
    [key, val] = get_way_tag_key(way.tag{1, curway} );
    if strcmp(key, 'highway') == 0
        continue;
    end
    
    % road?
    if isempty(ismember(road_vals, val) == 1) == 1
        continue;
    end
    
    % current way node set
    nodeset = ways_node_sets{1, curway};
    nodes_num = size(nodeset, 2);
    
    % first node id
    first_node_id = nodeset(1, 1);
    node1_index = find(first_node_id == node_ids);
    
    % which other nodes connected to node1 ?
    curway_id = way.id(1, curway);
    for othernode_local_index=1:nodes_num
        othernode_id = nodeset(1, othernode_local_index);
        othernode_index = find(othernode_id == node_ids);
        
        % assume nodes are not connected
        connectivity_matrix(node1_index, othernode_index) = 0;
        
        % ensure the connectivity matrix is square
        % (although it does not need be symmetric,
        %  because the transportation netwrok graph is directed)
        connectivity_matrix(othernode_index, node1_index) = 0;
        
        % directed graph, hence asymmetric connectivity matrix (in general)
        for otherway=1:ways_num
            % skip same way
            otherway_id = way.id(1, otherway);
            if otherway_id == curway_id
                continue;
            end
            
            otherway_nodeset = ways_node_sets{1, otherway};
            idx = find(otherway_nodeset == othernode_id, 1);
            if isempty(idx) == 0
                Nsamends = Nsamends +1;
                connectivity_matrix(node1_index, othernode_index) = 1;
                node1_index = [node1_index, othernode_index];
                
                % node1 connected to othernode
                % othernode belongs to at least one other way
                % hence othernode is an intersection
                % node1->othernode connectivity saved in connectivity_matrix
                % this suffices, ignore rest of ways through othernode
                break;
            end
        end
        
        % error check
        if size(connectivity_matrix, 1) ~= size(connectivity_matrix, 2)
            error(['connectivity matrix is not square. Instead:\n', ...
                   'size(connectivity_matrix) = ',...
                   num2str(size(connectivity_matrix) ) ] )
        end
    end
end

% connectivity matrix should not contain any self-loops
for i=1:size(connectivity_matrix)
    connectivity_matrix(i, i) = 0;
end

%% unique nodes
nnzrows = any(connectivity_matrix, 2);
nnzcmns = any(connectivity_matrix, 1);

nnznds = nnzrows.' | nnzcmns;
intersection_node_indices = find(nnznds == 1);

figure;
    spy(connectivity_matrix)

%% report
disp( ['Found ' num2str(Nsamends) ' common nodes.'] )
disp( ['Connectivity matrix contains ' num2str(nnz(connectivity_matrix) )...
       ' nonzero elements.'] )
disp( ['Although the unique ones were '...
        num2str(nnz(nnznds) ) '.'] )
