<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmCircularSankeyLP.aspx.cs" Inherits="IEF_Visualization.frmCircularSankeyLP" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <title>CircularSankey: Build a diagram</title>

    <!-- css -->

    <%--<link href="css/main.css" rel="stylesheet" />--%>
    <%--<link href="css/style.css" rel="stylesheet" />--%>
    <link href="css/jquery-ui.css" rel="stylesheet" />
    
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/footer-distributed-with-address-and-phones.css" rel="stylesheet" />
    <link href="css/body.css" rel="stylesheet" />
    <!-- css -->

    <!-- JavaScriptLibrary -->
        <script src="scripts/lib/jquery-1.12.4.js"></script>
    <script src="scripts/lib/jquery-ui.js"></script>
    <script src="scripts/lib/d3.min.js"></script>
    <script src="scripts/lib/d3.v2.js"></script>
    <script src="scripts/lib/canvg.js"></script>
    <script src="scripts/lib/rgbcolor.js"></script>
    <script src="scripts/lib/Blob.js"></script>
    <script src="scripts/lib/FileSaver.js"></script>
    
    <!-- JavaScriptLibrary -->
   
    <!-- CustomJavaScript -->

  
    <script src="scripts/circular_sankey_lib_lp.js"></script>
    <script src="scripts/circular_sankey_script_lp.js"></script>

    <script src="scripts/fileUploader.js"></script>
    <script src="scripts/fileExporter.js"></script>


    <!-- CustomJavaScript -->
    <script>
        $(document).ready(function () {
            //$("#content-inner-row1Col").resizable();
            $("#col-md-4").accordion({
                collapsible: true,
                active: 2,
                autoHeight: false,
                heightStyle: "content",
                navigation: true,
                beforeActivate: function (event, ui) {
                    // The accordion believes a panel is being opened
                    if (ui.newHeader[0]) {
                        var currHeader = ui.newHeader;
                        var currContent = currHeader.next('.ui-accordion-content');
                        // The accordion believes a panel is being closed
                    } else {
                        var currHeader = ui.oldHeader;
                        var currContent = currHeader.next('.ui-accordion-content');
                    }
                    // Since we've changed the default behavior, this detects the actual status
                    var isPanelSelected = currHeader.attr('aria-selected') == 'true';

                    // Toggle the panel's header
                    currHeader.toggleClass('ui-corner-all', isPanelSelected).toggleClass('accordion-header-active ui-state-active ui-corner-top', !isPanelSelected).attr('aria-selected', ((!isPanelSelected).toString()));

                    // Toggle the panel's icon
                    currHeader.children('.ui-icon').toggleClass('ui-icon-triangle-1-e', isPanelSelected).toggleClass('ui-icon-triangle-1-s', !isPanelSelected);

                    // Toggle the panel's content
                    currContent.toggleClass('accordion-content-active', !isPanelSelected)
                    if (isPanelSelected) { currContent.slideUp(); } else { currContent.slideDown(); }

                    return false; // Cancels the default action
                }
            });

            $(".ui-accordion-header").css("background", "#229922");
            $(".ui-widget-content").css("background", "#58AB58");
            $(".ui-accordion-header.ui-state-active ").css("background", "#229922");

            $('#colorpicker').farbtastic('#color');



        });



        function setRectangleColor(picker) {

            //document.getElementsByTagName('body')[0].style.color = '#' + picker.toString()
        }

        function hideDive() {
            document.getElementById("dAngle").style.display = 'none';
        }

        function hidePopupDivNode() {
            document.getElementById("PopupDivNode").style.display = 'none';
        }
    </script>

    <style>

        .col-md-8 {
            text-align:left;

        }

        .col-md-4 {
            padding-left:0px;
            /*background-color:#229922;*/

        }
         .col-md-10 {
            text-align: right;
            padding-bottom: 20px;

        }

.col-md-2 {
    float: left;
    padding: 0;
    background-color:none;
    padding-bottom: 20px;
}
.col-md-2 p a, p a:hover {
    color: darkgreen;
    font-weight:bold;
    font-size:22px;
    text-decoration: none;
}
.col-md-2 p span {
    color: lightgreen;
}

        .table {
    margin-bottom: 20px;
}
    </style>
    <script>
        $(document).ready(function () {
            alert("ss");
        
        });
    </script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="process_sankey(); return false;">
