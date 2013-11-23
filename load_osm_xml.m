function [map_osm] = load_osm_xml(filename)
% load OpenStreetMap XML file contents as a MATLAB structure
%
% download OpenStreetMap XML Data file to be parsed from:
%   http://www.openstreetmap.org/
%
% dependency
%   xml2struct, File Exchange ID = 28518, (c) 2010 by Wouter Falkena
%   http://www.mathworks.com/matlabcentral/fileexchange/28518-xml2struct
%
% note
%   xml2struct renamed to xml2struct_fex28518 to avoid name conflicts
%   with matlab bioinformatics toolbox
%
% 2010.11.06 (c) Ioannis Filippidis, jfilippidis@gmail.com
%
% See also PARSE_OPENSTREETMAP, PARSE_OSM.

if ~ischar(filename)
    error('Filename should be a string.')
end

if ~strfind(filename, '.osm')
    warning('Filename does not have the extension .osm')
end

map_osm = xml2struct_fex28518(filename); % downloaded osm file
