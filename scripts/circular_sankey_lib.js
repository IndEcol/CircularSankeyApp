d3.sankey = function () {
    var sankey = {},
        nodeWidth = 24,
        nodePadding = 8,
        size = [1, 1],
        nodes = [],
        links = [],
        curvature=.5;

    sankey.nodeWidth = function (_) {
        if (!arguments.length) return nodeWidth;
        nodeWidth = +_;
        return sankey;
    };

    sankey.nodePadding = function (_) {
        if (!arguments.length) return nodePadding;
        nodePadding = +_;
        return sankey;
    };

    sankey.nodes = function (_) {
        if (!arguments.length) return nodes;
        nodes = _;
        return sankey;
    };

    sankey.links = function (_) {
        if (!arguments.length) return links;
        links = _;
        return sankey;
    };

    sankey.size = function (_) {
        if (!arguments.length) return size;
        size = _;
        return sankey;
    };
    sankey.curvature = function (_) {
        if (!arguments.length) return curvature;
        curvature = _;
        return sankey;
    };

    sankey.layout = function (iterations) {
        computeNodeLinks();
        computeNodeValues();
        computeNodeBreadths();
        computeNodeDepths(iterations);
        computeLinkDepths();
        return sankey;
    };

    sankey.relayout = function () {
        computeLinkDepths();
        return sankey;
    };

    sankey.link = function () {

        function link(d) {
            var x0 = d.source.x + d.source.dx,          // d.source.x is the x position of source node and d.source.dx is the width source node
                x1 = d.target.x,                        // d.target.x is the x position of target node
                xi = d3.interpolateNumber(x0, x1),      // interpolate between x0 and x1
                y0 = d.source.y + d.sy + d.dy / 2,      // d.sy is calculated based on link widh and how many links are associated with each source node and d.dy is the height of node
                y1 = d.target.y + d.ty + d.dy / 2,      // d.ty is calculated based on link widh and how many links are associated with each target node

                x_2 = d.source.x + (d.source.dx * Math.cos((Math.PI / 180) * d.source.angle)),      // x2_source = d.source.x + (node_width * cosθ)
                y_2 = d.source.y + (d.source.dx * Math.sin((Math.PI / 180) * d.source.angle)),      // y2_source = d.source.y + (node_width * sinθ)
                x0_r = x_2 - ((d.sy + d.dy / 2) * Math.sin((Math.PI / 180) * d.source.angle)),      // final x0_r from x2_source with the value of d.sy and d.dy
                y0_r = y_2 + ((d.sy + d.dy / 2) * Math.cos((Math.PI / 180) * d.source.angle)),      // final y0_r from x2_source with the value of d.sy and d.dy

                x_2_t = d.target.x + (Math.cos((Math.PI / 180) * d.target.angle)),                  // x_2_t_target = d.target.x + (cosθ)
                y_2_t = d.target.y + (Math.sin((Math.PI / 180) * d.target.angle)),                  // y_2_t_target = d.target.y + (sinθ)
                x1_r = x_2_t - ((d.ty + d.dy / 2) * Math.sin((Math.PI / 180) * d.target.angle)),    // final x1_r from x_2_t_target with the value of d.ty and d.dy
                y1_r = y_2_t + ((d.ty + d.dy / 2) * Math.cos((Math.PI / 180) * d.target.angle)),    // final y1_r from y_2_t_target with the value of d.ty and d.dy

                distance = Math.sqrt((x0 - x1) * (x0 - x1) + (y0 - y1) * (y0 - y1))                 // Euclidien distance between source and target

                x2 = x0_r + Math.cos((Math.PI / 180) * d.source.angle) * distance * curvature,          // x position for source control point 
                y0_r_r = y0_r + Math.sin((Math.PI / 180) * d.source.angle) * distance * curvature,      // Y position for source control point 
                x3 = x1_r + Math.cos((Math.PI / 180) * (d.target.angle + 180)) * distance * curvature,      // x position for target control point 
                y1_r_r = y1_r + Math.sin((Math.PI / 180) * (d.target.angle + 180)) * distance * curvature;      // y position for target control point 

                return "M" + x0_r + "," + y0_r
                 + "C" + x2 + "," + y0_r_r
                 + " " + x3 + "," + y1_r_r
                 + " " + x1_r + "," + y1_r;
            }

        link.curvature = function (_) {
            if (!arguments.length) return curvature;
            curvature = +_;
            return link;
        };

        return link;
    };

    // Populate the sourceLinks and targetLinks for each node.
    // Also, if the source and target are not objects, assume they are indices.
    function computeNodeLinks() {
        nodes.forEach(function (node) {
            node.sourceLinks = [];
            node.targetLinks = [];
        });
        links.forEach(function (link) {
            var source = link.source,
                target = link.target;

            if (typeof source === "number") {
                source = link.source = nodes[link.source]

            };
            if (typeof target === "number") target = link.target = nodes[link.target];
            source.sourceLinks.push(link);
            target.targetLinks.push(link);


        });
    }

     //Compute the value (size) of each node by summing the associated links.
    function computeNodeValues() {
        nodes.forEach(function (node) {
            node.value = Math.max(
              d3.sum(node.sourceLinks, value),
              d3.sum(node.targetLinks, value)
            );
        });
    }


    //function computeNodeValues() {
    //    nodes.forEach(function (node) {
    //        node.value = node.node_height_c;
    //    });

    //}

    // Iteratively assign the breadth (x-position) for each node.
    // Nodes are assigned the maximum breadth of incoming neighbors plus one;
    // nodes with no incoming links are assigned breadth zero, while
    // nodes with no outgoing links are assigned the maximum breadth.

    function computeNodeBreadths() {

        nodes.forEach(function (node) {
            node.x = node.x_position;
            node.dx = node.node_width_c;
            node.y = node.y_position;
        });
    }

    //function computeNodeBreadths() {
    //    var x = 0;
    //    x1_pos = [50, 200, 50, 50, 400, 400];
    //    y1_pos = [50, 150, 250, 300, 50, 400];

    //    x2_pos = [50, 550, 550, 150, 450, 450];
    //    y2_pos = [150, 500, 550, 150, 450, 450];

    //    nodes.forEach(function (node) {
    //        node.x = x1_pos[x];
    //        node.y = y1_pos[x];
    //        node.dx = nodeWidth;
    //        x++;
    //    });
    //}

    function moveSourcesRight() {
        nodes.forEach(function (node) {
            if (!node.targetLinks.length) {
                node.x = d3.min(node.sourceLinks, function (d) { return d.target.x; }) - 1;

            }
        });
    }

    function computeNodeDepths(iterations) {
        var nodesByBreadth = d3.nest()
            .key(function (d) { return d.x; })
            .sortKeys(d3.ascending)
            .entries(nodes)
            .map(function (d) { return d.values; });

        initializeNodeDepth();
        resolveCollisions();
        for (var alpha = 1; iterations > 0; --iterations) {
            //relaxRightToLeft(alpha *= .99);
            resolveCollisions();
            //relaxLeftToRight(alpha);
            resolveCollisions();
        }

        function initializeNodeDepth() {
            var ky = d3.min(nodesByBreadth, function (nodes) {
                //alert(nodes)
                //alert(d3.sum(nodes, node_height_c));
                return (size[1] - (nodes.length - 1) * nodePadding) / d3.sum(nodes, value);
            });
    
            nodesByBreadth.forEach(function (nodes) {
                nodes.forEach(function (node, i) {

                    node.dy = node.value *(ky*.1);
                });
            });

            links.forEach(function (link) {
                //alert(link.value)
                link.dy = link.value * (ky*.1);
            });

        }

        function relaxLeftToRight(alpha) {
            nodesByBreadth.forEach(function (nodes, breadth) {
                nodes.forEach(function (node) {
                    if (node.targetLinks.length) {
                        var y = d3.sum(node.targetLinks, weightedSource) / d3.sum(node.targetLinks, value);
                        node.y += (y - center(node)) * alpha;
                    }
                });
            });

            function weightedSource(link) {
                return center(link.source) * link.value;
            }
        }

        function relaxRightToLeft(alpha) {
            nodesByBreadth.slice().reverse().forEach(function (nodes) {
                nodes.forEach(function (node) {
                    if (node.sourceLinks.length) {
                        var y = d3.sum(node.sourceLinks, weightedTarget) / d3.sum(node.sourceLinks, value);
                        node.y += (y - center(node)) * alpha;
                    }
                });
            });

            function weightedTarget(link) {
                return center(link.target) * link.value;
            }
        }

        function resolveCollisions() {
            nodesByBreadth.forEach(function (nodes) {
                var node,
                    dy,
                    y0 = 0,
                    n = nodes.length,
                    i;

                // Push any overlapping nodes down.
                nodes.sort(ascendingDepth);
                for (i = 0; i < n; ++i) {
                    node = nodes[i];
                    dy = y0 - node.y;
                    if (dy > 0) node.y += dy;
                    y0 = node.y + node.dy + nodePadding;
                }

                // If the bottommost node goes outside the bounds, push it back up.
                dy = y0 - nodePadding - size[1];
                if (dy > 0) {
                    y0 = node.y -= dy;

                    // Push any overlapping nodes back up.
                    for (i = n - 2; i >= 0; --i) {
                        node = nodes[i];
                        dy = node.y + node.dy + nodePadding - y0;
                        if (dy > 0) node.y -= dy;
                        y0 = node.y;
                    }
                }
            });
        }

        function ascendingDepth(a, b) {
            return a.y - b.y;
        }
    }

    function computeLinkDepths() {
        nodes.forEach(function (node) {
            node.sourceLinks.sort(ascendingTargetDepth);
            node.targetLinks.sort(ascendingSourceDepth);
        });
        nodes.forEach(function (node) {
            var sy = 0, ty = 0;
            node.sourceLinks.forEach(function (link) {

                link.sy = sy;
                sy += link.dy;

            });
            node.targetLinks.forEach(function (link) {
                link.ty = ty;
                ty += link.dy;
            });
        });

        function ascendingSourceDepth(a, b) {
            return a.source.y - b.source.y;
        }

        function ascendingTargetDepth(a, b) {
            return a.target.y - b.target.y;
        }
    }

    function center(node) {
        return node.y + node.dy / 2;
    }

    function value(link) {
       
        return link.value;
    }

    return sankey;
};