<div class="jumbotron">
          <div class="container-fluid">
    
                    <div class="col-md-2">
                        <img src="resources/IEF_Logo.png" style="padding-left:10px;" width="150px" height="150px" />
                    </div>
                    <div class="col-md-8" style="padding-left:30px;">
                        <h2>Industrial Ecology Freiburg</h2>
                        <p style="font-size:16px;">Research group at the Faculty of Environment and Natural Resources</p>
                    </div>
                    <div class="col-md-2">
                        <img src="resources/uni_freiburg.png" width="120px" height="150px"/>
                    </div>
                
  </div>
</div>

<nav class="navbar navbar-default navbar-custom navbar">
  <div class="container-fluid">
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
          
                    <li><a href="frmHome.aspx">Login</a></li>
                        <li><a href="frmCircularSankeyLP.aspx">Sankey Diagram</a></li>
                        <li><a href="frmBuildMap.aspx">Map Maker</a></li>
                        <li><a href="frmBuildChart.aspx">Pie Chart</a></li>
                        <li><a href="frmUserProfile.aspx">Your History</a></li>
                        <li><a href="frmUserGuide.aspx">User Guide</a></li>
                        <li><a href="frmAboutUs.aspx">About Us</a></li>

                    
      </ul>
     
    </div>
  </div>
</nav>

<div class="container-fluid" >
    <div class="row">
        
        <div class= "col-md-2">
            <p><a href="#">Circular<span>Sankey</span></a></p>
            </div>
         <div class= "col-md-10">
            <strong style="color:green; font-size:14px;"> Hello,</strong>   <asp:Label ID="lblUser" CssClass="user-name-label" runat="server" Text="" ></asp:Label> 
                     &nbsp;&nbsp;&nbsp;&nbsp; 
                     <asp:Button ID="btnLogOut" runat="server" class="btn btn-success" Text="Log Out" OnClick="btnLoggOut_Click" />
        </div>
       <%-- <div class= "col-md-12" style="text-align:left; padding-left:0px;">
            
        </div>--%>
       </div>
      <div class="row">  
                <div class= "col-md-4" id="col-md-4">
                    
                        <h3>Basic</h3>
                    <div>


                        <table class="table">
  <tbody>
    <tr>
     
      <td>Project Name:</td>
      <td><asp:TextBox ID="txtproject_name" runat="server" class="form-control"></asp:TextBox></td>
     
    </tr>
    <tr>
     
      <td>Background Color:</td>
      <td><asp:TextBox type="color" runat="server" id="background_color" size="7" maxlength="7" value="#FFFFFF" onchange="process_sankey();"/></td>
    
    </tr>
    <tr>
    
      <td>Enable Drag Option</td>
      <td><input type="checkbox" runat="server" id="enable_drag" checked="checked" onchange="process_sankey();"/></td>
    
    </tr>
       <tr>
    
      <td>Diagram Width & Height:</td>
      <td><asp:TextBox runat="server" id="canvas_width" size="5" maxlength="6" value="900" onchange="process_sankey();"/> px
          <asp:TextBox runat="server" id="canvas_height" size="5" maxlength="6" value="900" onchange="process_sankey();"/> px
      </td>
    
    </tr>
  </tbody>
</table>

                        </div>
                     
                        <h3>advanced</h3>
                    <div>

                        <table class="table">
  <tbody>
    <tr>
     
      <td>Curviness:</td>
      <td>
         <b>0.0</b><input id="curvature" runat="server" type="range" class="span2" min="0.1" max="0.9" step="0.1" value="0.5" onchange="process_sankey();" /><b>1.0</b
      </td>
     
    </tr>
    <tr>
     
      <td>Flow Opacity:</td>
      <td>0.0<input id="default_flow_opacity" runat="server" type="range" min="0.1" max="0.9" step="0.1" value="0.8" onchange="process_sankey();" class="slider"/>1.0</td>
    
    </tr>
    <tr>
    
      <td>Node Opacity:</td>
      <td>0.0 <input id="default_node_opacity" runat="server" type="range" min="0.1" max="0.9" step="0.1" value="1.0" onchange="process_sankey();" class="slider" />1.0</td>
    
    </tr>
       <tr>
    
      <td>Border:</td>
      <td><select id="node_border" runat="server" onchange="process_sankey();">
<option value="0" selected="selected">0px</option>
<option value="1">1px</option>
<option value="2">2px</option>
<option value="3">3px</option>
<option value="4">4px</option>
<option value="5">5px</option>
</select>
      </td>
    
    </tr>
       <tr>
    
      <td>Show or Hide labels:</td>
      <td><input type="checkbox" runat="server" id="show_labels" onchange="process_sankey();" checked="checked"/>
      </td>
    
    </tr>
       <tr>
    
      <td>Font Face:</td>
      <td> <select id="font_face" runat="server" onchange="process_sankey();">
