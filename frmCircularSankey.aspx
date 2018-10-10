<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmCircularSankey.aspx.cs" Inherits="IEF_Visualization.frmCircularSankey"  %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title>CircularSankey: Build a diagram</title>

    <link href="css/jquery-ui.css" rel="stylesheet" />
    
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/footer-distributed-with-address-and-phones.css" rel="stylesheet" />
    <link href="css/body.css" rel="stylesheet" />
    <!-- css -->

    <!-- JavaScriptLibrary -->
        <script src="scripts/lib/jquery-1.12.4.js" type="text/javascript"></script>
    <script src="scripts/lib/jquery-ui.js" type="text/javascript"></script>
    <script src="scripts/lib/d3.min.js" type="text/javascript"></script>
    <%--<script src="scripts/lib/d3.v2.js"></script>--%>
    <script src="scripts/lib/d3.v3.min.js" type="text/javascript"></script>
    <script src="scripts/lib/canvg.js" type="text/javascript"></script>
    <script src="scripts/lib/rgbcolor.js" type="text/javascript"></script>
    <script src="scripts/lib/Blob.js" type="text/javascript"></script>
    <script src="scripts/lib/FileSaver.js" type="text/javascript"></script>
    <%--<script src="scripts/canvas-toBlob.js"></script>--%>
    <!-- JavaScriptLibrary -->
   
    <!-- CustomJavaScript -->
    <script src="scripts/circular_sankey_lib.js" type="text/javascript"></script>
    <script src="scripts/circular_sankey_script.js" type="text/javascript"></script>

    <script src="scripts/fileUploader.js" type="text/javascript"></script>
    <script src="scripts/fileExporter.js" type="text/javascript"></script>

    <style>

.node rect {
  cursor: move;
  /* shape-rendering: crispEdges; */
  /* fill-opacity: .9; */
}

.node text {
  pointer-events: none;
}


</style>


    <style>

        .col-md-8 {
            text-align:left;

        }

        .col-md-12 {
            padding-left:0px;
            /*background-color:#229922;*/

        }

        .col-md-4 {
            padding-left:0px;
            /*background-color:#229922;*/

        }
         .col-md-10 {
            text-align: right;
            padding-bottom: 0px;

        }

.col-md-2 {
    float: left;
    padding: 0;
    background-color:none;
    padding-bottom: 0px;
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
    margin-bottom: 1px;
}

        .ui-tabs .ui-tabs-panel {
    border-width: 0;
    display: block;
    padding: .2em .2em;
}
        .ui-tabs .ui-tabs-nav {
    margin: 0;
}

        .btn{
            margin-right: 7px;
    margin-top: 8px;
        }
        .table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
    border-top: 1px solid #ddd;
    line-height: 1.42857;
    padding: 5px;
    vertical-align: inherit;


}
  
        .navbar-custom .navbar-nav > li > a {
    font-weight: bold;

}
    </style>
    <script>
  $( function() {

      $("#tabs").tabs({
          heightStyle: "auto"
      });
     
      $(".ui-widget-header").css("background", "#33aa33");
      $(".ui-widget-content").css("background", "#99CC99");


      $('#preview_graph').click(function () {
          var outmessage = document.getElementById("spnOutputMessage").innerText;
          if (outmessage.length > 2) {

              $("#tabs").tabs("option", "active", 2);
          }
          

      });
  });

  function key_Pressed(e, textarea) {
      var code = (e.keyCode ? e.keyCode : e.which);
      if (code == 13) {
          return false;
      }
      return true;
  }

  </script>
</head>
<body>
    <form id="form1" runat="server">
        
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
        <div class="navbar-header">
      <a class="navbar-brand" href="#">Circular Sankey</a>
    </div>

      <ul class="nav navbar-nav navbar-right">
          
                    <li><a href="frmHome.aspx">Login</a></li>
                        <li class="active"><a href="frmCircularSankey.aspx">Sankey Diagram</a></li>
                        <li><a href="frmBuildMap.aspx">Map Maker</a></li>
                        <li><a href="frmBuildChart.aspx">Pie Chart</a></li>
                        <li><a href="frmUserProfile.aspx">Your History</a></li>
                        <li><a href="frmUserGuide.aspx">User Guide</a></li>
                        <li><a href="http://www.industrialecology.uni-freiburg.de" target="_blank">Home</a></li>
          <li><asp:Button ID="btnLogOut" runat="server" class="btn btn-info" Text="Log Out" OnClick="btnLoggOut_Click" /></li>

                 
      </ul>
      
  </div>
