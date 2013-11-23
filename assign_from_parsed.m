function [bounds, node, way, relation] = assign_from_parsed(parsed_osm)
% assign from parsed osm structure
%
% See also PLOT_WAY, EXTRACT_CONNECTIVITY.
%
% 2010.11.20 (c) Ioannis Filippidis, jfilippidis@gmail.com

disp('Parsed OpenStreetMap given.')

bounds = parsed_osm.bounds;
node = parsed_osm.node;
way = parsed_osm.way;
relation = []; %parsed_osm.relation;