<option value="sans-serif" selected="selected">sans-serif</option>
<option value="serif">serif</option>
<option value="monospace">monospace</option>
          </select>
      </td>
    
    </tr>

      <tr>
    
      <td>Font Size:</td>
      <td> <asp:TextBox type="text" runat="server" class="wholenumber" id="font_size" size="2" maxlength="4" value="15" onchange="process_sankey();"/>px
      </td>
    
    </tr>
        <tr>
    
      <td>Font Color:</td>
      <td> <asp:TextBox type="color" runat="server" id="font_color" size="7" maxlength="7" value="#000000" onchange="process_sankey();"/>
      </td>
    
    </tr>
  </tbody>
</table>

                    </div>
                                          

                                         
                     <h3>Data</h3>
                    <div class="form-group">

                        <table class="table">
  <tbody>
    <tr>
     
      <td>Select file:  </td>
      <td><input id="fileNodeProperties" type="file" />
     <input type="button" id="node_properties" value="Upload" class="btn_normal" onclick="upload_data();" /></td>
    
    </tr>
  </tbody>
</table>  
                        <table class="table">
  <tbody>
    <tr>
     
      <td>[name] [color] [orientation] [width] [height] [x_position] [y_position]</td>
      
     
    </tr>
    <tr>
     
      <td>
            <textarea id="input_node_data" runat="server" rows="10" cols="80" onchange="process_sankey();" class="form-control">
