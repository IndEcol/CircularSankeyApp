<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmHome.aspx.cs" Inherits="IEF_Visualization.frmHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <title>Industrial Ecology Freiburg - Visualization</title>

    <link href="css/jquery-ui.css" rel="stylesheet" />
    
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/footer-distributed-with-address-and-phones.css" rel="stylesheet" />
    <link href="css/body.css" rel="stylesheet" />
    <!-- css -->
    <script src="scripts/lib/jquery-3.1.1.min.js"></script>
    <style>

       


.col-md-7 {
    float: left;

    background-color:none;
    padding-bottom: 20px;
}
.col-md-7 p a, p a:hover {
    color: darkgreen;
    font-weight:bold;
    font-size:24px;
    text-decoration: none;
}
.col-md-7 p span {
    color: lightgreen;
}

        .table {
    margin-bottom: 20px;
    margin-top: 0px;
}
        
        input[type=text], input[type=password], select, textarea {
    width: 100%; /* Full width */
    padding: 2px; /* Some padding */ 
    border: 1px solid #ccc; /* Gray border */
    border-radius: 2px; /* Rounded borders */
    box-sizing: border-box; /* Make sure that padding and width stays in place */
    
    resize: vertical /* Allow the user to vertically resize the textarea (not horizontally) */
}

