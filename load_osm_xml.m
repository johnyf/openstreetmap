function [map_osm] = load_osm_xml(filename)
% download OpenStreetMap XML Data file to be parsed from:
%   http://www.openstreetmap.org/
%
% dependency
%   xml2struct, File Exchange ID = 28518, (c) 2010 by Wouter Falkena
%   http://www.mathworks.com/matlabcentral/fileexchange/28518-xml2struct
%
% See also PARSE_OPENSTREETMAP, PARSE_OSM.
%
% File:         load_osm_xml.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.06 - 
% Language:     MATLAB R2011b
% Purpose:      load OpenStreetMap XML file contents as a MATLAB structure
% Copyright:    Ioannis Filippidis, 2010-

if ~ischar(filename)
    error('Filename should be a string.')
end

if ~strfind(filename, '.osm')
    warning('Filename does not have the extension .osm')
end

map_osm = xml2struct(filename); % downloaded osm file
