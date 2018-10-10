(function (glob) {
    "use strict";
    glob.toggle_panel = function (el_id) {
        var el = document.getElementById(el_id),
            indicator_el = document.getElementById(el_id + "_indicator"),
            hint_el = document.getElementById(el_id + "_hint"),
            hiding_now = (el.style.display !== "none");
        el.style.display = hiding_now ? "none" : "";
        hint_el.innerHTML = hiding_now ? "..." : ":";
        indicator_el.innerHTML = hiding_now ? "&dArr;" : "&uArr;";
        return null;
    };

    function is_numeric(n) {
        return n - parseFloat(n) >= 0;
    }

    function escape_html(unsafe_string) {
        return unsafe_string
             .replace(/&/g, "&amp;")
             .replace(/</g, "&lt;")
             .replace(/>/g, "&gt;")
             .replace(/"/g, "&quot;")
             .replace(/'/g, "&#039;");
    }

    function remove_zeroes(number_string) {
        return number_string
            .replace(/(\.\d*?)0+$/, '$1')
            .replace(/\.$/, '');  // If no digits remain, remove the '.' as well.
    }

    function radio_value(radio_input_name) {
        var radio_result = '';

        Array.prototype.slice.call(document.getElementsByName(radio_input_name))
            .forEach(function (radio_option) {
                if (radio_option.checked) { radio_result = radio_option.value; }
            });
        return radio_result;
    }



    function make_diagram_blank(w, h, background_color) {
        document.getElementById('chart').innerHTML =
            '<svg id="target_svg" height="' + h + '" width="' + w + '" '
            + 'xmlns="http://www.w3.org/2000/svg" version="1.1" '
            + 'style="background-color: ' + background_color + '"></svg>';
        return;
    }

    function contains(a, obj) {
        var i = a.length;
        while (i--) {
            if (a[i] === obj) {
                return true;
            }
        }
        return false;
    }


    function componentToHex(c) {
        var hex = c.toString(16);
        return hex.length == 1 ? "0" + hex : hex;
    }

    function rgbToHex(r, g, b) {
        return "#" + componentToHex(r) + componentToHex(g) + componentToHex(b);
    }

    //function check_color_converter() {


    //    alert(rgbToHex(0, 51, 255)); // #0033ff


    //    function hexToRgb(hex) {
    //        var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    //        return result ? {
    //            r: parseInt(result[1], 16),
    //            g: parseInt(result[2], 16),
    //            b: parseInt(result[3], 16)
    //        } : null;
    //    }

    //    alert(hexToRgb("#0033ff").g); // "51";
    //}

    function hex2rgb(hex) {
        // long version
        var r;
        r = hex.match(/^#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/i);
        if (r) {
            return r.slice(1, 4).map(function (x) { return parseInt(x, 16); });
        }
        // short version
        r = hex.match(/^#([0-9a-f])([0-9a-f])([0-9a-f])$/i);
        if (r) {
            return r.slice(1, 4).map(function (x) { return 0x11 * parseInt(x, 16); });
        }
        return null;
    }


    function readNodeProperties(bad_lines) {

        //alert(hex2rgb("#0033ff"));

        var source_lines1 = [], good_flows = [], matches = [], line_ix = 0, line_in = '', amount_in = 0, good_node_lines = [];
        var node_colors = [], node_orientations = [], node_width = [], node_height = [], node_position_x = [], node_position_y = [], each_properties = {}, all_properties = [];

        var raw_source = document.getElementById("input_node_data");

        source_lines1 = raw_source.value.split("\n");

        for (line_ix = 0; line_ix < 500; line_ix += 1) {
            line_in = source_lines1[line_ix].trim();
            if (line_in == "")
                break;
            matches = line_in.match(/\[([^\]]*)\]/g);
            if (matches.length < 7) {
                var line_number = parseInt(line_ix) + 1;
                bad_lines.push("You may have entered wrong data format in node values at line " + line_number + " \n ");
                //raw_source.style.color = "red";               
                break;
            }
            var rgb_values = matches[1].slice(2, -2).split(',');


            each_properties = {
                node_name: matches[0].slice(1, -1),
                node_colors: rgbToHex(parseInt(rgb_values[0]), parseInt(rgb_values[1]), parseInt(rgb_values[2])),
                node_orientations: parseInt(matches[2].slice(1, -1)),
                node_width: parseInt(matches[3].slice(1, -1)),
                node_height: parseInt(matches[4].slice(1, -1)),
                node_position_x: parseInt(matches[5].slice(1, -1)),
                node_position_y: parseInt(matches[6].slice(1, -1))
            };
            all_properties.push(each_properties);
            //node_colors.push(rgbToHex(0, 51, 255));
            node_colors.push(rgbToHex(parseInt(rgb_values[0]), parseInt(rgb_values[1]), parseInt(rgb_values[2])));
            node_orientations.push(parseInt(matches[2].slice(1, -1)));
            node_width.push(parseInt(matches[3].slice(1, -1)));
            node_height.push(parseInt(matches[4].slice(1, -1)));
            node_position_x.push(parseInt(matches[5].slice(1, -1)));
            node_position_y.push(parseInt(matches[6].slice(1, -1)));

        }


        return [node_colors, node_orientations, node_width, node_height, node_position_x, node_position_y];
    }

    function read_node_properties(bad_lines) {

        var source_lines1 = [], good_flows = [], matches = [], line_ix = 0, line_in = '', amount_in = 0, good_node_lines = [];
        var node_colors = [], node_orientations = [], node_width = [], node_height = [], node_position_x = [], node_position_y = [], each_properties = {}, all_properties = [];

        var raw_source = document.getElementById("input_node_data");
        var single_node = {}, all_nodes = [];
        source_lines1 = raw_source.value.split("\n");

        for (line_ix = 0; line_ix < 500; line_ix += 1) {
            line_in = source_lines1[line_ix].trim();
            if (line_in == "")
                break;
            matches = line_in.match(/\[([^\]]*)\]/g);
            if (matches.length < 7) {
                var line_number = parseInt(line_ix) + 1;
                bad_lines.push("You may have entered wrong data format in node values at line " + line_number + " \n ");
                break;
            }
            var rgb_values = matches[1].slice(2, -2).split(',');

            single_node = {
                node_name: matches[0].slice(1, -1),
                node_colors: rgbToHex(parseInt(rgb_values[0]), parseInt(rgb_values[1]), parseInt(rgb_values[2])),
                node_orientations: parseInt(matches[2].slice(1, -1)),
                node_width: parseInt(matches[3].slice(1, -1)),
                node_height: parseInt(matches[4].slice(1, -1)),
                node_position_x: parseInt(matches[5].slice(1, -1)),
                node_position_y: parseInt(matches[6].slice(1, -1))
            };
            all_nodes.push(single_node);
        }

        return all_nodes;
    }

    function render_sankey(nodes_in, input_flow_data, data_set) {
        var graph_width, graph_height, colorset, units_format, d3_color_scale, svg, sankey, link, node, nodeType, rotateAngle,
            node_width = data_set.node_width,
            node_padding = data_set.node_padding,
            total_width = data_set.canvas_width,
            total_height = data_set.canvas_height,
            margin_top = data_set.top_margin,
            margin_bottom = data_set.bottom_margin,
            margin_left = data_set.left_margin,
            margin_right = data_set.right_margin,
            curv = data_set.curvature;

        data_set.unit_prefix =
            (typeof data_set.unit_prefix === "undefined"
                || data_set.unit_prefix === null)
                ? "" : data_set.unit_prefix;
        data_set.unit_suffix =
            (typeof data_set.unit_suffix === "undefined"
                || data_set.unit_suffix === null)
                ? "" : data_set.unit_suffix;

        nodeType = data_set.default_node_type;
        rotateAngle = data_set.default_rotate_angle;
        colorset = data_set.default_node_colorset;
        d3_color_scale
            = colorset === "A" ? d3.scale.category20()
            : colorset === "B" ? d3.scale.category20b()
            : d3.scale.category20c();

        nodes_in.forEach(function (node) {
            if (typeof node.color === 'undefined' || node.color === '') {
                if (colorset === "none") {
                    node.color = data_set.default_node_color;
                } else {
                    var first_word = (/^\W*(\w+)/.exec(node.name) || ['', 'not a word'])[1];
                    node.color = d3_color_scale(first_word);
                }
            }
        });

        var json_data = {
            nodes: nodes_in,
            links: input_flow_data
        };

        graph_width = total_width - margin_left - margin_right;
        graph_height = total_height - margin_top - margin_bottom;

        units_format = function (d) {
            var number_portion = d3.format(",." + data_set.max_places + "f")(d);
            return data_set.unit_prefix
                + (data_set.display_full_precision
                    ? number_portion
                    : remove_zeroes(number_portion))
                + data_set.unit_suffix;
        };

        make_diagram_blank(total_width, total_height, data_set.background_color);

        var formatNumber = d3.format(",.0f"),
        format = function (d) { return formatNumber(d) + " " + data_set.unit_name; },
        color = d3.scale.category20();


        var offsetHeight = document.getElementById('div_svg').offsetHeight;
        var offsetWidth = document.getElementById('div_svg').offsetWidth;

        var svg = d3.select("#target_svg")
        .attr("width", offsetWidth)
        .attr("height", offsetHeight)
        .append("g");

        svg.append("rect")
            .attr("width", offsetWidth)
            .attr("height", offsetHeight)
            .attr("fill", data_set.background_color);

        var sankey = d3.sankey()
            .nodeWidth(node_width)
            .nodePadding(node_padding)
            .size([offsetWidth, offsetHeight])
            .nodes(json_data.nodes)
            .links(json_data.links)
            .layout(32)
            .curvature(curv);

        var highest_node = 0;
        var enableDrag = true;

        //if (document.getElementById("enable_drag").checked)
        //    enableDrag = true;
        //else
        //    enableDrag = false;


        svg.append("text")
        .attr("x", 5)
        .attr("y", 15)
        .attr("text-anchor", "left")
        .style("font-size", "12px")
        .style("font-family", "sans-serif")
        .text(document.getElementById("txtproject_name").value + " || " + document.getElementById("txtRemarks").value);


        json_data.nodes.forEach(function (node) {

            if (highest_node < node.value)
                highest_node = node.value;
            else
                highest_node = highest_node;


        });


        var path = sankey.link();
        //alert((parseFloat(data_set.flow_width) + 0.10))

        link = svg.append("g").selectAll(".link")
        .data(json_data.links)
        .enter()
        .append("path")
        .attr("class", "link")
        .attr("d", path) // embed coordinates
        .style("fill", "none") // ensure no line gets drawn, just stroke
        .style("stroke-width", function (d) {
            
            return (Math.max(1, d.dy) * (parseFloat(data_set.flow_width) + 0.10));
        })
        // custom stroke color; defaulting to gray if not specified:
        .style("stroke", function (d) {
            // Priority order:
            // 1. color defined specifically for the flow
            // 2. single-inherit-from-source (or target)
            // 3. all-inherit-from-source (or target)
            // 4. default flow color
            return d.color ? d.color
                : d.source.inherit_right ? d.source.color
                : d.target.inherit_left ? d.target.color
                : data_set.default_flow_inherit === "source" ? d.source.color
                : data_set.default_flow_inherit === "target" ? d.target.color
                : data_set.default_flow_color;
        })
        .style("stroke-opacity", function (d) {
            return d.opacity || data_set.default_flow_opacity;
        })
        // add hover behavior:
        .on('mouseover', function (d) {
            d3.select(this).style("stroke-opacity",
                d.opacity_on_hover
                || ((Number(data_set.default_flow_opacity) + 1) / 2));
        })
        .on('mouseout', function (d) {
            d3.select(this).style("stroke-opacity",
                d.opacity || data_set.default_flow_opacity);
        })
        // sets the order of display, seems like:
        .sort(function (a, b) { return b.dy - a.dy; });

        // TODO make tooltips a separate option
        if (data_set.show_labels) {
            link.append("title") // Make tooltips for FLOWS
                .text(function (d) {
                    return d.source.name + " → " + d.target.name + "\n"
                        + units_format(d.value);
                });
        }

        node = svg.append("g").selectAll(".node")
        .data(json_data.nodes)
        .enter()
        .append("g")
        .attr("class", "node")
        .attr("transform", function (d) { return "translate(" + d.x + "," + d.y + ")"; })
        .call(d3.behavior.drag()
            .origin(function (d) { return d; })
            .on("dragstart", function () { this.parentNode.appendChild(this); })
            .on("drag", dragmove)
            );

        // Construct the actual rectangles for NODEs:
        node.append("rect")
            .attr("width", function (d) {
                return d.node_width_c;
            })
                .attr("height", function (d) {
                    
                    //alert(Math.floor((d.value / highest_node) * offsetHeight * .195 * (data_set.node_height)));
                    return Math.floor((d.value / highest_node) * offsetHeight * .195 * (data_set.node_height));
                    //return d.dy;
                })
                .attr("transform", function (d) {
                    return "rotate(" + d.angle + ")"
                })
            // Give a unique ID to each rect that we can reference (for scale calc)
            .attr("id", function (d) { return "r" + d.index; })
            // we made sure above there will be a color defined:
            .style("fill", function (d) { return d.color; })
            .attr("shape-rendering", "crispEdges")
            .style("fill-opacity",
                function (d) {
                    return d.opacity || data_set.default_node_opacity;
                })
            .style("stroke-width", data_set.node_border || 0)
            .style("stroke", function (d) { return d.color; })
            .append("title")    // Add tooltips for NODES
            .text(
                function (d) {
                    return data_set.show_labels
                        ? d.name + "\n" + units_format(d.value)
                        : "";
                });

        node.append("text")
        // x,y = offsets relative to the node rectangle
        .attr("x", -6)
        .attr("y", function (d) { return d.dy / 2; })
        .attr("dy", ".35em")
        .attr("text-anchor", "end")
        .attr("transform", null)
        .text(
            function (d) {
                return data_set.show_labels
                    ? d.name
                        + (data_set.include_values_in_node_labels
                            ? ": " + units_format(d.value)
                            : "")
                    : "";
            })
        .style({   // be explicit about the font specs:
            "stroke-width": "0", // positive stroke-width makes letters fuzzy
            "font-family": data_set.font_face,
            "font-size": data_set.font_size + "px",
            "font-weight": data_set.font_weight,
            fill: data_set.font_color
        })
        // In the left half of the picture, place labels to the RIGHT of nodes:
        .filter(function (d) {
            // If the x-coordinate of the data point is less than half the width
            // of the graph, relocate the label to begin to the right of the
            // node.
            // Adjusted x by a node_width to bias the very middle of the graph
            // to put labels on the left.
            return (d.x + node_width) < (graph_width / 2);
        })
        .attr("x", 6 + node_width)
        .attr("text-anchor", "start");


        function show_node_properties(d) {
            document.getElementById("PopupDivNode").style.display = 'inline';
        }

        function rotate(d) {
            document.getElementById("dAngle").style.display = 'inline';

            d3.select("#nAngle").on("input", function () {
                update(+this.value);
            });

            update(0);

            function update(nAngle) {
                d3.select("#nAngle-value").text(nAngle);
                d3.select("#nAngle").property("value", nAngle);
                d3.select("rect").attr("transform", "translate(" + d.x + " " + d.y + ") rotate( " + nAngle + " )");

                sankey.relayout();
                link.attr("d", path);
                //glob.render_updated_png();
            }

        }

        function dragmove(d) {
            d.x = Math.max(0, Math.min(graph_width - d.dx, d3.event.x));
            d.y = Math.max(0, Math.min(graph_height - d.dy, d3.event.y));

            d3.select(this).attr("transform", "translate(" + d.x + "," + d.y + ")");
            getNewData(d);
            sankey.relayout();
            link.attr("d", path);
            //glob.render_updated_png();
        }


        function getNewData(d) {
            document.getElementById("input_node_data").value = "";
            //var constracted_data_string = d.name + " " + "[" + d.color + "]" + " " + "[" + d.angle + "]" + " " + "[" + d.dx.toFixed(2) + "]" + " " + "[" + d.dy.toFixed(2) + "]" + " " + "[" + d.x + "]" + " " + "[" + d.y + "]";
            for (var i = 0; i < json_data.nodes.length; i++) {
                var data_string = "[" + json_data.nodes[i].name + "]" + " " + "[(" + hex2rgb(json_data.nodes[i].color) + ")]" + " " + "[" + json_data.nodes[i].angle + "]" + " " + "[" + json_data.nodes[i].dx.toFixed(2) + "]" + " " + "[" + json_data.nodes[i].dy.toFixed(2) + "]" + " " + "[" + json_data.nodes[i].x + "]" + " " + "[" + json_data.nodes[i].y + "]";
                document.getElementById("input_node_data").value += data_string + "\n";
            }

        }
    }


    function read_node_properties(bad_lines) {
        var source_lines = [], good_flows = [], matches = [], line_ix = 0, line_in = '', amount_in = 0, good_node_lines = [], single_node = {}, all_nodes = [];
        var raw_source = document.getElementById("input_node_data");
        source_lines = raw_source.value.split("\n");
        var node_index = 0;
        for (line_ix = 0; line_ix < source_lines.length; line_ix += 1) {
            line_in = source_lines[line_ix].trim();
            if (line_in == "")
                break;
            matches = line_in.match(/\[([^\]]*)\]/g);
            if (matches.length < 7) {
                var line_number = parseInt(line_ix) + 1;
                bad_lines.push("You may have entered wrong data format in node values at line " + line_number + ". Please check this line - " + line_in + " \n ");
                //break;
            }
            else {
                var rgb_values = matches[1].slice(2, -2).split(',');

                single_node = {
                    node: node_index,
                    node_name: matches[0].slice(1, -1),
                    node_color: rgbToHex(parseInt(rgb_values[0]), parseInt(rgb_values[1]), parseInt(rgb_values[2])),
                    node_orientation: parseInt(matches[2].slice(1, -1)),
                    node_width: parseInt(matches[3].slice(1, -1)),
                    node_height: parseInt(matches[4].slice(1, -1)),
                    node_position_x: parseInt(matches[5].slice(1, -1)),
                    node_position_y: parseInt(matches[6].slice(1, -1))
                };
                node_index++;
                all_nodes.push(single_node);
            }

        }

        return all_nodes;
    }

    function read_flow_properties(all_nodes, bad_lines) {

        var source_lines = [], good_flows = [], matches = [], line_ix = 0, line_in = '', amount_in = 0, good_node_lines = [], single_flow = {}, all_flows = [];
        var raw_source = document.getElementById("input_flow_data");
        source_lines = raw_source.value.split("\n");

        for (line_ix = 0; line_ix < source_lines.length; line_ix += 1) {
            line_in = source_lines[line_ix].trim();
            if (line_in.match(/^'/)) {
                continue;
            }
            matches = line_in.match(/\[([^\]]*)\]/g);

            if (matches !== null && matches.length == 5) {
                amount_in = matches[1].replace(/[\[\]']+/g, '');     //(/\s/g, '');
                var rgb_values = matches[2].slice(2, -2).split(',');
                if (!is_numeric(amount_in)) {
                    bad_lines.push("Value is not a valid decimal number at line " + line_ix + " of flow values" + ". Please check this line - " + line_in + " \n ");
                } else if (amount_in <= 0) {
                    bad_lines.push("Value must be greater than 0 at line " + line_ix + " of flow values" + " . Please check this line - " + line_in + " \n ");
                } else {

                    if (!all_nodes.filter(function (e) { return e.node_name == matches[0].trim().slice(1, -1); }).length > 0) {
                        bad_lines.push("This source node " + matches[0].trim() + " is not defined in node properties" + " \n ");
                    }
                    else if (!all_nodes.filter(function (e) { return e.node_name == matches[4].trim().slice(1, -1); }).length > 0) {
                        bad_lines.push("This target node " + matches[4].trim() + " is not defined in node properties" + " \n ");
                    }
                    else {
                        single_flow = {
                            source: matches[0].trim(),
                            target: matches[4].trim(),    // 2 before adding color
                            f_color: rgbToHex(parseInt(rgb_values[0]), parseInt(rgb_values[1]), parseInt(rgb_values[2])),
                            amount: amount_in
                        };
                        all_flows.push(single_flow);
                    }


                }
            } else if (line_in !== '' && matches.length != 5) {

                bad_lines.push("The line is not in the format: [Source] [Amount] [Color] [ab] [Target] at line " + line_ix + " of flow values." + " Please check this line - " + line_in + " \n ");
            }

        }
        return all_flows;
    }




    glob.process_sankey = function () {
        var source_lines = [], good_flows = [], good_node_lines = [],
           bad_lines = [], node_order = [], line_ix = 0, line_in = '', line_in_angle = '', line_ix_angle = 0, matches_angle = 0, source_lines_angle = [],
           unique_nodes = {}, matches = [], amount_in = 0,
           do_cross_checking = 1, cross_check_error_ct = 0,
           approved_nodes = [], approved_flows = [], approved_data = {},
           total_inflow = 0, total_outflow = 0, max_places = 0,
           epsilon_difference = 0, status_message = '', total_difference = 0,
           reverse_the_graph = 0,
           max_node_index = 0, max_node_val = 0, flow_inherit = '',
           colorset_in = '', fontface_in = '', nodeType_in = '', rotateAngle_in = '',
           chart_el = document.getElementById("chart"),
           messages_el = document.getElementById("messages_area"),
           raw_source = document.getElementById("input_flow_data").value;

        approved_data = {
            unit_prefix: "",
            unit_suffix: "",
            max_places: max_places,
            display_full_precision: 1,
            include_values_in_node_labels: 0,
            show_labels: 1,
            canvas_width: 1300,
            canvas_height: 750,
            font_size: 15,
            font_weight: 400,
            top_margin: 12, right_margin: 12, bottom_margin: 12, left_margin: 12,
            default_flow_opacity: 0.5,
            node_height: 0.5,
            flow_width:0.5,
            default_node_opacity: 0.9,
            default_flow_width: 1,
            node_width: 20,
            node_padding: 12,
            node_border: 0,
            reverse_graph: 0,
            curvature: 0.5,
            default_flow_inherit: "target",
            default_flow_color: "#666666",
            background_color: "#ffffff",
            font_color: "#000000",
            default_node_color: "#006699",
            default_node_colorset: "C",
            default_node_type: "R",
            font_face: "sans-serif",
            default_rotate_angle: 0,
            unit_name: document.getElementById("unit_name").value

        };


        var all_nodes = read_node_properties(bad_lines);
        var all_flows = read_flow_properties(all_nodes, bad_lines);

        all_nodes.forEach(function (single_node) {
            //var this_node = unique_nodes[nodename];
            var readynode = {};
            readynode = {
                name: single_node.node_name,
                node: single_node.node,
                color: single_node.node_color,
                opacity: single_node.default_node_opacity,
                angle: single_node.node_orientation,
                x_position: single_node.node_position_x,
                y_position: single_node.node_position_y,
                node_width_c: single_node.node_width,
                node_height_c: single_node.node_height
            };
            approved_nodes.push(readynode);
        });

        all_flows.forEach(function (flow) {
            var possible_color, possible_nodename, flow_color = "", tmp = "",
                opacity = "", opacity_on_hover = "", flow_struct = {};
            matches = flow.target.match(/^(.+)\s+(#\S+)$/);

            save_node(flow.source);
            save_node(flow.target);

            flow_struct = {
                source: unique_nodes[flow.source].node,
                target: unique_nodes[flow.target].node,
                value: flow.amount,
                color: flow.f_color,
                opacity: opacity,
                opacity_on_hover: opacity_on_hover
            };

            approved_flows.push(flow_struct);
            unique_nodes[flow.source].from_sum += Number(flow.amount);
            unique_nodes[flow.source].from_list.push(flow.amount);
            unique_nodes[flow.target].to_sum += Number(flow.amount);
            unique_nodes[flow.target].to_list.push(flow.amount);
        });

        function save_node(nodename, nodeparams) {
            var node_index = 0;
            if (!unique_nodes.hasOwnProperty(nodename)) {
                all_nodes.forEach(function (single_node) {
                    if (nodename.slice(1, -1) == single_node.node_name) {
                        node_index = single_node.node;
                        //alert(node_index)

                    }


                });
                unique_nodes[nodename] = {
                    from_sum: 0, to_sum: 0,
                    from_list: [], to_list: [],
                    node: node_index
                };

            }
            if (typeof nodeparams === "object") {
                Object.keys(nodeparams).forEach(function (p) {
                    if (nodeparams[p] !== null && nodeparams[p] !== "") {
                        unique_nodes[nodename][p] = nodeparams[p];
                    }
                });
            }
        }





        function reset_field(field_name) {
            document.getElementById(field_name).value = approved_data[field_name];
        }

        function get_color_input(field_name) {
            var field_el = document.getElementById(field_name),
                field_val = field_el.value;
            if (field_val.match(/^#(?:[a-f0-9]{3}|[a-f0-9]{6})$/i)) {
                approved_data[field_name] = field_val;
            } else if (field_val.match(/^(?:[a-f0-9]{3}|[a-f0-9]{6})$/i)) {
                field_val = '#' + field_val;
                approved_data[field_name] = field_val;
                field_el.value = field_val;
            } else {
                reset_field(field_name);
            }
        }

        document.getElementById("spnOutputMessage").innerText = '';

        bad_lines.forEach(function (parse_error) {
            document.getElementById("spnOutputMessage").innerText += parse_error;
        });

        (["background_color", "font_color"]).forEach(function (field_name) {

            get_color_input(field_name);
        });

        function get_color_input(field_name) {
            var field_el = document.getElementById(field_name),
                field_val = field_el.value;
            // console.log(field_name, field_val, typeof field_val);
            if (field_val.match(/^#(?:[a-f0-9]{3}|[a-f0-9]{6})$/i)) {
                approved_data[field_name] = field_val;
            } else if (field_val.match(/^(?:[a-f0-9]{3}|[a-f0-9]{6})$/i)) {
                // Forgive colors with missing #:
                field_val = '#' + field_val;
                approved_data[field_name] = field_val;
                field_el.value = field_val;
            } else {
                reset_field(field_name);
            }
        }

        chart_el.style.height = approved_data.canvas_height + "px";
        chart_el.style.width = approved_data.canvas_width + "px";

        (["canvas_width", "canvas_height", "node_width", "node_border", "font_size", "font_face"]).forEach(function (field_name) {
            var field_val = document.getElementById(field_name).value;
            if (field_val.length < 10 && field_val.match(/^\d+$/)) {

                approved_data[field_name] = Number(field_val);
            } else {
                reset_field(field_name);
            }
        });

        (["default_node_opacity", "default_flow_opacity", "curvature", "node_height", "flow_width"]).forEach(function (field_name) {
            var field_val = document.getElementById(field_name).value;
            if (field_val.match(/^\d(?:.\d+)?$/)) {
                approved_data[field_name] = '.' + field_val;


            } else {
                reset_field(field_name);
            }
        });

        if (all_flows.length === 0) {
            make_diagram_blank(
                approved_data.canvas_width,
                approved_data.canvas_height,
                approved_data.background_color);
            return null;
        }


        // Checkboxes:
        (["show_labels"]).forEach(function (field_name) {
            approved_data[field_name] = document.getElementById(field_name).checked;
        });

        nodeType_in = radio_value("default_node_type");
        if (nodeType_in.match(/^(?:[ABC]|none)$/)) {
            approved_data.default_node_type = nodeType_in;
        }

        fontface_in = radio_value("font_face");
        if (fontface_in.match(/^(?:serif|sans-serif|monospace)$/)) {
            approved_data.font_face = fontface_in;
        }

        render_sankey(approved_nodes, approved_flows, approved_data);

        return null;
    };

}(window === 'undefined' ? global : window));