<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmAboutUs.aspx.cs" Inherits="IEF_Visualization.frmAboutUs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>About Us</title>
     <style type="text/css">
        
html, #page {
    padding-left: 7%;
}
body {
    color: #535353;
    font: 12px/2em sans-serif;
    margin: 0;
    padding: 0;
    width: 86%;
}
h1, h2, h3, h4, h5, h6 {
    color: darkgreen;
}
#page {
    background: #fff none repeat scroll 0 0;
}
#header, #footer, #top-nav, #content, #content #contentbar, #content #sidebar {
    margin: 0;
    padding: 0;
}
#logo {
    float: left;
    padding: 0;
    width: auto;
}
#logo h1 a, h1 a:hover {
    color: darkgreen;
    text-decoration: none;
}
#logo h1 span {
    color: lightgreen;
}
#header {
    background: #fff none repeat scroll 0 0;
}
#header-inner {
    margin: 0 auto;
    padding: 0;
}
.feature {
    /*background: green none repeat scroll 0 0;*/
    padding-top: 30px;
    padding-bottom: 25px;
}
.feature-inner {
    margin: auto;
}
.feature-inner h1 {
   color: green;
    font-size: 22px;
}
#top-nav {
    float: right;
    height: 37px;
    margin: 0 auto;
    padding: 0;
}
#top-nav ul {
    float: left;
    height: 37px;
    list-style: outside none none;
    padding: 0;
}
#top-nav ul li {
    float: left;
    margin: 0;
    padding: 0 0 0 8px;
}
#top-nav ul li a {
    color: green;
    display: block;
    margin: 0;
    padding: 8px 20px;
    text-decoration: none;
}
#top-nav ul li.active a, #top-nav ul li a:hover {
    color: lightgreen;
}
#content-inner {
    background: #fff none repeat scroll 0 0;
    margin: 0 auto;
    padding: 25px 0;
}
#content #contentbar {
    float: left;
    margin: 0;
    padding: 0;
    width: 55%;
}
#content #contentbar .article {
    margin: 0 0 24px;
}
#content #contentbar .article img {
     max-width:100%; 
  max-height:100%;
  margin:auto;
  display:block;
}
#content #sidebar {
       /*border: 2px solid;*/
    float: right;
    padding: 0;
    width: 35%;
}

#content #sidebar .widget-article {
    line-height: 1.4em;
    margin: 0 0 70px;
    font-size:14px;
}
#content #sidebar .widget-article h3 a {
    text-decoration: none;
    font-size:16px;
}

#content #sidebar .widget-login {
    border: 1px solid;
    border-radius: 2px;
    font-size: 14px;
    line-height: 1.4em;
    margin: 3px 4px 12px;
    padding-left: 5px;
    width: 80%;
}
#content #sidebar .widget-login h3 a {
    text-decoration: none;
    font-size:16px;
}

.table-login{
    width:100%;
}

.table-login td {
    font-size: 14px;
    padding: 5px;
}

#footer {
    background: #fff none repeat scroll 0 0;
}
#footer-inner {
    margin: auto;
    padding: 12px;
    text-align: center;
    width: 922px;
}
#footer a {
    color: green;
    text-decoration: none;
}
.clr {
    clear: both;
    font-size: 0;
    line-height: 0;
    margin: 0;
    padding: 0;
    width: 100%;
}

.button-login {
    background-color: green;
    border: medium none;
    border-radius: 5px;
    color: white;
    display: inline-block;
    font-size: 14px;
    padding: 4px 17px;
    text-align: center;
    text-decoration: none;
}


  .textbox { 
    background: white none repeat scroll 0 0;
    border: 1px solid #ffa853;
    border-radius: 2px;
    color: #666;
    font-size: 14px;
    height: 23px;
    outline: medium none;
    width: 140px;
  } 

 
      #map {
        height: 400px;
        width: 30%;
       }


    </style>
     

</head>
<body>
    <form id="form1" runat="server">
   <div id="page">
        <header id="header">
            <div id="header-inner">
                <div id="logo">
                    <h1><a href="#">Circular<span>Sankey</span></a></h1>
                </div>
                <div id="top-nav">
                    <ul>
                                               <li><a href="frmHome.aspx">Login</a></li>
                        <li><a href="frmCircularSankeyLP.aspx">Sankey Diagram</a></li>
                        <li><a href="frmBuildMap.aspx">Map Maker</a></li>
                        <li><a href="frmBuildChart.aspx">Pie Chart</a></li>
                        <li><a href="frmUserProfile.aspx">Your History</a></li>
                        <li><a href="frmUserGuide.aspx">User Guide</a></li>
                        <li><a href="frmAboutUs.aspx">About Us</a></li>
                    </ul>
                </div>
                <div class="clr"></div>
            </div>
        </header>
        <div class="feature">
            <div class="feature-inner">
                <h1>Welcome to the industrial ecology group in Freiburg!</h1>
            </div>
        </div>


        <div id="content">
            <div id="content-inner">

                 <div id ="logindiv" style="float:right">
                   <strong style="color:green; font-size:14px;"> Hello,</strong>   <asp:Label ID="lblUser" CssClass="user-name-label" runat="server" Text="" ></asp:Label> 
                     &nbsp;&nbsp;&nbsp;&nbsp; 
                     <asp:Button ID="btnLoggOut" runat="server" CssClass="button-logout" Text="Log Out" OnClick="btnLoggOut_Click" />
                    </div>
                 <div class="clr"></div>
                <main id="contentbar">
                    <div class="article">
                        
          
				<div>

                    <h3>Industrial Ecology <span>Freiburg</span></h3>
					<p>  &copy; 2017 Stefan Pauliuk &amp; Mahadi Hasan<br>
                        Sustainable Energy and Material Flow Management (Industrial Ecology) <br>
                        Faculty of Environment and Natural Resources <br>
                       
					       Tennenbacher Straße 4 <br>
                         D-79106 Freiburg <br>
                        email: in4mation@indecol-freiburg.de <br>
                        Germany</p>
				</div>

	

                    </div>
                </main>

               
                     <div class="widget-article">
                       
                       <h3>How to find us</h3>
                          
 <div id="map"></div>
    <script>
      function initMap() {
          var uluru = { lat: 48.0032620, lng: 7.8530670 };
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 15,
          center: uluru
        });
        var marker = new google.maps.Marker({
          position: uluru,
          map: map
        });
      }
    </script>
    <script
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD0DrfdI132YVMDV7rHYYIuzOVMnDsRpVI&callback=initMap">
    </script>
    

                
                <div class="clr"></div>
            </div>
        </div>

     
        <footer id="footer">
            <div id="footer-inner">
                <p>&copy; Copyright <a href="frmAboutUs.aspx">Stefan Pauliuk</a> &#124; <a href="#">Terms of Use</a> &#124; <a href="#">Privacy Policy</a></p>
                <div class="clr"></div>
            </div>
        </footer>
    </div>
    </form>
</body>
</html>