/* Style the submit button with a specific background color etc */
input[type=submit] {
    background-color: #4CAF50;
    color: white;
    padding: 8px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

/* When moving the mouse over the submit button, add a darker green color */
input[type=submit]:hover {
    background-color: #45a049;
}

/* Add a background color and some padding around the form */
.container {
    border-radius: 5px;
    background-color: #f2f2f2;
    padding: 20px;
}

  .navbar-custom .navbar-nav > li > a {
    font-weight: bold;

}
    </style>
 

    <script>

        function checkPass() {
            var pass1 = document.getElementById('txtRPassword');
            var pass2 = document.getElementById('txtRRPassword');
            var message = document.getElementById('lvlmessage');
            var goodColor = "#66cc66";
            var badColor = "#ff6666";

            if (pass1.value.length > 5) {
                pass1.style.backgroundColor = goodColor;
                message.style.color = goodColor;
                message.innerHTML = "character number ok!"
            }
            else {
                pass1.style.backgroundColor = badColor;
                message.style.color = badColor;
                message.innerHTML = " Password must be at least six characters long!"
                return;
            }

            if (pass1.value == pass2.value) {
                pass2.style.backgroundColor = goodColor;
                message.style.color = goodColor;
                message.innerHTML = "ok!"
            }
            else {
                pass2.style.backgroundColor = badColor;
                message.style.color = badColor;
                message.innerHTML = " These passwords don't match"
            }
        }

        function validate() {
            (["txtRFirstName","txtRLastName","txtREmail","txtRPassword", "txtRRPassword"]).forEach(function (field_name) {
                var field_val = document.getElementById(field_name).value;
                if (field_val.length<1) {
                    alert("Please fill all the required fields");
                    return false;
                }
                else {
                    return true;
                }
            });
        }

        function open_registration() {
            $('registration').show();
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
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
          
                    <li><a href="frmHome.aspx">Login</a></li>
                        <li><a href="frmCircularSankey.aspx">Sankey Diagram</a></li>
                        <li><a href="frmBuildMap.aspx">Map Maker</a></li>
                        <li><a href="frmBuildChart.aspx">Pie Chart</a></li>
                        <li><a href="frmUserProfile.aspx">Your History</a></li>
                        <li><a href="frmUserGuide.aspx">User Guide</a></li>
                        <li><a href="http://www.industrialecology.uni-freiburg.de" target="_blank">Home</a></li>

                    
      </ul>
     
    </div>
  </div>
</nav>

<div class="container-fluid" style="background-color:white" >
    <div class="row">
        
        <div class= "col-md-7">
            <br />
            <p><a href="#">Welcome to Circular<span>Sankey</span></a></p>
            </div>
         <div class= "col-md-5">
        </div>
       </div>

      <div class="row">  
                <div class= "col-md-7">
                    
                    <h5>Circular Sankey web application does not create perfect Sankeys...</h5>
&nbsp;<img class="img-responsive center-block" src="resources/sampleSankey_raw.png" style=" align-self:center; width:500px;"  alt="Sample Sankey Raw" />

                    <br />
                    <h5>... but it delivers vector graphics that require only little editing before becoming presentable!</h5>
                      <br />
                    <h5>Our goal is to deliver a tool that saves you 90% of the work of creating a perfect Sankey diagram.</h5>
                    <h5>For the remaining 10% you can use your creative spirit and dive into a graphics program like Inkscape, for example.</h5>
                   

&nbsp;<img class="img-responsive center-block" src="resources/sampleSankey_final.png" style=" align-self:center; width:500px;"   alt="Sample Sankey Refined" />

                    <br />
                     <h5>The web app has an internal database to store projects for later use. It also features an interface to excel data files, which can be uploaded and downloaded from within the app. Got curious?</h5>
                    <h5>Then sign up by filling out the form on the right or log in with the guest account: User: "guest01", password: "guest01" (without ")!</h5>
                    <h5>Video tutorial (8 mins) with an introduction to the CircularSankey app: <a href="https://www.youtube.com/watch?v=CUKCh2T9QHs"  target="_blank"">(Youtube)</a></h5>
                    <h5>Video tutorial (7 mins) with an explanation of the Excel interface to the CircularSankey app: <a href="https://www.youtube.com/watch?v=7d-mHhjt_FQ"  target="_blank"">(Youtube)</a></h5>
                     <h5>This web application was developed by Mahadi Hasan, resident programmer of Industrial Ecology Freiburg. [link will be added soon]</h5>
                   <br />
                    <p><a href="frmTerms.aspx"  target="_blank"">Description and terms of use:</a></p>

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
   
                      <div class= "col-md-5">

                           <div id="loginbox" style="" class="mainbox col-md-10 col-md-offset-2 col-sm-8 col-sm-offset-2">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <div class="panel-title">Sign In</div>
                   <%-- <div style="float:right; font-size: 80%; position: relative; top:-10px"><a href="#">Forgot password?</a></div>--%>
                </div>
                <div style="padding-top:30px" class="panel-body">
                    <div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>
                    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnLogin">
                     <table class="table table-responsive">
            <tr>
                <td>User Name:</td>
                <td>
                     <asp:TextBox ID="txtUserName" runat="server"  class="form-control" placeholder="username"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td>Enter Password:</td>
                <td>
                    <asp:TextBox ID="txtPassword" runat="server" type="text" TextMode="Password" class="form-control" placeholder="password"></asp:TextBox>
                </td>
            </tr>
    
            <tr>
                
                <td colspan="2" align="center">
                  <asp:Button ID="btnLogin" runat="server" class="btn btn-success" Text="Login" OnClick="btnLogin_Click" usesubmitbehavior="false" ></asp:Button>
                      
                </td>
            </tr>
             <tr>
                
                <td colspan="2" align="center">
                  Don't have an account!
                                    <a href="#" onClick="$('#loginbox').hide(); $('#signupbox').show()">
                                        Sign Up Here
                                    </a>
                </td>
            </tr>
        </table>
</asp:Panel>
                

                </div>
            </div>
        </div>
        <div id="signupbox" style="display:none;" class="mainbox col-md-12 ">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <div class="panel-title">Sign Up</div>
                    <div style="float:right; font-size: 85%; position: relative; top:-10px"><a id="signinlink" href="#" onclick="$('#signupbox').hide(); $('#loginbox').show()">Sign In</a></div>
                </div>
                <div class="panel-body">

                        <div id="signupalert" style="display:none" class="alert alert-danger">
                            <p>Error:</p>
                            <span></span>
                        </div>

<asp:Panel ID="Panel2" runat="server" DefaultButton="btnAddUser">

 <table class="table table-responsive">
            <tr>
                <td>First Name:*</td>
                <td>
                    <asp:TextBox ID="txtRFirstName" runat="server" CssClass="form-control" required autofocus></asp:TextBox>
                </td>
                 <td>Last Name:*</td>
                <td>
                    <asp:TextBox ID="txtRLastName" runat="server" CssClass="form-control" required autofocus></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Email Address:*</td>
                <td>
                    <asp:TextBox ID="txtREmail" runat="server" CssClass="form-control" TextMode="Email" required autofocus></asp:TextBox>
                </td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>User Name:*</td>
                <td>
                    <asp:TextBox ID="txtRUserName" runat="server" CssClass="form-control" required autofocus></asp:TextBox>
                </td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>Organization Name:</td>
                <td>
                    <asp:TextBox ID="txtROrg" runat="server" CssClass="form-control"></asp:TextBox>
                </td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>Enter Password:*</td>
                <td>
                    <asp:TextBox ID="txtRPassword" runat="server" CssClass="form-control" TextMode="Password"  onkeyup="checkPass(); return false;" required autofocus></asp:TextBox>
                </td>
                <td>Repeat Password:*</td>
                <td>
                    <asp:TextBox ID="txtRRPassword" runat="server" CssClass="form-control" TextMode="Password"  onkeyup="checkPass(); return false;" required autofocus></asp:TextBox>
                </td>
            </tr>

     <tr>
                
                <td colspan="4" align="center">
                  <asp:Label ID="lvlmessage" runat="server" Text="">
                      (*) marked fields are mendatory for a successful registration!  <br />
                      Please do remember your username and password, we will not send a confirmation email!
                  </asp:Label>
                    
                </td>
            </tr>
      <tr>
                
                <td colspan="4" align="center">
          
                   <asp:Button ID="btnAddUser" runat="server" CssClass="btn btn-info" Text="Add User" OnClick="btnAddUser_Click"/>

                </td>
            </tr>
        </table>
                       
    </asp:Panel>
                </div>
            </div>



        </div>


                           </div>
          
                    
          </div>

     <br />
                     <br />
                    <br />
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
                        email: in4mation@indecol.uni-freiburg.de <br>
                        </p>
				</div>

			</div>

			

		</footer>
        
    </form>
    
</body>
</html>

