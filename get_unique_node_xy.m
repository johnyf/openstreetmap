function [intersection_node_indices] = ...
                    get_unique_node_xy(parsed_osm, intersection_node_indices)
% File:         get_unique_node_xy.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.20 - 2012.04.24
% Language:     MATLAB R2011b
% Purpose:      get the x,y coordinates of unique nodes at road
%               intersections
% Copyright:    Ioannis Filippidis, 2010-

ids = parsed_osm.node.xy(:, intersection_node_indices);
xys = parsed_osm.node.xy(:, intersection_node_indices);

intersection_node_indices.id = ids;
intersection_node_indices.xys = xys;