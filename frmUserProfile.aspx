<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmUserProfile.aspx.cs" Inherits="IEF_Visualization.frmUserProfile" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User History</title>

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
                        <li class="active"><a href="frmUserProfile.aspx">Your History</a></li>
                        <li><a href="frmUserGuide.aspx">User Guide</a></li>
                        <li><a href="http://www.industrialecology.uni-freiburg.de" target="_blank">Home</a></li>
          <li><asp:Button ID="btnLogOut" runat="server" class="btn btn-info" Text="Log Out" OnClick="btnLoggOut_Click" /></li>

                 
      </ul>
      
  </div>
</nav>
        <div class="container-fluid" >
        <div class="row">  

                      <div class= "col-md-12" >
                          <br />
                          <h3>Your History</h3>
                
                    
                      <asp:GridView ID="grdSankeyHistory" runat="server" AutoGenerateColumns="False" CellPadding="2" ForeColor="Black" GridLines="None" BackColor="LightGoldenrodYellow" 
                          BorderColor="Tan" BorderWidth="1px" CssClass="gridview" OnRowDeleting="grdSankeyHistory_RowDeleting" OnRowCommand="grdSankeyHistory_RowCommand" class="table table-responsive">
                                                <AlternatingRowStyle BackColor="PaleGoldenrod"  />
                                                <Columns>
                                                   

 <asp:TemplateField HeaderText="Serial No">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle Width="2%" />
            </asp:TemplateField>


                                                    <asp:BoundField DataField="user_name" HeaderText="User Name">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="10%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="email" HeaderText="Email">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="16%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PROJECT_NAME" HeaderText="Project Name">
                                                    <ItemStyle Width="15%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="entry_time" HeaderText="Entry Time" >
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="update_time" HeaderText="Update Time" >
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="remarks" HeaderText="Description" >
                                                    <ItemStyle Width="20%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="job_id" HeaderText="Job ID">
                                                    <ItemStyle Width="10%" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="View">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="gvbtnView"  runat="server" CssClass="button"  CausesValidation="false" 
                                                                 CommandName="view"  Text="View"
                CommandArgument='<%# Eval("job_id") %>' EnableTheming="False">  </asp:LinkButton>
                                                         
                                                        </ItemTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Delete">
                                                        <ItemTemplate>
                                                             <asp:LinkButton ID="btnDelete"  runat="server" CssClass="button" OnClientClick="return confirm('Do you want to delete the record? ');"  CausesValidation="false" 
                                                                 CommandName="Delete"  Text="Delete"
                CommandArgument='<%# Eval("job_id") %>' EnableTheming="False">  </asp:LinkButton>
                                                           
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
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
                     <asp:Button ID="btnLoggOut" runat="server" CssClass="button-logout" Text="Log Out" OnClick="btnLoggOut_Click" />
                    </div>
                 <div class="clr"></div>

               

            </div>
        </div>

     
      	
    </div>

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
