function [] = plot_road_network(ax, connectivity_matrix, parsed_osm)
nodes = parsed_osm.node;
node_ids = nodes.id;
node_xys = nodes.xy;

n = size(connectivity_matrix, 2);

held = takehold(ax);
nodelist = [];
for curnode=1:n
    curxy = node_xys(:, curnode);
    
    % find neighbors
    curadj = connectivity_matrix(curnode, :);
    neighbors = find(curadj == 1);
    neighbor_xy = node_xys(:, neighbors);
    
    % plot edges to each neighbor
    for j=1:size(neighbor_xy, 2)
        otherxy = neighbor_xy(:, j);
        xy = [curxy, otherxy];
        plotmd(ax, xy)
    end
    
    % is node connected ?
    if ~isempty(neighbor_xy)
        nodelist = [nodelist, curnode];
    end
end

%plot_nodes(ax, parsed_osm, nodelist)

givehold(ax, held)
