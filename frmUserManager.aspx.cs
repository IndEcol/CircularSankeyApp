using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IEF_Visualization.cls;

namespace IEF_Visualization
{
    public partial class frmUserManager : System.Web.UI.Page
    {
        clsUserManager objUserManager = new clsUserManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            string user_name = Session["USER_NAME"] as string;
            //user_name = "stefan21";
            //objUserManager.user_name = user_name;
            string user_type = Session["USER_TYPE"] as string;
            if (user_name == null || user_name == "" || user_type!="admin")
            {
                Response.Redirect("frmHome.aspx", false);
            }
            else
            {
                lblUser.Text = Session["USER_FULL_NAME"] as string;
                if (!IsPostBack)
                {
                    objUserManager.showUserList(grdUserList);
                }
                //lbl_hi_user.Text = user_name;
            }

            
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            objUserManager.firstName = Convert.ToString(txtFirstName.Text);
            objUserManager.lastName = Convert.ToString(txtLastName.Text);
            objUserManager.email = Convert.ToString(txtEmail.Text);
            objUserManager.institution = Convert.ToString(txtOrg.Text);
            objUserManager.userName = Convert.ToString(txtUserName.Text);
            objUserManager.password = Convert.ToString(txtPassword.Text);

            objUserManager.userType = Convert.ToString(drdUserType.SelectedItem);


            objUserManager.SaveData();

            string script = "alert('" + "User Created Successfully" + "');";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "UserSecurity", script, true);
            Response.Redirect(Request.RawUrl);
            objUserManager.showUserList(grdUserList);
        }

        protected void grdUserList_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdUserList.EditIndex = e.NewEditIndex;
            objUserManager.showUserList(grdUserList);
        }

        protected void grdUserList_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdUserList.EditIndex = -1;
            objUserManager.showUserList(grdUserList);
        }

        protected void grdUserList_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = grdUserList.Rows[e.RowIndex];

            string id = Convert.ToString(row.Cells[0].Text);
            string un = Convert.ToString(row.Cells[1].Text);
            string pa = ((TextBox)(row.Cells[2].Controls[0])).Text;

            string ut = ((DropDownList)(row.Cells[3].Controls[0]).FindControl("drdGridUserType")).SelectedValue.ToString();
            string fn = ((TextBox)(row.Cells[4].Controls[0])).Text;
            string ln = ((TextBox)(row.Cells[5].Controls[0])).Text;
            string og = ((TextBox)(row.Cells[6].Controls[0])).Text;
            string em = ((TextBox)(row.Cells[7].Controls[0])).Text;

            objUserManager.UpdateUser(id, un, pa, ut, fn, ln, og, em);
            grdUserList.EditIndex = -1;
            string script = "alert('" + "User Created Successfully" + "');";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "UserSecurity", script, true);
            Response.Redirect(Request.RawUrl);
            objUserManager.showUserList(grdUserList);
        }

        protected void grdUserList_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow row = grdUserList.Rows[e.RowIndex];

            string un = Convert.ToString(row.Cells[1].Text);

            objUserManager.DeleteUser(un);
            objUserManager.showUserList(grdUserList);
        }

        protected void btnLoggOut_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Response.Redirect("frmHome.aspx", false);
        }
    }
}