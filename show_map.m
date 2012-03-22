function [] = show_map(ax, bounds, map_img_filename)
%
% See also PLOT_WAY.
%
% File:         show_map.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.21 - 2012.03.22
% Language:     MATLAB R2011b
% Purpose:      plot raster map in figure
% Copyright:    Ioannis Filippidis, 2010-

hold(ax, 'on')

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
axis(ax, [bounds(1,1) bounds(1,2) bounds(2,1) bounds(2,2)])