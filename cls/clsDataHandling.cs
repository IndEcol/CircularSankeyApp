using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections;
using System.Web.UI.HtmlControls;
using System.Globalization;
using System.Threading;

namespace IEF_Visualization.cls
{

    public class clsDataHandling
    {
        dbConnect cn = new dbConnect();

        public string node_data;
        public string remarks;
        public string user_name;

        public string default_node_color;
        public string flow_data;
        public string default_flow_color;
        public string background_color;
        public bool drag_option;
        public double curviness;
        public int diagram_width;
        public int diagram_height;
        public double flow_opacity;
        public double node_opacity;
        public int border;
        public bool level_visibility;
        public string font_face;
        public int font_size;
        public string font_color;
        public string unit_name;
        public double flow_width;
        public double node_height;

        //string time = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt");
        string time = DateTime.Now.Year + "." + DateTime.Now.Month + "." + DateTime.Now.Day +
               " " + DateTime.Now.Hour + (":") + DateTime.Now.Minute + (":") + DateTime.Now.Second;

        public string type;
        public string project_name = "";

        public string createJobID(string user_name)
        {
            string job_id = "";
            string query = "select max(id)+1 as id from data_master";


            if (cn.open_connection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, cn.connection);
                MySqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    job_id = user_name + Convert.ToString(reader["id"]);
                }

                reader.Close();
                cn.close_connection();
            }

