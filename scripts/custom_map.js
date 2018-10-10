

function dataGenerator() {
    var source_lines = [], good_node_lines = [], bad_lines = [], line_ix = 0, line_in = '', matches = [], amount_in = 0, max_places = 0, good_flows = [],
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
                max_places = Math.max(max_places, ((amount_in.split(/\./))[1] || '').length);
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


function selectCountry(countires) {

    var dropDown = d3.select("#countryList");

    var options = dropDown.selectAll("option")
           .data(countires)
         .enter()
           .append("option");

    options.text(function (d) { return d.name; })
           .attr("value", function (d) { return d.id; });

}


function mapMaker3() {
    //var data = dataGenerator();
        //selectCountry();

    var color = d3.scale.category20c();

    var graph_width, graph_height, colorset, d3_color_scale,
    show_labels = 1,
    width = 1300,
    height = 650,
    font_size = 13,
    font_weight = 400,
    margin_top = 0, margin_right = 0, margin_bottom = 0, margin_left = 0,
    node_padding = 12,
    node_border = 0,
    background_color = "#ADD8E6", //B0E0E6
    font_color = "#000000",
    default_node_color = "#006699",
    font_face = "sans-serif",
    chart_el = document.getElementById("chart"),
    default_flow_opacity = 0.4;

    graph_width = width - margin_left - margin_right;
    graph_height = height - margin_top - margin_bottom;

    chart_el.style.height = height + "px";
    chart_el.style.width = width + "px";

    make_diagram_blank(width, height, background_color);

    var projection = d3.geo.equirectangular()
        .center([0, 0]).scale(width / 2 / Math.PI)
        .translate([width / 2, height / 2]);

    var path = d3.geo.path().projection(projection);

    var t = projection.translate(); // the projection's default translation
    var s = projection.scale() // the projection's default scale

    var zoom = d3.behavior.zoom().translate([0, 0]).scale(1).scaleExtent([1, 40]).on("zoom", function () {
        var t = d3.event.translate;
        var s = d3.event.scale;

        var w_max = 0;
        var w_min = width * (1 - s);
        var h_max = height < s * width / 2 ? s * (width / 2 - height) / 2 : (1 - s) * height / 2;
        var h_min = height < s * width / 2 ? -s * (width / 2 - height) / 2 - (s - 1) * height : (1 - s) * height / 2;

        t[0] = Math.min(w_max, Math.max(w_min, t[0]));
        t[1] = Math.min(h_max, Math.max(h_min, t[1]));

        zoom.translate(t);
        g.attr("transform", "translate(" + t + ")scale(" + s + ")");
        g.selectAll("path").style("stroke-width", .5 / s + "px");
    });


    var svg = d3.select("#target_svg")
        .attr("width", width)
        .attr("height", height)
        .attr("style", "background-color: " + background_color)
        //.call(d3.behavior.zoom().on("zoom", redraw))
        //.append("svg:g").attr("id", "map")
        .attr("transform", "translate(" + margin_left + "," + margin_top + ")")
        .call(zoom);

    var g = svg.append("g");
   
    var colors = ["#8A2BE2", "#0000CD", "#0000FF", "#1E90FF", "#ffffff", "#8A2BE2", "#cdc", "#8A2BE2", "#0000CD", "#0000FF", "#1E90FF", "#ffffff", "#8A2BE2", "none"];

    var country = [];
    var all_geoJson = null;
    var geoJson = null;
    //alert()


    var countryID = [57, 16, 72, 39, 108, 77];
    var countryName = ["Germany", "Austria", "France", "Switzerland", "Italy", "United Kingdom"];
    var countryValue = ["7000000", "2000000", "4000000", "5000000", "4500000", "6500000"];
    var countryColor = ["#ff7f0e", "#1f77b4", "#ffbb78", "#aec7e8", "#2ca02c", "#1f77b4"];

    var indexCounter = -1;

    d3.json("scripts/lib/world-topo-min.json", function (json) {     
        var countries = topojson.feature(json, json.objects.countries).features,
            neighbors = topojson.neighbors(json.objects.countries.geometries);

        all_geoJson = topojson.feature(json, json.objects.countries);

        //geoJson = all_geoJson.features.filter(function (d) { return d.id == 57; })[0];
      
        for (var i = 0; i < all_geoJson.features.length; i++) {
            //if (geoJson.features[i].id == "57") {               
            //    country = geoJson.features[i];
            //    //alert(country)
            //}
            //alert(all_geoJson.features[i].properties.name)
            //country.push(all_geoJson.features[i].properties.name)
            
            country.push(
                         {
                             id: all_geoJson.features[i].id,
                             name: all_geoJson.features[i].properties.name
                         });
        }

        selectCountry(country);

        //alert(country)
        g.selectAll("path")
        .data(countries)
        .enter().append("svg:path")
        .attr("d", path)
           //.on("mouseover", function (d) {
           //    current_position = d3.mouse(this);
           //    var tooltipDiv = document.getElementById('tooltip');
           //    tooltipDiv.innerHTML = d.id;
           //    tooltipDiv.style.top = current_position[1] + 'px';
           //    tooltipDiv.style.left = current_position[0] + 'px';
           //    tooltipDiv.style.display = "block";

           //    d3.select(this).style("fill", "red");
           //})



           //.on("mouseout", function (d) {
           //    d3.select(this).style("fill", "white");
           //    var tooltipDiv = document.getElementById('tooltip');
           //    tooltipDiv.style.display = "none";
           //})

            //        .on("mousemove", function (d, i) {
            //            var tooltip = document.getElementById('tooltip');
            //            //var mouse = d3.mouse(svg.node()).map(function (d) { return parseInt(d); });
            //            //var left = Math.min(width - 12 * d.properties.name.length, (mouse[0] + 20));
            //            //var top = Math.min(height - 40, (mouse[1] + 20));
            //            current_position = d3.mouse(this);
            //            //alert(tooltip)
            //            tooltip.classed("hidden", false)
            //                .attr("style", "left:" + current_position[0] + "px;top:" + current_position[1] + "px")
            //                .html(d.properties.name);
            //        })
            //.on("mouseout", function (d, i) {
            //    tooltip.classed("hidden", true);
            //})

            .style("fill", function (d, i) {
                if (contains(countryID, d.id)) {
                    indexCounter++;
                    return d.color = countryColor[indexCounter];
                }
                else
                    return d.color = "#ffffff";


            })
        .style("stroke", function (d, i) {
            if (contains(countryID, d.id)) {
                indexCounter++;
                //return d.color = "#666";
                return d.color = countryColor[indexCounter];

            }


        })
        //.text(function (d) { return d.properties.name; })
        //.style("fill", function(d, i) { return color(d.color = d3.max(neighbors[i], function(n) { return countries[n].color; }) + 1 | 0); })
        ;

    //    g.selectAll("text")
    //.data(countries)
    //.enter()
    //.append("svg:text")
    //.text(function(d){
    //    return d.properties.name;
    //})
    //.attr("x", function(d){
    //    return path.centroid(d)[0];
    //})
    //.attr("y", function(d){
    //    return  path.centroid(d)[1];
    //})
    //.attr("text-anchor","middle")
    //.attr('font-size','2pt');


    });

   



    //d3.json("de.json", function (de) {
    //    //geoJson = d.features;

    //    //for (var i = 0; i < geoJson.length; i++) {
    //    //    if (geoJson[i].id == "BGD") {
    //    //        country = geoJson[i];
    //    //        alert(country)
    //    //    }

    //    //}
      
    //    map.append("path")
    // .data(topojson.feature(de, de.objects.subunits))
    // .attr("class", function (d) { return "subunit" })
    // .attr(" d ", path);
       
    //    map.append("path")
    //    .data(topojson.feature(de, de.objects.places))
    //    .attr(" d ", path)
    //    .attr("class", "place");
       
    //    map.selectAll(".place-label")
    //    .data(topojson.feature(de, de.objects.places).geometries)
    //  .enter().append("text")
    //    .attr("class", "place-label")
    //    .attr("transform", function (d) { return "translate(" + projection(d.coordinates) + ")"; })
    //    .attr("dx", "0.75em")
    //    .text(function (d) { return d.properties.name; });
    //    alert()
    //});

    function redraw() {

        var tx = t[0] * d3.event.scale + d3.event.translate[0];
        var ty = t[1] * d3.event.scale + d3.event.translate[1];
        projection.translate([tx, ty]);

        projection.scale(s * d3.event.scale);

        svg.selectAll("path").attr("d", path);

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
}



function mapMaker() {
    var color = d3.scale.category20c();
    var graph_width, graph_height, colorset, d3_color_scale,
    show_labels = 1,
    width = 1100,
    height = 800,
    font_size = 13,
    font_weight = 400,
    margin_top = 0, margin_right = 0, margin_bottom = 0, margin_left = 0,
    node_padding = 12,
    node_border = 0,
    background_color = "#ADD8E6", //B0E0E6
    font_color = "#000000",
    default_node_color = "#006699",
    font_face = "sans-serif",
    chart_el = document.getElementById("chart"),
    default_flow_opacity = 0.4;

    graph_width = width - margin_left - margin_right;
    graph_height = height - margin_top - margin_bottom;

    chart_el.style.height = height + "px";
    chart_el.style.width = width + "px";

    make_diagram_blank(width, height, background_color);

    var projection = d3.geo.equirectangular()
        .center([0, 0]).scale(width / 2 / Math.PI)
        .translate([width / 2, height / 2]);

    var path = d3.geo.path().projection(projection);

    var t = projection.translate(); // the projection's default translation
    var s = projection.scale() // the projection's default scale

    var zoom = d3.behavior.zoom().translate([0, 0]).scale(1).scaleExtent([1, 40]).on("zoom", function () {
        var t = d3.event.translate;
        var s = d3.event.scale;

        var w_max = 0;
        var w_min = width * (1 - s);
        var h_max = height < s * width / 2 ? s * (width / 2 - height) / 2 : (1 - s) * height / 2;
        var h_min = height < s * width / 2 ? -s * (width / 2 - height) / 2 - (s - 1) * height : (1 - s) * height / 2;

        t[0] = Math.min(w_max, Math.max(w_min, t[0]));
        t[1] = Math.min(h_max, Math.max(h_min, t[1]));

        zoom.translate(t);
        g.attr("transform", "translate(" + t + ")scale(" + s + ")");
        g.selectAll("path").style("stroke-width", .5 / s + "px");
    });


    var svg = d3.select("#target_svg")
        .attr("width", width)
        .attr("height", height)
        .attr("style", "background-color: " + background_color)
        .attr("transform", "translate(" + margin_left + "," + margin_top + ")")
        .call(zoom);

    var g = svg.append("g");

    var country = [];
    var all_geoJson = null;
    var geoJson = null;

    var countryID = [57, 16, 72, 39, 108, 77];
    var countryName = ["Germany", "Austria", "France", "Switzerland", "Italy", "United Kingdom"];
    var countryValue = ["7000000", "2000000", "4000000", "5000000", "4500000", "6500000"];
    var countryColor = ["#ff7f0e", "#1f77b4", "#ffbb78", "#aec7e8", "#2ca02c", "#1f77b4"];

    var indexCounter = -1;
    //scripts/lib / world - topo - min.json

    d3.json("scripts/lib/world-topo-min.json", function (json) {
        var countries = topojson.feature(json, json.objects.countries).features,
            neighbors = topojson.neighbors(json.objects.countries.geometries);

        all_geoJson = topojson.feature(json, json.objects.countries);

        //geoJson = all_geoJson.features.filter(function (d) { return d.id == 57; })[0];

        for (var i = 0; i < all_geoJson.features.length; i++) {
            //if (geoJson.features[i].id == "57") {               
            //    country = geoJson.features[i];
            //    //alert(country)
            //}
            //alert(all_geoJson.features[i].properties.name)
            //country.push(all_geoJson.features[i].properties.name)
        }

        g.selectAll("path")
        .data(countries)
        .enter().append("svg:path")
        .attr("d", path)
            .style("fill", function (d, i) {
                if (contains(countryID, d.id)) {
                    indexCounter++;
                    return d.color = countryColor[indexCounter];
                }
                else
                    return d.color = "#ffffff";


            })
        .style("stroke", function (d, i) {
            if (contains(countryID, d.id)) {
                indexCounter++;
                //return d.color = "#666";
                return d.color = countryColor[indexCounter];

            }


        })
        
        ;

    });

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
}





function mapMaker2() {
    //var data = dataGenerator();

    var color = d3.scale.category20c();

    var graph_width, graph_height, colorset, d3_color_scale,
    show_labels = 1,
    width = 1300,
    height = 900,
    font_size = 13,
    font_weight = 400,
    margin_top = 20, margin_right = 20, margin_bottom = 20, margin_left = 20,
    node_padding = 12,
    node_border = 0,
    background_color = "#FFFFFF",
    font_color = "#000000",
    default_node_color = "#006699",
    font_face = "sans-serif",
    chart_el = document.getElementById("chart"),
    default_flow_opacity = 0.4;

    graph_width = width - margin_left - margin_right;
    graph_height = height - margin_top - margin_bottom;

    chart_el.style.height = height + "px";
    chart_el.style.width = width + "px";

    make_diagram_blank(width, height, background_color);


    var map = d3.select('#map');
    var tooltip = map.append("div").attr("class", "tooltip hidden");
   
    //var width = parseInt(map.style('width')),
    //    height = parseInt(map.style('height'));
  
    var projection = d3.geo.equirectangular()
        .center([0, 0]).scale(width / 2 / Math.PI)
        .translate([width / 2, height / 2]);

    var path = d3.geo.path().projection(projection);

    var zoom = d3.behavior.zoom().translate([0, 0]).scale(1).scaleExtent([1, 40]).on("zoom", function () {
        var t = d3.event.translate;
        var s = d3.event.scale;

        var w_max = 0;
        var w_min = width * (1 - s);
        var h_max = height < s * width / 2 ? s * (width / 2 - height) / 2 : (1 - s) * height / 2;
        var h_min = height < s * width / 2 ? -s * (width / 2 - height) / 2 - (s - 1) * height : (1 - s) * height / 2;

        t[0] = Math.min(w_max, Math.max(w_min, t[0]));
        t[1] = Math.min(h_max, Math.max(h_min, t[1]));

        zoom.translate(t);
        g.attr("transform", "translate(" + t + ")scale(" + s + ")");
        g.selectAll("path").style("stroke-width", .5 / s + "px");
    });

    //var svg = map
    //    .append("svg")
    //    .attr("width", '100%')
    //    .attr("height", '100%')
    //    .call(zoom);

    var svg = d3.select("#target_svg")
        .attr("width", '100%')
        .attr("height", '100%')
        .attr("style", "background-color: " + background_color)
        .attr("transform", "translate(" + margin_left + "," + margin_top + ")")
        .call(zoom);
        

    var g = svg.append("g");
    
    d3.json('scripts/lib/world-topo-min.json', function (json) {
        var countries = topojson.feature(json, json.objects.countries).features,
      neighbors = topojson.neighbors(json.objects.countries.geometries);
      
        g.selectAll("path")
            .data(countries)
            .enter().append("path")
            .attr("d", path)
             //.style("fill", function(d, i) { return color(d.color = d3.max(neighbors[i], function(n) { return countries[n].color; }) + 1 | 0); })
            .on("mousemove", function (d, i) {

                var mouse = d3.mouse(svg.node()).map(function (d) { return parseInt(d); });
                var left = Math.min(width - 12 * d.properties.name.length, (mouse[0] + 20));
                var top = Math.min(height - 40, (mouse[1] + 20));

                tooltip.classed("hidden", false)
                    .attr("style", "left:" + left + "px;top:" + top + "px")
                    .html(d.properties.name);
            })
            .on("mouseout", function (d, i) {
                tooltip.classed("hidden", true);
            });

        d3.select(window).on('resize', function () {
            width = parseInt(map.style('width'));
            height = parseInt(map.style('height'));

            projection
                .scale(width / 2 / Math.PI)
                .translate([width / 2, height / 2]);

            g.selectAll("path")
                .attr("d", path);
        });
    });
    function make_diagram_blank(w, h, background_color) {
        document.getElementById('chart').innerHTML =
            '<svg id="target_svg" height="' + h + '" width="' + w + '" '
            + 'xmlns="http://www.w3.org/2000/svg" version="1.1" '
            + 'style="background-color: ' + background_color + '"></svg>';
        return;
    }
}