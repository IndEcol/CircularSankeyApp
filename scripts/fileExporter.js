//d3.select("#generate").on("click", writeDownloadLink);
function fileExporter() {
    try {
        var isFileSaverSupported = !!new Blob();

    } catch (e) {
        alert("blob not supported");
    }

    var html = d3.select("svg")
        .attr("title", "sankey")
        .attr("version", 1.1)
        .attr("xmlns", "http://www.w3.org/2000/svg")
        .node().parentNode.innerHTML;

    var blob = new Blob([html], { type: "image/svg+xml" });
    saveAs(blob, "sankey_diagram.svg");
}

function export_png() {
    //var canvas = document.getElementById("png_preview"), ctx = canvas.getContext("2d");
    //// draw to canvas...
    //canvas.toBlob(function (blob) {
    //    saveAs(blob, "pretty image.png");
    //});


    // Since 'innerHTML' isn't supposed to work for XML (SVG) nodes (though it
    // does seem to in Firefox), we string together the node contents to submit
    // to the canvas converter:
    var svg_el = document.getElementById("target_svg"),
        svg_content = (new XMLSerializer()).serializeToString(svg_el),
        canvas_el = document.getElementById("png_preview"),
        png_link_el = document.getElementById("download_png_link"),
        png_w = 500,
        png_h=500,
        // Do any scaling necessary --

        // Btw, this is a horrible way to get the original size of the chart:


        canvas_context = canvas_el.getContext("2d"),
        svg_as_png_url = '';

    canvas_el.width = png_w;
    canvas_el.height = png_h;

    // Draw the svg contents on the canvas:
    canvg(canvas_el, svg_content, {
        ignoreMouse: true,
        ignoreAnimation: true,
        ignoreDimensions: true, // DON'T make the canvas size match the svg's
        scaleWidth: 500,
        scaleHeight: 500
    });

    // Color the background correctly by drawing a canvas-sized rect underneath.
    // Credit to Mike Chambers (@mesh) for this approach.
    canvas_context.globalCompositeOperation = "destination-over";
    canvas_context.fillStyle = svg_el.style.backgroundColor;
    canvas_context.fillRect(0, 0, png_w, png_h);

    // Convert canvas image to a PNG:
    svg_as_png_url = canvas_el.toDataURL('image/png');
    // make it downloadable (Firefox, Chrome)
    // svg_as_png_url = svg_as_png_url.replace('image/png','image/octet-stream');
    png_link_el.setAttribute("href", svg_as_png_url);
    png_link_el.setAttribute("target", "_blank");

    // update download link & filename with dimensions:
    png_link_el.innerHTML = "Export " + png_w + " x " + png_h + " PNG";
    png_link_el.setAttribute("download", "sankeymatic_" + png_w + "x" + png_h + ".png");


    return;

}

