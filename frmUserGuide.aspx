<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmUserGuide.aspx.cs" Inherits="IEF_Visualization.frmUserGuide" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Guide</title>
    <link href="css/jquery-ui.css" rel="stylesheet" />
    
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/footer-distributed-with-address-and-phones.css" rel="stylesheet" />
    <link href="css/body.css" rel="stylesheet" />
    <!-- css -->

    <!-- JavaScriptLibrary -->
        <script src="scripts/lib/jquery-1.12.4.js"></script>
    <script src="scripts/lib/jquery-ui.js"></script>

    <style type="text/css">

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
    </style>

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
                        <li><a href="frmCircularSankey.aspx">Sankey Diagram</a></li>
                        <li><a href="frmBuildMap.aspx">Map Maker</a></li>
                        <li><a href="frmBuildChart.aspx">Pie Chart</a></li>
                        <li><a href="frmUserProfile.aspx">Your History</a></li>
                        <li class="active"><a href="frmUserGuide.aspx">User Guide</a></li>
                        <li><a href="http://www.industrialecology.uni-freiburg.de" target="_blank">Home</a></li>
          <li><asp:Button ID="btnLogOut" runat="server" class="btn btn-info" Text="Log Out" OnClick="btnLoggOut_Click" /></li>

                 
      </ul>
      
  </div>
</nav>
        <div class="container-fluid" >
        <div class="row">  

                      <div class= "col-md-12" >
                          <br /><br /><br />
                          <a href="https://www.youtube.com/watch?v=CUKCh2T9QHs"  target="_blank"">Video tutorial (8 mins) with an introduction to the CircularSankey app</a><br /><br />
                          <a href="https://www.youtube.com/watch?v=7d-mHhjt_FQ"  target="_blank"">Video tutorial (7 mins) with an explanation of the Excel interface to the CircularSankey app</a><br /><br />
                          <a href="http://www.visualisation.industrialecology.uni-freiburg.de/CircularSankeyDocumentation/home.html" target="_blank"> Documentation of Circular Sankey</a><br /><br />
                          <a href="frmUserManager.aspx">User Manager page</a><br /><br />
                          <a href="frmForum.aspx">Comments and Feedback Page</a><br /><br />
                          <a href="frmTerms.aspx">Terms of use</a>
                          ​
<br /><br />
                          Sample excel file can be downloaded from here:
                          <a href="resources/Example_data.xlsx">File One</a>
                 <br /> <br />
                    


               

                    </div>
       


        <div id="content" style="visibility:hidden">
            <div id="content-inner">
                 <div id ="logindiv" style="float:right">
                   <strong style="color:green; font-size:14px;"> Hello,</strong>   <asp:Label ID="lblUser" CssClass="user-name-label" runat="server" Text="" ></asp:Label> 
                     &nbsp;&nbsp;&nbsp;&nbsp; 
                     <asp:Button ID="Button1" runat="server" CssClass="button-logout" Text="Log Out" OnClick="btnLoggOut_Click" />
                    </div>
                 <div class="clr"></div>

               

            </div>
        </div>

     
      	
    </div>

            </div>

         <br /> <br /> <br /> <br /> <br /> <br /> <br />
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
    </form>
</body>
</html>