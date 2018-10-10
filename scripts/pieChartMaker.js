function dataGenerator() {
    var source_lines = [], good_node_lines = [], bad_lines = [], line_ix = 0, line_in = '', matches = [], amount_in = 0, max_places = 0, good_flows =[],
        raw_source = document.getElementById("input_flow_data").value;

    source_lines = raw_source.split("\n");
    for (line_ix = 0; line_ix < source_lines.length; line_ix += 1) {
        line_in = source_lines[line_ix].trim();
        if (line_in.match(/^'/)) {
            continue;          
        }
        matches = line_in.match(/^:(.+)\ #([0-9A-F]{0,6})?(\.\d{1,4})?\s*(>>|<<)*\s*(>>|<<)*$/i);      
        if (matches !== null) {
            good_node_lines.push(
                {
                    name: matches[1].trim(),
                    color: matches[2],
                    opacity: matches[3],
                    inherit1: matches[4],
                    inherit2: matches[5]
                });
            continue;
        }
        matches = line_in.match(/^(.+)\[([\d\.\s\+\-]+)\]$/);        
        if (matches !== null) {
            amount_in = matches[2].replace(/\s/g, '');
            if (!is_numeric(amount_in)) {
                bad_lines.push(
                    {
                        value: line_in,
                        message: 'The Amount is not a valid decimal number.'
                    });
            } else if (amount_in <= 0) {
                bad_lines.push(
                    {
                        value: line_in,
                        message: 'Amounts must be greater than 0.'
                    });
            } else {
                good_flows.push(
                    {
                        category: matches[1].trim(),
                        amount: amount_in
                    });
                max_places = Math.max(max_places,((amount_in.split(/\./))[1] || '').length);
            }
        } else if (line_in !== '') {
            bad_lines.push(
                {
                    value: line_in,
                    message:
                      'The line is not in the format: Source [Amount] Target'
                }
            );
        }
    }
    var data = [];
    good_flows.forEach(function (flow) {
        data.push({ label: flow.category, value: flow.amount });

    });
    return data;
}

function is_numeric(n) {
    return n - parseFloat(n) >= 0;
}


function pieChartMaker() {
    var data = dataGenerator();
    var color = d3.scale.category20c();

    //var data = [{ "label": "Bio-conversion", "value": 10 },
    //                  { "label": "Liquid", "value": 20 },
    //                  { "label": "Solid", "value": 20 }];

    var graph_width, graph_height, colorset, d3_color_scale,
    show_labels = 1,
    total_width = 500,
    total_height = 500,
    font_size = 13,
    font_weight = 400,
    margin_top = 20, margin_right = 20, margin_bottom = 20, margin_left = 50,
    node_padding = 12,
    node_border = 0,
    background_color = "#FFFFFF",
    font_color = "#000000",
    default_node_color = "#006699",
    default_node_type = "P",
    font_face = "sans-serif",
    default_flow_opacity= 0.4,
    radius = (total_width / 2);

    graph_width = total_width - margin_left - margin_right;
    graph_height = total_height - margin_top - margin_bottom;

    var svg = d3.select("#target_svg").data([data])
     .attr("width", total_width)
     .attr("height", total_height)
     //.attr("style", "margin_left: " + margin_left)
     .attr("style", "background-color: " + background_color)
     .append("g")
     .attr("transform", "translate(" + radius + "," + radius + ")");

    //var vis = d3.select("#target_svg").data([data]).attr("width", w).attr("height", h).append("svg:g").attr("transform", "translate(" + r + "," + r + ")");

    var pie = d3.layout.pie().value(function (d) { return d.value; });
    var arc = d3.svg.arc().outerRadius(radius);
    var arcs = svg.selectAll("g.slice").data(pie).enter().append("svg:g").attr("class", "slice");

    var arcOver = d3.svg.arc()
        .outerRadius(radius + 9);

    arcs.append("svg:path")
        .on('mouseover', function (d) {
            d3.select(this).style("stroke-opacity",
                d.opacity_on_hover
                || ((Number(config_in.default_flow_opacity) + 1) / 2));
        })
        .attr("fill", function (d, i) {
            return color(i);
        })
        .attr("d", function (d) {
            console.log(arc(d));
            return arc(d);
        })
    .on("mouseenter", function (d) {
        d3.select(this)
           .attr("stroke", "white")
           .transition()
           .duration(1000)
           .attr("d", arcOver)
           .attr("stroke-width", 6);
    })
        .on("mouseleave", function (d) {
            d3.select(this).transition()
               .attr("d", arc)
               .attr("stroke", "none");
        });

    arcs.append("svg:text").attr("transform", function (d) {
        d.innerRadius = 0;
        d.outerRadius = radius;
        return "translate(" + arc.centroid(d) + ")";
    }).attr("text-anchor", "middle").text(function (d, i) {
        return data[i].label;
    }
  );
}