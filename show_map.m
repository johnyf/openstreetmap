function [] = show_map(ax, bounds, map_img_filename)
%
% dependency
%   lat_lon_proportions, File Exchange ID = 32462,
%   (c) 2011 by Jonathan Sullivan
%   http://www.mathworks.com/matlabcentral/fileexchange/32462-correctly-proportion-a-latlon-plot
%
% See also PLOT_WAY.
%
% File:         show_map.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.21 - 2012.05.03
% Language:     MATLAB R2012a
% Purpose:      plot raster map in figure and fix plot bounds
% Copyright:    Ioannis Filippidis, 2010-

hold(ax, 'on')

% image provided ?
if ~isempty(map_img_filename)
    map_img = imread(map_img_filename);
    image('Parent', ax, 'CData', flipdim(map_img,1),...
          'XData', bounds(1,1:2), 'YData', bounds(2,1:2))
end

plot(ax, [bounds(1,1), bounds(1,1), bounds(1,2), bounds(1,2), bounds(1,1)],...
         [bounds(2,1), bounds(2,2), bounds(2,2), bounds(2,1), bounds(2,1)],...
         'ro-')

xlabel(ax, 'Longitude (^o)')
ylabel(ax, 'Latitude (^o)')
title(ax, 'OpenStreetMap osm file')

axis(ax, 'image')
axis(ax, [bounds(1, :), bounds(2, :) ] )
lat_lon_proportions(ax)
