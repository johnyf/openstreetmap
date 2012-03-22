function [uniquend] = get_unique_node_xy(parsed_osm, intersection_nodes)
% File:         get_unique_node_xy.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.20
% Language:     MATLAB R2011b
% Purpose:      get the x,y coordinates of unique nodes at road
%               intersections
% Copyright:    Ioannis Filippidis, 2010-

uniquend = parsed_osm.node.xy(:, intersection_nodes);
