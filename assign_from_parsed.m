function [bounds, node, way, relation] = assign_from_parsed(parsed_osm)
%
% See also PLOT_WAY, EXTRACT_CONNECTIVITY.
%
% File:         assign_from_parsed.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.20
% Language:     MATLAB R2011b
% Purpose:      assign from parsed osm structure
% Copyright:    Ioannis Filippidis, 2010-

disp('Parsed OpenStreetMap given.')

bounds = parsed_osm.bounds;
node = parsed_osm.node;
way = parsed_osm.way;
relation = []; %parsed_osm.relation;
