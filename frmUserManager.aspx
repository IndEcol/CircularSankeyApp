<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmUserManager.aspx.cs" Inherits="IEF_Visualization.frmUserManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>User Manager</title>
     <link href="css/jquery-ui.css" rel="stylesheet" />
    
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/footer-distributed-with-address-and-phones.css" rel="stylesheet" />
    <link href="css/body.css" rel="stylesheet" />
    <!-- css -->

    <!-- JavaScriptLibrary -->
        <script src="scripts/lib/jquery-1.12.4.js"></script>
    <script src="scripts/lib/jquery-ui.js"></script>

    <style type="text/css">
        

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

  .gridview{	
	font-family:Tahoma;
	color:#ffffff;
	text-decoration:none;
	 font-size:12px;
	text-align:center;
	margin-left:1px;  width:100%;
	
}
  

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

        <script>

        function checkPass() {
            var pass1 = document.getElementById('txtPassword');
            var pass2 = document.getElementById('txtRPassword');
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
                message.innerHTML = " you have to enter at least 6 digit!"
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
            (["txtPassword", "txtRPassword"]).forEach(function (field_name) {
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
                        <li><a href="frmCircularSankey.aspx">Sankey Diagram</a></li>
                        <li><a href="frmBuildMap.aspx">Map Maker</a></li>
                        <li><a href="frmBuildChart.aspx">Pie Chart</a></li>
                        <li><a href="frmUserProfile.aspx">Your History</a></li>
                        <li><a href="frmUserGuide.aspx">User Guide</a></li>
                        <li><a href="http://www.indecol.uni-freiburg.de/de/team-kontakt " target="_blank">Contact</a></li>
          <li><asp:Button ID="btnLogOut" runat="server" class="btn btn-info" Text="Log Out" OnClick="btnLoggOut_Click" /></li>

                 
      </ul>
      
  </div>
</nav>
        <div class="container-fluid" >
        <div class="row">  
            <h3>User Manager:</h3>
              <br />
            <div class="col-md-5">
                  <br />
                <h5>Please fill up the information bellow to create a new user. All fields are mendatory!</h5>
 <table class="table table-bordered">
            <tr>
                <td>First Name:</td>
                <td>
                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Last Name:</td>
                <td>
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Email Address:</td>
                <td>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>User Name:</td>
                <td>
                    <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Organization Name:</td>
                <td>
                    <asp:TextBox ID="txtOrg" runat="server" CssClass="form-control"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Enter Password:</td>
                <td>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"  onkeyup="checkPass(); return false;"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Repeat Password:</td>
                <td>
                    <asp:TextBox ID="txtRPassword" runat="server" CssClass="form-control" TextMode="Password"  onkeyup="checkPass(); return false;"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td>Please select user type:</td>
                <td>
                    <asp:DropDownList ID="drdUserType" runat="server" CssClass="form-control">
                        <asp:ListItem>admin</asp:ListItem>
                        
                        <asp:ListItem>student</asp:ListItem>
                        <asp:ListItem>faculty</asp:ListItem>
                    </asp:DropDownList>
                    
                   
                </td>
            </tr>
     <tr>
                
                <td colspan="2" align="center">
                  <asp:Label ID="lvlmessage" runat="server" Text=""></asp:Label>
                </td>
            </tr>
             
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="btnAddUser" runat="server" CssClass="btn btn-info" Text="Add User" OnClick="btnAddUser_Click" OnClientClick="validate(); return false;"  />
                </td>
            </tr>
        </table>
            </div>
                      <div class= "col-md-7" >
                          <br />
                          
                
                    
                      <asp:GridView ID="grdUserList" runat="server" AutoGenerateColumns="False" CellPadding="2" ForeColor="Black" GridLines="None" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CssClass="gridview" 
                          OnRowCancelingEdit="grdUserList_RowCancelingEdit" OnRowDeleting="grdUserList_RowDeleting" OnRowEditing="grdUserList_RowEditing" OnRowUpdating="grdUserList_RowUpdating" >
                                                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                                                <Columns>
                                                    <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" >
                                                    <ItemStyle Width="3%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="user_name" HeaderText="User Name" ReadOnly="True" >
                                                    <ItemStyle HorizontalAlign="Center" Width="7%" />
                                                    </asp:BoundField>



                                                    <asp:BoundField DataField="user_password" HeaderText="Password" >
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                    </asp:BoundField>
                                                    

                                                    <asp:TemplateField HeaderText="User Type" SortExpression="User Type">
                    <EditItemTemplate>
                         <asp:DropDownList ID="drdGridUserType" runat="server">
                        <asp:ListItem>admin</asp:ListItem>
                        <asp:ListItem>student</asp:ListItem>
                        <asp:ListItem>faculty</asp:ListItem>
                             <asp:ListItem>general</asp:ListItem>
                    </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblGridUserType" runat="server" Text='<%# Bind("user_type") %>'></asp:Label>
                    </ItemTemplate>
                                                        <ItemStyle Width="7%" />
                </asp:TemplateField>


                                                    <asp:BoundField DataField="first_name" HeaderText="First Name">
                                                    <ItemStyle Width="7%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="last_name" HeaderText="Last Name">
                                                    <ItemStyle Width="7%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="institution_name" HeaderText="Institution Name">
                                                    <ItemStyle Width="12%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="email" HeaderText="Email">
                                                    <ItemStyle Width="20%" />
                                                    </asp:BoundField>
                                                    <asp:CommandField ShowEditButton="True" >
                                                    <ItemStyle Width="10%" />
                                                    </asp:CommandField>
                                                    <asp:CommandField ShowDeleteButton="True" >
                                                    <ItemStyle Width="7%" />
                                                    </asp:CommandField>
                                                </Columns>
                                                <FooterStyle BackColor="Tan" />
                                                <HeaderStyle BackColor="Tan" Font-Bold="True" />
                                                <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                                                <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                                                <SortedAscendingCellStyle BackColor="#FAFAE7" />
                                                <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                                                <SortedDescendingCellStyle BackColor="#E1DB9C" />
                                                <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                                            </asp:GridView>
               

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
         <br />
         <br />
         <br />
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
                        email: in4mation@indecol-freiburg.de <br>
                        Germany</p>
				</div>

			</div>

			

		</footer>
    </form>
</body>
</html>