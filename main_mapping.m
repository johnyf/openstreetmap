% File:         main_mapping.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.06
% Language:     MATLAB, program version: 7.11 (2010b)
% Purpose:      handle application map
% Copyright:    Ioannis Filippidis, 2010-

function [parsed_osm] = main_mapping(varargin)

if nargin == 0
    hax = gca;
else
    hax = varargin{1};
end

% remember to parse utf8 to greeklish

% map_osm = xml2struct('map.osm'); % downloaded osm file
% [parsed_osm] = parse_osm(map_osm.osm);

% load map.mat; % mat file of loaded xml
% [parsed_osm] = parse_osm(map_osm.osm);

load parsed_map.mat; % mat file of parsed osm

plot_way(hax, parsed_osm);