[A] [#969696] [270] [40.00] [80.00] [150] [250]
[B] [#969696] [0] [40.00] [118.00] [350] [50]
[M1] [#969696] [0] [40.00] [18.00] [450] [50]
[M2] [#969696] [0] [40.00] [27.00] [450] [85]
[M3] [#969696] [0] [40.00] [40.00] [450] [124]
[M4] [#969696] [0] [40.00] [30.00] [450] [176]
[Use] [#969696] [0] [40.00] [90.00] [610] [100]
[C] [#969696] [90] [40.00] [40.00] [557] [273]
[E] [#969696] [180] [40.00] [70.00] [350] [450]
[Environment] [#969696] [180] [40.00] [45.00] [650] [450]
                                            </textarea>

      </td>
      
    </tr>
  </tbody>
</table>  
                             
 <table class="table">
  <tbody>
    <tr>
     
      <td>Select file:  </td>
      <td><input id="fileInput" type="file" />
     <input type="button" id="upload" value="Upload" class="btn_normal" onclick="upload_data();" /></td>
    
    </tr>
  </tbody>
</table>  
       <table class="table">
  <tbody>
    <tr>
     
      <td> <input type="checkbox" id="table_layer" value="1"/>
                                            <label>Please tick in case of multi layer table data</label></td>
      
     
    </tr>
      <tr>
     
      <td> [source] [value] [flow color] [target]</td>
      
     
    </tr>
    <tr>
     
      <td>
             <textarea id="input_flow_data" runat="server" rows="10" cols="120" onchange="process_sankey();" class="form-control">
[A]  [15]  [(0, 191, 255)]  [B]
[B]  [6]  [(0, 191, 255)]  [M1]
[B]  [8]  [(0, 191, 255)]  [M2]
[B]  [12]  [(0, 191, 255)]  [M3]
[B]  [9]  [(0, 191, 255)]  [M4]
[M1]  [5]  [(0, 191, 255)]  [Use]
[M2]  [5]  [(0, 191, 255)]  [Use]
[M3]  [10]  [(0, 191, 255)]  [Use]
[M4]  [6]  [(0, 191, 255)]  [Use]
[M1]  [1]  [(200, 191, 55)]  [C]
[M2]  [3]  [(200, 191, 55)]  [C]
[M3]  [2]  [(200, 191, 55)]  [C]
[M4]  [3]  [(200, 191, 55)]  [C]
[Use]  [13]  [(200, 191, 55)]  [E]                                            
[Environment]  [20]  [(0, 191, 255)]  [B]                             
                                            </textarea>
      </td>
      
    </tr>
  </tbody>
</table>                                   
                           
                         &nbsp; &nbsp;
                           <asp:Button ID="btnDownloadData" runat="server" Text="Download Data" class="btn btn-success" OnClick="btnDownloadData_Click"/>
                        <asp:TextBox id="txtRemarks" runat="server" CssClass="textbox" Visible="false"></asp:TextBox> 
                </div>

                   
                    </div>

                      <div class= "col-md-8" id="div_svg">
                           <input id="preview_graph" type="submit" value="Preview SVG" class="btn btn-success" />
            &nbsp;&nbsp;
             <asp:Button ID="btnSave" runat="server" Text="Save Into Database" class="btn btn-success" OnClick="btnSave_Click"/>
                     &nbsp;&nbsp;
                    
                    <asp:Button ID="btnSaveAs" runat="server" Text="Save As" class="btn btn-success" OnClick="btnSaveAs_Click" Visible="false"/>
                    &nbsp; &nbsp;
                          
                    <button id="generate" class="btn btn-success" onclick="fileExporter();">Export as SVG</button>
                          <br />
                          <br />
    <p id="chart">
                        <svg id="target_svg" xmlns="http://www.w3.org/2000/svg" version="1.1"></svg>
                    </p>
                    <canvas id="png_preview" style=" display:none;"></canvas> 

</div>

                    </div>

</div><br/>

		<footer class="footer-distributed">

			<div class="footer-left">

				<p class="footer-links">
                    <a href="http://www.blog.industrialecology.uni-freiburg.de">Blog</a>
                    .
                    <a href="http://www.blog.industrialecology.uni-freiburg.de">Research</a>
                    .
                    <a href="http://www.database.industrialecology.uni-freiburg.de">Database</a>
                    .
           <a href="http://www.visualisation.industrialecology.uni-freiburg.de">Visualisation</a>
                    .
                    <a href="http://www.teaching.industrialecology.uni-freiburg.de">Teaching</a>
                    .
            <a href="http://www.internal.industrialecology.uni-freiburg.de">Internal</a>

				</p>
			
			</div>
			<div class="footer-center">
				<div>

                    <h3>Industrial Ecology <span>Freiburg</span></h3>
					<p>  &copy; 2017 Stefan Pauliuk &amp; Mahadi Hasan<br>
                        Sustainable Energy and Material Flow Management (Industrial Ecology) <br>
                        Faculty of Environment and Natural Resources <br>
                       
					       Tennenbacher Straße 4 <br>
                         D-79106 Freiburg <br>
                        Germany <br>
                        email: in4mation@indecol-freiburg.de <br>
                        </p>
				</div>

			</div>

			

		</footer>


 <div style="visibility:hidden" >

                         <div id="dAngle" class="dAngle">
            <label for="nAngle"
                   style="display: inline-block; width: 260px;">
                Scroll right/left to rotate = <span id="nAngle-value">…</span>
            </label>
            <input type="range" min="0" max="360" id="nAngle"/>
            <button type="button" onclick="hideDive()" style="width:50px">Hide</button>
            Color: <input class="jscolor" value="ab2567"/>
            <button class="jscolor {valueElement:'chosen-value', onFineChange:'setRectangleColor(this)'}">
                Pick text color
            </button>
            <br />
            HEX value: <input id="chosen-value" value="000000"/>


        </div>

                    <div id="PopupDivNode" class="PopupDiv">


           <button type="button" onclick="hidePopupDivNode()" style="width:50px">Close</button>
        </div>

                         <label><strong>Node Width:</strong></label>
                                            <span class="no_wrap"><input type="text" class="wholenumber" id="node_width" size="2" maxlength="4" value="40" onchange="process_sankey();"/> px</span>
                        <label><strong>Margins:</strong></label>
                                            
                                            <span class="no_wrap">
                                                <label>Top</label>
                                                <input type="text" class="wholenumber" id="top_margin" size="2" maxlength="4" value="20" onchange="process_sankey();"/>
                                            </span>
                                            <span class="no_wrap">
                                                <label>Botom</label>
                                                <input type="text" class="wholenumber" id="bottom_margin" size="2" maxlength="4" value="20" onchange="process_sankey();"/>
                                            </span>
                                            <span class="no_wrap">
                                                <label>Left</label>
                                                <input type="text" class="wholenumber" id="left_margin" size="2" maxlength="4" value="20" onchange="process_sankey();"/>
                                            </span>
                                            <span class="no_wrap">
                                                <label>Right</label>
                                                <input type="text" class="wholenumber" id="right_margin" size="2" maxlength="4" value="20" onchange="process_sankey();"/>
                                            </span>
                                           
                                                 <strong>Node Type:</strong>
                            <input name="default_node_type" type="radio" id="node_type_a" value="R" onchange="process_sankey();" checked="checked" />
                            <label>Rectangle</label>
                            <input name="default_node_type" type="radio" id="node_type_b" value="C" onchange="process_sankey();" />
                            <label>Circle</label>
                        </div>
         <script>
             process_sankey(); // render on page load
    </script>

    </form>
    
</body>
</html>