</nav>

<div class="container-fluid" >
    <div class="row" id="tabs">
        
  <ul>
    <li><a href="#tabs-1">SVG properties</a></li>
    <li><a href="#tabs-2">Data Input</a></li>
    <li><a href="#tabs-3">Output Messages</a></li>
  </ul>
  <div id="tabs-1">



      <table class="table table-bordered">
          <col class="col-md-2">
            <col class="col-md-2">
          <col class="col-md-2">
            <col class="col-md-2">
          <col class="col-md-2">
            <col class="col-md-2">
          <tr>
              <td>Project Name:</td>
      <td><asp:TextBox ID="txtproject_name"  runat="server" class="form-control" onchange="process_sankey();" ></asp:TextBox></td>
                 <td>Background Color:</td>
      <td><asp:TextBox type="color" runat="server" id="background_color" size="7" maxlength="7" value="#FFFFFF" onchange="process_sankey();"/></td>
    
              <td>Node Height:</td>
              <td><input id="node_height" runat="server" type="range" class="span2" min="1" max="9" step="1" value="5"  onchange="process_sankey();"/></td>
    
          </tr>
          <tr>
              <td>Diagram Width & Height:</td>
      <td><asp:TextBox runat="server" id="canvas_width" size="5" maxlength="6" value="1300" onkeypress="return key_Pressed(event, this);" onchange="process_sankey();"/> px
          <asp:TextBox runat="server" id="canvas_height" size="5" maxlength="6" value="900" onkeypress="return key_Pressed(event, this);" onchange="process_sankey();"/> px
      </td>
               <td>Unit Name:</td>
             <td>
                 <asp:TextBox runat="server" id="unit_name" size="5" value="kt" onkeypress="return key_Pressed(event, this);" onchange="process_sankey();"/>
      </td>
                <td>Font Size:</td>
      <td> <asp:TextBox type="text" runat="server" class="wholenumber" id="font_size" size="2" maxlength="4" value="12" onkeypress="return key_Pressed(event, this);" onchange="process_sankey();"/> px
      </td>
               
          </tr>
          <tr>
             <td>Node Opacity:</td>
               <td><input id="default_node_opacity" runat="server" type="range" class="span2" min="1" max="9" step="1" value="5" onchange="process_sankey();" /></td>
    <td>Flow Width:</td>
              <td><input id="flow_width" runat="server" type="range" class="span2" min="1" max="9" step="1" value="9"  onchange="process_sankey();"/></td>
             
              
      
     <td>Font Face:</td>
      <td> <select id="font_face" runat="server" onchange="process_sankey();">
<option value="sans-serif" selected="selected">sans-serif</option>
<option value="serif">serif</option>
<option value="monospace">monospace</option>
          </select>
      </td>
          </tr>
          <tr>
             <td>Flow Opacity:</td>
      <td><input id="default_flow_opacity" runat="server" type="range" class="span2" min="1" max="9" step="1" value="5"  onchange="process_sankey();"/></td>
    
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
              <td>Show or Hide labels:</td>
      <td><input type="checkbox" runat="server" id="show_labels" onchange="process_sankey();" checked="checked"/>
      </td>
          </tr>
          <tr>
             <td>Curviness:</td>
      <td>
         <b></b><input id="curvature" runat="server" type="range" class="span2" min="1" max="9" step="1" value="5" onchange="process_sankey();" /><b></b>
      </td>
              
              <td>
                  Description
              </td>
             <td>
                  <asp:TextBox id="txtRemarks" runat="server" class="form-control" onchange="process_sankey();" ></asp:TextBox> 
      </td>
            
               <td>Font Color:</td>
      <td> <asp:TextBox type="color" runat="server" id="font_color" size="7" maxlength="7" value="#000000" onchange="process_sankey();"/>
      </td>
          </tr>
      </table>



 
  </div>
  <div id="tabs-2">

                            <table class="table table-bordered">
                                <colgroup>
            <col class="col-md-6">
            <col class="col-md-6">
        </colgroup>
                                 <tr>
                                    <td align="right">
                                        <input style="width:auto; float:left;" id="fileNode" runat="server" type="file" /> 
                                    </td>
                                     
                                          <td>
                                              <asp:Button ID="node_properties" runat="server" OnClick="btnNodeFile_Click" Text="Upload" />


                                          </td>
                                   
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        
 Please make sure your excel file consists of two sheets, where first sheet of file contains the flow properties and second sheet contains the node properties! Sample excel data file can be downloaded from "User Guide" Page

                                          </td>
                                   
                                </tr>
                                <tr>
                                   
      <td>
         
          [name] [color] [orientation] [width] [height] [x_position] [y_position]
            <textarea id="input_node_data" runat="server" rows="8" cols="120" onchange="process_sankey();" class="form-control">
