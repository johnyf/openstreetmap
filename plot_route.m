function [] = plot_route(ax, path, parsed_osm)
nodexy = parsed_osm.node.xy;
start_xy = nodexy(:, path(1, 1) );
path_xy = nodexy(:, path);
path_end = nodexy(:, path(1, end) );

held = takehold(ax);

plotmd(ax, start_xy, 'Color', 'm', 'Marker', 'o', 'MarkerSize', 15)
plotmd(ax, path_xy, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 5)
plotmd(ax, path_end, 'Color', 'c', 'Marker', 's', 'MarkerSize', 15)

givehold(ax, held)
