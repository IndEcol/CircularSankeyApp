using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IEF_Visualization.cls;

namespace IEF_Visualization
{
    public partial class frmBuildChart : System.Web.UI.Page
    {
        clsDataHandling objDataHandling = new clsDataHandling();

        protected void Page_Load(object sender, EventArgs e)
        {
            //string user_name = Session["USER_NAME"] as string;
            ////string user_name = "stefan21";
            //objDataHandling.user_name = user_name;


            //if (user_name == null || user_name == "")
            //{
            //    Response.Redirect("frmLogin.aspx", false);
            //}
            //else
            //{

            //    //lbl_hi_user.Text = user_name;
            //}


            if (!Page.IsPostBack)
            {
                //string queryId = Request.QueryString["queryId"];
                //if (queryId != null)
                //{
                //    string data = objDataHandling.getData(queryId, txtRemarks, txtproject_name);
                //    input_flow_data.InnerText = data;
                //    btnSave.Text = "Update";
                //}


            }


        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string user_name = Session["USER_NAME"] as string;
            //string user_name = "stefan21";
            objDataHandling.user_name = user_name;
            objDataHandling.flow_data = Convert.ToString(input_flow_data.InnerText);
            objDataHandling.remarks = Convert.ToString(txtRemarks.Text);
            objDataHandling.project_name = Convert.ToString(txtproject_name.Text);
            objDataHandling.type = "Pie Chart";
            string queryId = Request.QueryString["queryId"];
            if (queryId != null)
            {
                objDataHandling.UpdateData(queryId);

                string script = "alert('" + "Data has been updated successfully" + "');";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "UserSecurity", script, true);
            }
            else
            {
                //objDataHandling.SaveData();
                string script = "alert('" + "Data has been saved successfully" + "');";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "UserSecurity", script, true);

            }
        }

        protected void btnLoggOut_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Response.Redirect("frmHome.aspx", false);
        }
    }
}