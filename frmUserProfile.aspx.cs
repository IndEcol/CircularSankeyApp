using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IEF_Visualization.cls;

namespace IEF_Visualization
{
    public partial class frmUserProfile : System.Web.UI.Page
    {
        clsDataHandling objDataHandling = new clsDataHandling();
        protected void Page_Load(object sender, EventArgs e)
        {
            
            string user_name = Session["USER_NAME"] as string;
            
            //user_name = "stefan21";
            objDataHandling.user_name = user_name;
            if (user_name == null || user_name == "")
            {
                Response.Redirect("frmHome.aspx", false);
            }
            else
            {
                lblUser.Text = Session["USER_FULL_NAME"] as string;
                //lbl_hi_user.Text = user_name;
            }

            objDataHandling.showData(grdSankeyHistory);
        }

        protected void grdSankeyHistory_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "view")
            {
                LinkButton lnkView = (LinkButton)e.CommandSource;
                string job_id = lnkView.CommandArgument;

                //Response.Redirect("frmCircularSankeyLP.aspx?job_id=" + job_id + "&&ID=" + job_id);
                Response.Redirect("frmCircularSankey.aspx?job_id=" + job_id);

            }

            if (e.CommandName == "Delete")
            {
                LinkButton lnkView = (LinkButton)e.CommandSource;
                string job_id = lnkView.CommandArgument;

                objDataHandling.DeleteData(job_id);
                objDataHandling.showData(grdSankeyHistory);

                string script = "alert('" + "Data has been deleted successfully" + "');";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "UserSecurity", script, true);

            }
        }

        protected void grdSankeyHistory_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //GridViewRow row = grdSankeyHistory.Rows[e.RowIndex];

            //string id = Convert.ToString(row.Cells[0].Text);

            //objDataHandling.DeleteData(id);
            //objDataHandling.showData(grdSankeyHistory);

            //string script = "alert('" + "Data has been deleted successfully" + "');";
            //ScriptManager.RegisterStartupScript(this, typeof(Page), "UserSecurity", script, true);
        }

        protected void grdSankeyHistory_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    foreach (Button button in e.Row.Cells[8].Controls.OfType<Button>())
            //    {
            //        if (button.CommandName == "Delete")
            //        {
            //            button.Attributes["onclick"] = "if(!confirm('Do you want to delete')){return false;};";
            //        }

            //    }
            //}
        }


        protected void btnLoggOut_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Response.Redirect("frmHome.aspx", false);
        }

    }
}