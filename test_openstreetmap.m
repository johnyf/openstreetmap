% test script for OpenStreetMap toolbox
openstreetmap_filename = 'test_map.osm';
[parsed_osm] = parse_openstreetmap(openstreetmap_filename);
ax = gca;
plot_way(ax, parsed_osm)
%plot_way(ax, parsed_osm, map_img_filename) % if you also have a raster image
[connectivity_matrix, intersection_nodes] = extract_connectivity(parsed_osm);
[uniquend] = get_unique_node_xy(parsed_osm, intersection_nodes);
