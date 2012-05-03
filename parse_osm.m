function [parsed_osm] = parse_osm(osm_xml)
%PARSE_OSM  Creates new structure from loaded OSM XML structure.
%   parsed_osm = PARSE_OSM(osm_xml) takes as input a MATLAB structure
%   osm_xml containing the XML data loaded from an OpenStreetMap file using
%   function load_osm_xml, and returns another MATLAB structure containing
%   a subset of these data parsed appropriately for further usage by other
%   functions.
%
% See also PARSE_OPENSTREETMAP, LOAD_OSM_XML.
%
% File:         parse_osm.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.20 - 2012.05.03
% Language:     MATLAB R2012a
% Purpose:      parse loaded OpenStreetMap xml structure
% Copyright:    Ioannis Filippidis, 2010-

parsed_osm.bounds = parse_bounds(osm_xml.bounds);
parsed_osm.node = parse_node(osm_xml.node);
parsed_osm.way = parse_way(osm_xml.way);
%parsed_osm.relation = parse_relation(osm.relation);
parsed_osm.Attributes = osm_xml.Attributes;

function [parsed_bounds] = parse_bounds(bounds)
bounds = bounds.Attributes;

ymax = str2double(bounds.maxlat);
xmax = str2double(bounds.maxlon);
ymin = str2double(bounds.minlat);
xmin = str2double(bounds.minlon);

parsed_bounds = [xmin, xmax; ymin, ymax];

function [parsed_node] = parse_node(node)
Nnodes = size(node,2);

id = zeros(1, Nnodes);
xy = zeros(2, Nnodes);
for i=1:Nnodes
    id(1,i) = str2double(node{i}.Attributes.id);
    xy(:,i) = [str2double(node{i}.Attributes.lon);...
               str2double(node{i}.Attributes.lat)];
end
parsed_node.id = id;
parsed_node.xy = xy;

function [parsed_way] = parse_way(way)
Nways = size(way,2);

id = zeros(1, Nways);
nd = cell(1, Nways);
tag = cell(1, Nways);
for i=1:Nways
    waytemp = way{i};
    
    id(1,i) = str2double(waytemp.Attributes.id);
    
    Nnd = size(waytemp.nd, 2);
    ndtemp = zeros(1, Nnd);
    for j=1:Nnd
        ndtemp(1, j) = str2double(waytemp.nd{j}.Attributes.ref);
    end
    nd{1, i} = ndtemp;
    
    % way with or without tag(s) ?
    if isfield(waytemp, 'tag')
        tag{1, i} = waytemp.tag;
    else
        tag{1, i} = []; % no tags for this way
    end
    
%     Ntag = size(waytemp.tag,2);
%     for k=1:Ntag
%         if(strcmp(waytemp.tag{k}.Attributes.k,'name'))
%             tag{1,i} = gr2gren(waytemp.tag{k}.Attributes.v);
%         end
%     end
end
parsed_way.id = id;
parsed_way.nd = nd;
parsed_way.tag = tag;

function [parsed_relation] = parse_relation(relation)
Nrelation = size(relation, 2);

id = zeros(1,Nrelation);
%member = cell(1, Nrelation);
%tag = cell(1, Nrelation);
for i = 1:Nrelation
    currelation = relation{i};
    
    curid = currelation.Attributes.id;
    id(1, i) = str2double(curid);
end

parsed_relation.id = id;
