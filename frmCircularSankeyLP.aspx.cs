using System;
using System.Data;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.UI;
using IEF_Visualization.cls;
using Microsoft.Office.Interop.Excel;
using ClosedXML.Excel;
using System.Collections;

namespace IEF_Visualization
{
    public partial class frmCircularSankeyLP : System.Web.UI.Page
    {
        clsDataHandling objDataHandling = new clsDataHandling();

        protected void Page_Load(object sender, EventArgs e)
        {
            string user_name = Session["USER_NAME"] as string;
            //string user_name = "stefan21";
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

            if (!Page.IsPostBack)
            {
                string job_id = Request.QueryString["job_id"];
                if (job_id != null)
                {
                    //ArrayList controllersID = new ArrayList();
                    //getControllersID(controllersID);
                    ArrayList controllers_data = objDataHandling.getData(job_id);
                    setControllersData(controllers_data);
                    btnSave.Text = "Update Data";
                    btnSaveAs.Visible = true;
                }

            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string user_name = Session["USER_NAME"] as string;
            objDataHandling.user_name = Session["USER_NAME"] as string;
            objDataHandling.flow_data = Convert.ToString(input_flow_data.InnerText);
            objDataHandling.remarks = Convert.ToString(txtRemarks.Text);
            objDataHandling.project_name = Convert.ToString(txtproject_name.Text);
            objDataHandling.type = "Sankey";

            objDataHandling.node_data = Convert.ToString(input_node_data.InnerText);
           
            objDataHandling.default_node_color = "";
            objDataHandling.default_flow_color = "";
            objDataHandling.background_color = Convert.ToString(background_color.Text); // "#ffffff";
            objDataHandling.drag_option = show_labels.Checked;
            objDataHandling.curviness = Convert.ToDouble(curvature.Value); // 0.5;
            objDataHandling.diagram_width = Convert.ToInt32(canvas_width.Text); //  900;
            objDataHandling.diagram_height = Convert.ToInt32(canvas_height.Text); //  900;
            objDataHandling.flow_opacity = Convert.ToDouble(default_flow_opacity.Value); //  0.9;
            objDataHandling.node_opacity = Convert.ToDouble(default_node_opacity.Value); //  0.9;
            objDataHandling.border = Convert.ToInt32(node_border.SelectedIndex); //  1;
            objDataHandling.level_visibility = show_labels.Checked;
            objDataHandling.font_face = Convert.ToString(font_face.SelectedIndex);
            objDataHandling.font_size = Convert.ToInt32(font_size.Text); //  12;
            objDataHandling.font_color = Convert.ToString(font_color.Text); //  "#add8e6";


            string job_id = Request.QueryString["job_id"];
            if (job_id != null)
            {
                objDataHandling.UpdateData(job_id);

                string script = "alert('" + "Data has been updated successfully" + "');";
                ScriptManager.RegisterStartupScript(this, typeof(System.Web.UI.Page), "UserSecurity", script, true);
            }
            else
            {
                job_id = objDataHandling.createJobID(user_name);
                objDataHandling.SaveData(job_id);
                string script = "alert('" + "Data has been saved successfully" + "');";
                ScriptManager.RegisterStartupScript(this, typeof(System.Web.UI.Page), "UserSecurity", script, true);

            }
        }


        protected void btnDownloadData_Click(object sender, EventArgs e)
        {
            DataSet ds = getDataSetExportToExcel();

            //exportToExcel(ds);

            using (XLWorkbook wb = new XLWorkbook())
            {
                foreach (System.Data.DataTable dt in ds.Tables)
                {
                    wb.Worksheets.Add(dt);
                }

                //Export the Excel file.
                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=DataSet.xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }
        }

        public System.Data.DataTable sampleData(System.Data.DataTable dt)
        {
            DataColumn workCol = dt.Columns.Add("Source", typeof(String));

            dt.Columns.Add("value", typeof(String));
            dt.Columns.Add("target", typeof(String));

            //Add in the datarow
            DataRow newRow = dt.NewRow();

            newRow["Source"] = "A";
            newRow["value"] = "2";
            newRow["target"] = "B";

            dt.Rows.Add(newRow);

            return dt;
        }

        public System.Data.DataTable parsedData(System.Data.DataTable dt, string node_data, string[] colNames)
        {
            //System.Data.DataTable dt = new System.Data.DataTable(tableName);
            string[] lineData = Regex.Split(node_data, "[\r\n]+");
            string pattern = @"\[([^\]]*)\]";

            for (int i = 0; i < colNames.Length; i++)
            {
                dt.Columns.Add(new DataColumn(colNames[i]));
            }

            for (var f = 0; f < lineData.Length - 1; f++)
            {
                MatchCollection matches = Regex.Matches(lineData[f], pattern);
                var row = dt.Rows.Add();

                for (var c = 0; c < matches.Count; c++)
                {
                    row[colNames[c]] = matches[c].Groups[0].Value.Substring(1, matches[c].Groups[0].Value.Length - 2);

                }
            }

            return dt;
        }


        public void CreateCSVFile(System.Data.DataTable dt)
        {
            string attachment = "attachment; filename=city.xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/vnd.ms-excel";
            string tab = "";
            foreach (DataColumn dc in dt.Columns)
            {
                Response.Write(tab + dc.ColumnName);
                tab = "\t";
            }
            Response.Write("\n");
            int i;
            foreach (DataRow dr in dt.Rows)
            {
                tab = "";
                for (i = 0; i < dt.Columns.Count; i++)
                {
                    Response.Write(tab + dr[i].ToString());
                    tab = "\t";
                }
                Response.Write("\n");
            }
            Response.End();
        }

        public DataSet getDataSetExportToExcel()
        {
            DataSet ds = new DataSet();

            string[] colNamesFlow = { "Source", "Value", "Color", "Target" };
            string[] colNamesNodes = { "Name", "Color", "Orientation", "Width", "Height", "X_position", "Y_position" };           

            string flow_data = Convert.ToString(input_flow_data.InnerText);
            string node_data = Convert.ToString(input_node_data.InnerText);

            System.Data.DataTable dt_flow = new System.Data.DataTable("flow_data");
            System.Data.DataTable dt_node = new System.Data.DataTable("node_data");

            //dt_s = sampleData(dt_s);

            dt_flow = parsedData(dt_flow, flow_data, colNamesFlow);
            dt_node = parsedData(dt_node, node_data, colNamesNodes);

            ds.Tables.Add(dt_flow);
            ds.Tables.Add(dt_node);

            return ds;
        }

        protected void btnSaveAs_Click(object sender, EventArgs e)
        {
            string user_name = Session["USER_NAME"] as string;
            //string user_name = "stefan01";
            objDataHandling.user_name = user_name;
            objDataHandling.flow_data = Convert.ToString(input_flow_data.InnerText);
            objDataHandling.remarks = Convert.ToString(txtRemarks.Text);
            objDataHandling.project_name = Convert.ToString(txtproject_name.Text);
            objDataHandling.type = "Sankey";
            objDataHandling.node_data = Convert.ToString(input_node_data.InnerText);

            objDataHandling.default_node_color = "";
            objDataHandling.default_flow_color = "";
            objDataHandling.background_color = Convert.ToString(background_color.Text); // "#ffffff";
            objDataHandling.drag_option = enable_drag.Checked;
            objDataHandling.curviness = Convert.ToDouble(curvature.Value); // 0.5;
            objDataHandling.diagram_width = Convert.ToInt32(canvas_width.Text); //  900;
            objDataHandling.diagram_height = Convert.ToInt32(canvas_height.Text); //  900;
            objDataHandling.flow_opacity = Convert.ToDouble(default_flow_opacity.Value); //  0.9;
            objDataHandling.node_opacity = Convert.ToDouble(default_node_opacity.Value); //  0.9;
            objDataHandling.border = Convert.ToInt32(node_border.SelectedIndex); //  1;
            objDataHandling.level_visibility = show_labels.Checked;
            objDataHandling.font_face = Convert.ToString(font_face.SelectedIndex);
            objDataHandling.font_size = Convert.ToInt32(font_size.Text); //  12;
            objDataHandling.font_color = Convert.ToString(font_color.Text); //  "#add8e6";

            string job_id = objDataHandling.createJobID(user_name);
            objDataHandling.SaveData(job_id);
            string script = "alert('" + "Data has been saved successfully" + "');";
            ScriptManager.RegisterStartupScript(this, typeof(System.Web.UI.Page), "UserSecurity", script, true);

        }

        private ArrayList getControllersID(ArrayList controllersID)
        {
            controllersID.Add("input_flow_data");
            controllersID.Add("txtRemarks");
            controllersID.Add("txtproject_name");
            controllersID.Add("input_node_data");
            controllersID.Add("background_color");
            controllersID.Add("enable_drag");
            controllersID.Add("curvature");
            controllersID.Add("canvas_width");
            controllersID.Add("canvas_height");
            controllersID.Add("default_flow_opacity");
            controllersID.Add("default_node_opacity");
            controllersID.Add("node_border");
            controllersID.Add("show_labels");
            controllersID.Add("font_face");
            controllersID.Add("font_size");
            controllersID.Add("font_color");

            return controllersID;
        }

        private void setControllersData(ArrayList controllers_data)
        {
            string query = "select distinct dm.job_id, dm.project_name, dm.remarks, rd.node_data, rd.default_node_color, rd.flow_data, rd.default_flow_color, ";
            query += "md.background_color, md.border, md.curviness, md.diagram_height, md.diagram_width, md.drag_option, md.flow_opacity, md.node_opacity, ";
            query += "md.font_color, md.font_face, md.font_size, md.level_visibility from raw_data rd, data_master dm, meta_data md ";

            input_flow_data.InnerText = Convert.ToString(controllers_data[5]);
            txtRemarks.Text = Convert.ToString(controllers_data[2]);
            txtproject_name.Text = Convert.ToString(controllers_data[1]);
            input_node_data.InnerText = Convert.ToString(controllers_data[3]);
            background_color.Text = Convert.ToString(controllers_data[7]);
            //enable_drag.Checked = Convert.ToBoolean(controllers_data[12]);
            curvature.Value = Convert.ToString(controllers_data[9]);
            canvas_width.Text = Convert.ToString(controllers_data[11]);
            canvas_height.Text = Convert.ToString(controllers_data[10]);
            //default_flow_opacity13
            //default_node_opacity14
            //node_border.SelectedValue = controllers_data[0];
            //show_labels.Checked = Convert.ToBoolean(controllers_data[18]);
            //font_face.SelectedIndex = Convert.ToString(controllers_data[0]);16
            font_size.Text = Convert.ToString(controllers_data[17]);
            font_color.Text = Convert.ToString(controllers_data[15]);
        }

        protected void btnLoggOut_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Response.Redirect("frmHome.aspx", false);
        }
    }
}