[A] [(0,191,255)] [270] [40.00] [35.31] [98] [242]
[B] [(0,191,255)] [0] [40.00] [82.40] [320] [68]
[M1] [(0,191,255)] [0] [40.00] [14.13] [450] [50]
[M2] [(0,191,255)] [0] [40.00] [18.83] [450] [85]
[M3] [(0,191,255)] [0] [40.00] [28.25] [450] [124]
[M4] [(0,191,255)] [0] [40.00] [21.19] [450] [176]
[Use] [(0,191,255)] [0] [40.00] [61.21] [614] [93]
[C] [(0,191,255)] [90] [40.00] [21.19] [582] [266]
[E] [(0,191,255)] [180] [40.00] [30.61] [654] [421]
[Environment] [(0,191,255)] [180] [40.00] [47.09] [364] [420]
</textarea>

      </td>

                                    <td>
                                        [source] [value] [flow color] [ab] [target]  where 
                                        a: 'C': Cubic Bezier ..
                                        b: 'n': no arrow, '1': arrow type 1, '2': arrow type 2, ...
             <textarea id="input_flow_data" runat="server" rows="8" cols="120" onchange="process_sankey();" class="form-control">
[A]  [15]  [(0,191,255)] [ab] [B]
[B]  [6]  [(0,191,255)] [ab] [M1]
[B]  [8]  [(0,191,255)] [ab] [M2]
[B]  [12]  [(0,191,255)] [ab] [M3]
[B]  [9]  [(0,191,255)] [ab] [M4]
[M1]  [5]  [(0,191,255)] [ab] [Use]
[M2]  [5]  [(0,191,255)] [ab] [Use]
[M3]  [10]  [(0,191,255)] [ab] [Use]
[M4]  [6]  [(0,191,255)] [ab] [Use]
[M1]  [1]  [(200,191,55)] [ab] [C]
[M2]  [3]  [(200,191,55)] [ab] [C]
[M3]  [2]  [(200,191,55)] [ab] [C]
[M4]  [3]  [(200,191,55)] [ab] [C]
[Use]  [13]  [(200,191,55)] [ab] [E]                                            
[Environment]  [20]  [(0,191,255)] [ab] [B]                                 
[E]  [12]  [(200,191,55)] [ab] [Environment]                               
</textarea>
      </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                           <asp:Button ID="btnDownloadData" runat="server" Text="Download Data" class="btn btn-success" OnClick="btnDownloadData_Click"></asp:Button>

                                    </td>
                                </tr>
                            </table>
        
     
  </div>

        <div id="tabs-3">
            <span id="spnOutputMessage"  class="label label-danger"></span>
             <asp:Label ID="lblOutputMessage" runat="server" Text=""></asp:Label>
            </div>
</div>
    
      <div class="row">  

                      <div class= "col-md-12" id="div_svg" >

                          

                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           <input id="preview_graph" type="button" value="Preview" class="btn btn-success" />
            &nbsp;&nbsp;
             <asp:Button ID="btnSave" runat="server" Text="Save Into Database" Enable="True" class="btn btn-success" OnClick="btnSave_Click" ></asp:Button>
                     &nbsp;&nbsp;
                    
                    <asp:Button ID="btnSaveAs" runat="server" Text="Save As" class="btn btn-success" OnClick="btnSaveAs_Click" Visible="false"></asp:Button>
                    &nbsp; &nbsp;
                          
                    <button id="generate" class="btn btn-success" onclick="fileExporter();">Export as SVG</button>
                         
                           <br />
                          <br />
                          <h4>Drag processes on the canvas to change their position!</h4>
    <p id="chart">
                        <svg class="img-responsive" id="target_svg" xmlns="http://www.w3.org/2000/svg" version="1.1"></svg>
                    </p>
                    <canvas id="png_preview" style=" display:none;"></canvas> 

</div>

                    </div>

</div><br/>
        <br /><br /><br />
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
     
      <strong style="color:green; font-size:14px;"> Hello,</strong>   <asp:Label ID="lblUser" CssClass="user-name-label" runat="server" Text="" ></asp:Label> 
     <input type="checkbox" id="table_layer" value="1"/>
     
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
