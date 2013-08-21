Summary
-------
Load map, extract connectivity, plot road network & find shortest paths from OpenStreetMap `XML` file.

Description
-----------
This software package includes functions for working with OpenStreetMap XML Data files (extension `.osm`), as downloaded from [here](http://www.openstreetmap.org), to:

1. Import and parse the `XML` data file and store the parsed data in a `MATLAB` structure. This data represents the graph of the transportation network.

2. Plot the `MATLAB` structure to get a visualization of the transportation network, its nodes and their labels.

3. Extract the adjacency matrix of the directed graph representing the network's connectivity (i.e., road intersections).

4. Find shortest routes between nodes within the network. Note that distance is measured as the number of transitions between intersection nodes, not over the map.

Download
--------
[Distribution zip](http://www.mathworks.com/matlabcentral/fileexchange/35819-openstreetmap-functions?download=true) from the File Exchange.
Includes dependencies.

Documentation
-------------
Included in `PDF` format in the [distribution zip](http://www.mathworks.com/matlabcentral/fileexchange/35819-openstreetmap-functions?download=true).

Dependencies
------------
- [xml2struct](http://www.mathworks.com/matlabcentral/fileexchange/28518-xml2struct)
- [gaimc: graph algorithms](http://www.mathworks.com/matlabcentral/fileexchange/24134-gaimc-graph-algorithms-in-matlab-code)
- [Lat/Lon aspect ratio](http://www.mathworks.com/matlabcentral/fileexchange/32462-correctly-proportion-a-latlon-plot)
- [plot 2/3d point(s)](http://www.mathworks.com/matlabcentral/fileexchange/34731-plot-23d-points)

License
-------
This package is licensed under the 2-clause BSD license.
The authors of dependencies are included to enable their inclusion for distribution here.