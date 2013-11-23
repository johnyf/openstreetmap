function [intersection_nodes] = ...
                    get_unique_node_xy(parsed_osm, intersection_node_indices)
% get the x,y coordinates of unique nodes at road intersections
%
% 2010.11.20 (c) Ioannis Filippidis, jfilippidis@gmail.com

ids = parsed_osm.node.xy(:, intersection_node_indices);
xys = parsed_osm.node.xy(:, intersection_node_indices);

intersection_nodes.id = ids;
intersection_nodes.xys = xys;
