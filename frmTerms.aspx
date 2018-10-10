<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmTerms.aspx.cs" Inherits="IEF_Visualization.frmTerms" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Terms & Conditions</title>

    <link href="css/jquery-ui.css" rel="stylesheet" />
    
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/footer-distributed-with-address-and-phones.css" rel="stylesheet" />
    <link href="css/body.css" rel="stylesheet" />
    <!-- css -->

    <script src="bootstrap/js/jquery-1.10.2.min.js"></script>
    <script src="bootstrap/bootstrap/js/bootstrap.min.js"></script>

    <style type="text/css">
        
        .col-md-8 {
            text-align:left;

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
                        <li><a href="frmUserGuide.aspx">User Guide</a></li>
                        <li><a href="http://www.industrialecology.uni-freiburg.de" target="_blank">Home</a></li>
          <li><asp:Button ID="btnLogOut" runat="server" class="btn btn-info" Text="Log Out" OnClick="btnLoggOut_Click" /></li>

                 
      </ul>
      
  </div>
</nav>
        <div class="container-fluid"  style="background-color:white" >
        <div class="row">  

                      <div class= "col-md-12" >
                          <br />
              <h2>Description and terms of use: </h2> 

<br />
                          <h5>+ The CircularSankey web application is a free tool provided by Industrial Ecology Freiburg.</h5>

                          <h5>+ The software for the web app and the Sankey Method are part of an open source project. [‘Code is available on request and will be moved to a public repository.’]</h5>
                         
                          <h5>+ The app runs on a virtual windows machine hosted by the computer centre of the Uni Freiburg, Germany.</h5>
                         
                          <h5>+ Regular backups of the virtual machine are created by the computer centre.</h5>
                        
                          <h5>+ User credentials and projects are stored in a MySQL database on the virtual machine.</h5>
                         
                          <h5>+ Data transmission via the login form and the main text fields in the app is not encrypted.</h5>
                          
                          <h5>+ The app does not store any Sankey data unless you click on the ‘Save into database’, ‘Update Data’, or ‘Save As’ buttons.</h5>
                         
                          <h5> + This app is a development project. The web admins of IEF have full access to the database, including your user credentials and stored data.</h5>
                         
                          <h5> + The figures created by the app are yours.</h5>
                          
                          <h5> + IEF does not guarantee for the security of your login credentials and data.</h5>
                          
       </div>
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

     
      	 <br /> <br /> <br /> <br /> <br /> <br /> <br />
   

            </div>

        
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
