using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IEF_Visualization
{
    public partial class frmAboutUs : System.Web.UI.Page
    {
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
        }

        protected void btnLoggOut_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Response.Redirect("frmHome.aspx", false);
        }
    }
}