            return job_id;
        }

        public void SaveData(string job_id)
        {
            SaveToMaster(job_id);
            SaveRawData(job_id);
            SaveMetaData(job_id);

        }

        public void SaveToMaster(string job_id)
        {
            string query = "INSERT into data_master (user_name, job_id, project_name, remarks, entry_time, update_time) ";
            query += "VALUES (@user_name, @job_id,  @project_name, @remarks, @entry_time, @update_time);";


            //open connection
            if (cn.open_connection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd = new MySqlCommand(query, cn.connection);
                cmd.Parameters.AddWithValue("@user_name", user_name);
                cmd.Parameters.AddWithValue("@job_id", job_id);
                cmd.Parameters.AddWithValue("@project_name", project_name);
                cmd.Parameters.AddWithValue("@remarks", remarks);
                cmd.Parameters.AddWithValue("@entry_time", time);
                cmd.Parameters.AddWithValue("@update_time", time);


                cmd.ExecuteNonQuery();
                cn.close_connection();
            }
        }

        public void SaveRawData(string job_id)
        {
            string query = "INSERT into raw_data (job_id, node_data, default_node_color, flow_data, default_flow_color) ";
            query += "VALUES (@job_id, @node_data,  @default_node_color, @flow_data,  @default_flow_color);";

            //open connection
            if (cn.open_connection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd = new MySqlCommand(query, cn.connection);
                cmd.Parameters.AddWithValue("@job_id", job_id);
                cmd.Parameters.AddWithValue("@node_data", node_data);
                cmd.Parameters.AddWithValue("@default_node_color", default_node_color);
                cmd.Parameters.AddWithValue("@flow_data", flow_data);
                cmd.Parameters.AddWithValue("@default_flow_color", default_flow_color);
                cmd.ExecuteNonQuery();
                cn.close_connection();
            }
        }

        public void SaveMetaData(string job_id)
        {
            string query = "INSERT into meta_data (job_id, background_color, drag_option, curviness, diagram_width, diagram_height, flow_opacity, node_opacity, border, ";
            query += "level_visibility, font_face, font_size, font_color,unit_name,flow_width,node_height) ";
            query += "VALUES (@job_id, @background_color, @drag_option, @curviness, @diagram_width, @diagram_height, @flow_opacity, @node_opacity, @border, ";
            query += "@level_visibility, @font_face, @font_size, @font_color, @unit_name, @flow_width, @node_height);";



            //open connection
            if (cn.open_connection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd = new MySqlCommand(query, cn.connection);
                cmd.Parameters.AddWithValue("@job_id", job_id);
                cmd.Parameters.AddWithValue("@background_color", background_color);
                cmd.Parameters.AddWithValue("@drag_option", drag_option);
                cmd.Parameters.AddWithValue("@curviness", curviness);
                cmd.Parameters.AddWithValue("@diagram_width", diagram_width);
                cmd.Parameters.AddWithValue("@diagram_height", diagram_height);
                cmd.Parameters.AddWithValue("@flow_opacity", flow_opacity);
                cmd.Parameters.AddWithValue("@node_opacity", node_opacity);
                cmd.Parameters.AddWithValue("@border", border);
                cmd.Parameters.AddWithValue("@level_visibility", level_visibility);
                cmd.Parameters.AddWithValue("@font_face", font_face);
                cmd.Parameters.AddWithValue("@font_size", font_size);
                cmd.Parameters.AddWithValue("@font_color", font_color);
                cmd.Parameters.AddWithValue("@unit_name", unit_name);
                cmd.Parameters.AddWithValue("@flow_width", flow_width);
                cmd.Parameters.AddWithValue("@node_height", node_height);
                cmd.ExecuteNonQuery();
                cn.close_connection();
            }
        }
        public void showData(GridView gv)
        {
            string query = "select l.user_name, u.email, dm.project_name, dm.remarks, DATE_FORMAT(dm.entry_time,'%d %b %Y %T') as entry_time, DATE_FORMAT(dm.update_time,'%d %b %Y %T') as update_time, dm.job_id ";
            query += "from login l inner join user_info u on l.user_name = u.user_name inner ";
            query += "join data_master dm on l.user_name = dm.user_name and dm.user_name= '" + user_name + "'";

            if (cn.open_connection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, cn.connection);
                MySqlDataAdapter adapter = new MySqlDataAdapter(query, cn.connection);

                DataSet ds = new DataSet();
                adapter.Fill(ds);
                gv.DataSource = ds;
                gv.DataBind();

                cn.close_connection();
            }
        }

        public void showFeedbackGrid(GridView gv)
        {
            string query = "select id, user_name, feedback, case c_status when 1 then 'Done'  when 2 then 'On testing' else 'On Processing' end as ST from user_feedback; ";

            if (cn.open_connection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, cn.connection);
                MySqlDataAdapter adapter = new MySqlDataAdapter(query, cn.connection);

                DataSet ds = new DataSet();
                adapter.Fill(ds);
                gv.DataSource = ds;
                gv.DataBind();

                cn.close_connection();
            }

        }


        public void SaveFeedback(string user_name, string feedback)
        {
            string query1 = "INSERT into user_feedback (user_name, feedback) ";
            query1 += "VALUES (@user_name, @feedback);";

            //open connection
            if (cn.open_connection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd1 = new MySqlCommand(query1, cn.connection);
                cmd1.Parameters.AddWithValue("@user_name", user_name);
                cmd1.Parameters.AddWithValue("@feedback", feedback);
                cmd1.ExecuteNonQuery();
                cn.close_connection();
            }

        }

        public void UpdateFeedback(string id, string un, string fd)
        {
            string query1 = "update user_feedback set feedback=@feedback where user_name= '" + un + "' and id = '" + id + "'";

            if (cn.open_connection() == true)
            {
                MySqlCommand cmd1 = new MySqlCommand(query1, cn.connection);
                cmd1.Parameters.AddWithValue("@feedback", fd);
                cmd1.ExecuteNonQuery();
                cn.close_connection();
            }


        }

        public void DeleteFeedback(string id, string un)
        {
            string query1 = "DELETE from user_feedback where user_name= '" + un + "' and id = '" + id + "'";

            //open connection
            if (cn.open_connection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd1 = new MySqlCommand(query1, cn.connection);
                cmd1.ExecuteNonQuery();
                cn.close_connection();
            }
        }




        public ArrayList getData(string job_id)
        {
            //string data = "";

            //"input_flow_data","txtRemarks","txtproject_name","input_node_data","background_color","enable_drag","curvature","canvas_width","canvas_height","default_flow_opacity"
            //"default_node_opacity","node_border"),"show_labels","font_face","font_size","font_color");

            ArrayList controllers_value = new ArrayList();

            string query = "select distinct dm.job_id, dm.project_name, dm.remarks, rd.node_data, rd.default_node_color, rd.flow_data, rd.default_flow_color, ";
            query += "md.background_color, md.border, md.curviness, md.diagram_height, md.diagram_width, md.drag_option, md.flow_opacity, md.node_opacity, ";
            query += "md.font_color, md.font_face, md.font_size, md.level_visibility, md.unit_name, md.flow_width, md.node_height from raw_data rd, data_master dm, meta_data md ";
            query += "where rd.job_id = dm.job_id and dm.job_id = md.job_id and dm.job_id = '" + job_id + "'";

            if (cn.open_connection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, cn.connection);
                MySqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {

                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        controllers_value.Add(Convert.ToString(reader.GetValue(i)));
                    }
                }

                reader.Close();
                cn.close_connection();
            }
            return controllers_value;

        }

        public void UpdateData(string job_id)
        {
            UpdateMaster(job_id);
            UpdateRawData(job_id);
            UpdateMetaData(job_id);

        }


        public void UpdateMaster(string job_id)
        {
            string query = "update data_master set project_name=@project_name, update_time=@update_time, remarks=@remarks where job_id= '" + job_id + "'";

            if (cn.open_connection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, cn.connection);
                cmd.Parameters.AddWithValue("@project_name", project_name);
                cmd.Parameters.AddWithValue("@remarks", remarks);
                cmd.Parameters.AddWithValue("@update_time", time);
                cmd.ExecuteNonQuery();
                cn.close_connection();
            }
        }

        public void UpdateRawData(string job_id)
        {
            string query = "update raw_data set node_data=@node_data, default_node_color=@default_node_color, flow_data=@flow_data, default_flow_color=@default_flow_color where job_id= '" + job_id + "'";

            if (cn.open_connection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, cn.connection);
                cmd.Parameters.AddWithValue("@node_data", node_data);
                cmd.Parameters.AddWithValue("@default_node_color", default_node_color);
                cmd.Parameters.AddWithValue("@flow_data", flow_data);
                cmd.Parameters.AddWithValue("@default_flow_color", default_flow_color);
                cmd.ExecuteNonQuery();
                cn.close_connection();
            }
        }
        public void UpdateMetaData(string job_id)
        {
            string query = "update meta_data set background_color=@background_color, drag_option=@drag_option, curviness=@curviness, ";
            query += "diagram_width=@diagram_width, diagram_height=@diagram_height, flow_opacity=@flow_opacity, ";
            query += "node_opacity=@node_opacity, border=@border, level_visibility=@level_visibility, ";
            query += "level_visibility=@level_visibility, font_face=@font_face, font_size=@font_size, ";
            query += "font_color=@font_color, unit_name=@unit_name,flow_width=@flow_width,node_height=@node_height ";
            query += "where job_id = '" + job_id + "'";

            if (cn.open_connection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, cn.connection);
                cmd.Parameters.AddWithValue("@background_color", background_color);
                cmd.Parameters.AddWithValue("@drag_option", drag_option);
                cmd.Parameters.AddWithValue("@curviness", curviness);
                cmd.Parameters.AddWithValue("@diagram_width", diagram_width);
                cmd.Parameters.AddWithValue("@diagram_height", diagram_height);
                cmd.Parameters.AddWithValue("@flow_opacity", flow_opacity);
                cmd.Parameters.AddWithValue("@node_opacity", node_opacity);
                cmd.Parameters.AddWithValue("@border", border);
                cmd.Parameters.AddWithValue("@level_visibility", level_visibility);
                cmd.Parameters.AddWithValue("@font_face", font_face);
                cmd.Parameters.AddWithValue("@font_size", font_size);
                cmd.Parameters.AddWithValue("@font_color", font_color);
                cmd.Parameters.AddWithValue("@unit_name", unit_name);
                cmd.Parameters.AddWithValue("@flow_width", flow_width);
                cmd.Parameters.AddWithValue("@node_height", node_height);
                cmd.ExecuteNonQuery();
                cn.close_connection();
            }
        }
        public void DeleteData(string job_id)
        {

            string query = "DELETE data_master, raw_data, meta_data ";
            query += "FROM   data_master ";
            query += "JOIN   raw_data ON (raw_data.job_id = data_master.job_id) ";
            query += "JOIN   meta_data ON(meta_data.job_id = raw_data.job_id) ";
            query += "WHERE  data_master.job_id = '" + job_id + "'";


            if (cn.open_connection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, cn.connection);
                cmd.ExecuteNonQuery();
                cn.close_connection();
            }
        }

        public void setNodeAndFlowValues(HtmlTextArea nodeData, HtmlTextArea flowData, string year, string country)
        {
            dbConnect cn = new dbConnect();
            string query1 = "SELECT p.process_name, p.color, p.angle, p.width, p.height, p.xPos, p.yPos FROM process_list p ";

            Random rnd = new Random();

            string color_code = "";

            string all_node_value = "";
            if (cn.open_connection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query1, cn.connection);
                MySqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    string single_node_value = "";
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        if (i == 0)
                        {
                            single_node_value += "[" + Convert.ToString(reader.GetValue(i)) + "]" + " ";
                        }
                        else
                            single_node_value += Convert.ToString(reader.GetValue(i)) + " ";
                    }
                    all_node_value += single_node_value + "\r\n";
                }

                reader.Close();
                cn.close_connection();
            }

            nodeData.InnerText = all_node_value;

            string filter = "";


            string mselectedCountryISO = "";
            string query2 = "select c.ISO_code as ISO_code from countries c where c.country_name = '" + country + "'";
            if (cn.open_connection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query2, cn.connection);
                MySqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    mselectedCountryISO = Convert.ToString(reader["ISO_code"]);
                }

                reader.Close();
                cn.close_connection();
            }


            if (year == "" && mselectedCountryISO == "")
            {
                filter = " ";
            }
            else if (year == "" && mselectedCountryISO != "")
            {
                filter = "where (f.region_source in (" + mselectedCountryISO + ") or f.region_target in (" + mselectedCountryISO + "))";
            }
            else if (year != "" && mselectedCountryISO == "")
            {
                filter = "where f.year in(" + year + ") ";
            }
            else
            {
                filter = "where f.year in(" + year + ") and (f.region_source in (" + mselectedCountryISO + ") or f.region_target in (" + mselectedCountryISO + ")) ";
            }

            //http://localhost:49645/frmCircularSankey.aspx?D=1&year=2003&country=Germany
            string query3 = "SELECT distinct  f.process_id_source PIDS, (select p.process_name from process_list p where p.process_id = PIDS) as PNS,   ";
            query3 += "f.process_id_target PIDT, (select p.process_name from process_list p where p.process_id = PIDT) as PNT, f.region_source CICS, c.country_name CS, f.region_target CICT, ";
            query3 += " c.country_name CT, f.year T, f.value V, f.unit UID FROM flows f inner join countries c on(f.region_source = c.ISO_code or f.region_target = c.ISO_code) ";
            query3 += "  " + filter + " ";

            string all_flow_value = "";
            if (cn.open_connection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query3, cn.connection);
                MySqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    string CultureName = Thread.CurrentThread.CurrentCulture.Name;
                    CultureInfo ci = new CultureInfo(CultureName);
                    if (ci.NumberFormat.NumberDecimalSeparator != ".")
                    {
                        // Forcing use of decimal separator for numerical values
                        ci.NumberFormat.NumberDecimalSeparator = ".";
                        Thread.CurrentThread.CurrentCulture = ci;
                    }


                    color_code = "[(" + rnd.Next(0, 255) + "," + rnd.Next(0, 255) + "," + rnd.Next(0, 255) + ")]";
                    all_flow_value += "[" + (string)reader["PNS"] + "]" + " " + "[" + (Double)reader["V"] + "]" + " " + "[(39,185,0)]" + " [ab] " + "[" + (string)reader["PNT"] + "]" + "\r\n";
                }

                reader.Close();
                cn.close_connection();
            }

            flowData.InnerText = all_flow_value;

        }
    }
}