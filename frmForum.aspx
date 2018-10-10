<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmForum.aspx.cs" Inherits="IEF_Visualization.frmForum" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Feedback</title>

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
        <div class="container-fluid" >
        <div class="row">  

                      <div class= "col-md-12" >
                          <br /><br /><br />
                          <p>  This tool is under development process. We would like to use your valuable feedback to improve this platform. Therefore, we kindly request you to share your experience. Use the textbox bellow
                    to write your feedback and click the button on the right. You can also edit or delete your feedback using the "Edit" and "Delete" button inside table.</p>
                 <br /> <br />
                    <asp:TextBox ID="txtFeedback" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox> <br />
                          <asp:Button ID="btnAddFeedBack" runat="server" CssClass="btn btn-success" Text="Add Feedback" OnClick="btnAddFeedBack_Click"/> <br /> <br /> <br /> <br /> <br /> <br />


                     <asp:GridView ID="grdFeedback" runat="server" AutoGenerateColumns="False" CellPadding="2" ForeColor="Black" GridLines="None" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CssClass="gridview" OnRowDeleting="grdFeedback_RowDeleting" OnRowUpdating="grdFeedback_RowUpdating" OnRowCancelingEdit="grdFeedback_RowCancelingEdit" OnRowEditing="grdFeedback_RowEditing" >
                                                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                                                <Columns>
                                                    <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" >
                                                    <ItemStyle Width="5%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="user_name" HeaderText="User Name" ReadOnly="True" >
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                    </asp:BoundField>

                                                    <asp:BoundField DataField="feedback" HeaderText="Feedback/Comment">
                                                    <ItemStyle Width="60%" />
                                                         <ControlStyle CssClass="feedback_row_edit" />
                                                    </asp:BoundField>

                                                    <asp:BoundField DataField="ST" HeaderText="Status" >
                                                    <ItemStyle Width="15%" />
                                                        </asp:BoundField>
                                                    <asp:CommandField ShowEditButton="True" >
                                                    <ItemStyle Width="5%" />
                                                    </asp:CommandField>
                                                    <asp:CommandField ShowDeleteButton="True" >
                                                    <ItemStyle Width="5%" />
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
