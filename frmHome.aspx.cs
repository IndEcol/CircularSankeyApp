using IEF_Visualization.cls;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IEF_Visualization
{
    public partial class frmHome : System.Web.UI.Page
    {
        clsCommon clsCommon = new clsCommon();
        clsUserManager objUserManager = new clsUserManager();
        public string authorization_level = "1";  // 1 for admin type user; 2 for general user and 3 for guest user;
        public string userName;
        public string password;
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //userName = "stefan21";
            //password = "stefan21";

            userName = Convert.ToString(txtUserName.Text);
            password = Convert.ToString(txtPassword.Text);

            bool login_status = clsCommon.checkLogin(userName, password);



            if (login_status == true)
            {
                
                string full_user_name = clsCommon.GetUserFullName(userName, password);
                string user_type = clsCommon.user_type(userName, password);
                Session["USER_NAME"] = userName;
                Session["USER_FULL_NAME"] = full_user_name;
                Session["USER_TYPE"] = user_type;
                Response.Redirect("frmCircularSankey.aspx", false);

            }
            else
            {
                string script = "alert('" + "Please enter valid user name and password" + "');";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "UserSecurity", script, true);
            }
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            bool user_check = objUserManager.checkLogin(txtRUserName.Text);

            if (user_check == false)
            {

                objUserManager.firstName = Convert.ToString(txtRFirstName.Text);
                objUserManager.lastName = Convert.ToString(txtRLastName.Text);
                objUserManager.email = Convert.ToString(txtREmail.Text);
                objUserManager.institution = Convert.ToString(txtROrg.Text);
                objUserManager.userName = Convert.ToString(txtRUserName.Text);
                objUserManager.password = Convert.ToString(txtRPassword.Text);

                objUserManager.userType = "general";


                string[] old_jobs = { "stefan0164", "stefan0165", "stefan0167", "stefan0168" };

                objUserManager.SaveData();

                for(int i = 0; i < old_jobs.Length; i++)
                {
                    string new_job_id = objUserManager.createJobID(Convert.ToString(txtRUserName.Text));
                    objUserManager.CopyData(Convert.ToString(txtRUserName.Text), new_job_id, old_jobs[i]);
                }
                
                //ShowMessage("Record submitted successfully", MessageType.Success);

                //string script = "alert('" + "Congratulations! Registration Successfull" + "');";
                //ScriptManager.RegisterStartupScript(this, typeof(Page), "UserSecurity", script, true);
                //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "$('#loginbox').hide(); $('#signupbox').show()", true);
                //Response.Redirect(Request.RawUrl);

                //string full_user_name = clsCommon.GetUserFullName(Convert.ToString(txtRUserName.Text), Convert.ToString(txtRPassword.Text));
                //string user_type = clsCommon.user_type(Convert.ToString(txtRUserName.Text), Convert.ToString(txtRPassword.Text));

                //Session["USER_NAME"] = userName;
                //Session["USER_FULL_NAME"] = full_user_name;
                //Session["USER_TYPE"] = user_type;
                //Response.Redirect("frmCircularSankey.aspx", true);
                //HttpContext.Current.ApplicationInstance.CompleteRequest();

                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "$('#loginbox').hide(); $('#signupbox').show()", true);
                lvlmessage.ForeColor = Color.Green;
                lvlmessage.Text = "Congratulations! Registration Successfull. Please use the Login panel to log on";

            }
            else
            {
                //string script = "alert('" + "User Name already exists, Please try another" + "');";
                //ScriptManager.RegisterStartupScript(this, typeof(Page), "UserSecurity", script, true);

                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "$('#loginbox').hide(); $('#signupbox').show()", true);
                
                lvlmessage.ForeColor = Color.Red;
                lvlmessage.Text= "User name already exists, please try another";
                 
            }
        }
        //public enum MessageType { Success, Error, Info, Warning };
        //protected void ShowMessage(string Message, MessageType type)
        //{
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
        //}
    }


}