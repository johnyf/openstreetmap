function [parsed_osm] = main_mapping(varargin)
% handle application map
%
% 2010.11.06 (c) Ioannis Filippidis, jfilippidis@gmail.com

if nargin == 0
    hax = gca;
else
    hax = varargin{1};
end

% remember to parse utf8 to greeklish

%map_osm = load_osm_xml(filename); %(saved as map.mat)
%parsed_osm = parse_osm(map_osm.osm); %(saved as parsed_map.mat)

load parsed_map.mat; % mat file of parsed osm
map_img_filename = 'map-mapnik.png';

plot_way(hax, parsed_osm, map_img_filename);
