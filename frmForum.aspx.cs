using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IEF_Visualization.cls;

namespace IEF_Visualization
{
    public partial class frmForum : System.Web.UI.Page
    {
        clsDataHandling objDataHandling = new clsDataHandling();
        protected void Page_Load(object sender, EventArgs e)
        {
            string user_name = Session["USER_NAME"] as string;
            //string user_name = "stefan21";
            //objUserManager.user_name = user_name;

            if (user_name == null || user_name == "")
            {
                Response.Redirect("frmHome.aspx", false);
            }
            else
            {
                lblUser.Text = Session["USER_FULL_NAME"] as string;

                //lbl_hi_user.Text = user_name;
            }

            if (!IsPostBack)
            {
                objDataHandling.showFeedbackGrid(grdFeedback);
            }
        }

        protected void btnAddFeedBack_Click(object sender, EventArgs e)
        {
            string feedback = Convert.ToString(txtFeedback.Text);
            string user_name = Session["USER_NAME"] as string;
            objDataHandling.SaveFeedback(user_name,feedback);

            string script = "alert('" + "Feedback submitted Successfully" + "');";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "UserSecurity", script, true);
            Response.Redirect(Request.RawUrl);
            objDataHandling.showFeedbackGrid(grdFeedback);
        }

        protected void grdFeedback_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow row = grdFeedback.Rows[e.RowIndex];

            string id = Convert.ToString(row.Cells[0].Text);
            string un = Convert.ToString(row.Cells[1].Text);

            objDataHandling.DeleteFeedback(id, un);
            objDataHandling.showFeedbackGrid(grdFeedback);
        }

        protected void grdFeedback_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = grdFeedback.Rows[e.RowIndex];

            string id = Convert.ToString(row.Cells[0].Text);
            string un = Convert.ToString(row.Cells[1].Text);
            string fd = ((TextBox)(row.Cells[2].Controls[0])).Text;

            objDataHandling.UpdateFeedback(id, un, fd);
            grdFeedback.EditIndex = -1;
            objDataHandling.showFeedbackGrid(grdFeedback);
        }

        protected void grdFeedback_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdFeedback.EditIndex = -1;
            objDataHandling.showFeedbackGrid(grdFeedback);
        }

        protected void grdFeedback_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdFeedback.EditIndex = e.NewEditIndex;
            objDataHandling.showFeedbackGrid(grdFeedback);
        }

        protected void btnLoggOut_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Response.Redirect("frmHome.aspx", false);
        }
    }
}