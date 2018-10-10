using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace IEF_Visualization.cls
{
    public class clsUserManager
    {
        dbConnect cn = new dbConnect();

        string time = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt");
        public string firstName;
        public string lastName;
        public string email;
        public string userName;
        public string password;
        string timed = DateTime.Now.Year + "." + DateTime.Now.Month + "." + DateTime.Now.Day +
               " " + DateTime.Now.Hour + (":") + DateTime.Now.Minute + (":") + DateTime.Now.Second;
        public string institution;
        internal string userType;

        public void SaveData()
        {

            string query1 = "INSERT into login (user_name, user_password, user_type) ";
            query1 += "VALUES (@user_name, @user_password,  @user_type);";

            //open connection
            if (cn.open_connection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd1 = new MySqlCommand(query1, cn.connection);
                cmd1.Parameters.AddWithValue("@user_name", userName);
                cmd1.Parameters.AddWithValue("@user_password", password);
                cmd1.Parameters.AddWithValue("@user_type", userType);
                cmd1.ExecuteNonQuery();
                cn.close_connection();
            }


            string query2 = "INSERT into user_info (user_name, first_name, last_name, institution_name, email) ";
            query2 += "VALUES (@user_name, @first_name, @last_name, @institution_name, @email);";

            //open connection
            if (cn.open_connection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd2 = new MySqlCommand(query2, cn.connection);
                cmd2.Parameters.AddWithValue("@user_name", userName);
                cmd2.Parameters.AddWithValue("@first_name", firstName);
                cmd2.Parameters.AddWithValue("@last_name", lastName);
                cmd2.Parameters.AddWithValue("@institution_name", institution);
                cmd2.Parameters.AddWithValue("@email", email);
                cmd2.ExecuteNonQuery();
                cn.close_connection();
            }

        }

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

        public void CopyData(string userName, string new_job_id, string old_job_id)
        {
            string query1 = "insert into sankey.data_master (user_name, job_id, project_name, remarks, entry_time, update_time) ";
            query1 += "select '"+ userName + "', '"+ new_job_id + "', project_name, remarks, '"+ timed + "', '"+ timed + "' from sankey.data_master WHERE job_id = '"+ old_job_id + "' ";


            string query2 = "insert into sankey.meta_data (job_id, background_color, drag_option, curviness, diagram_width, diagram_height, flow_opacity, node_opacity, border,level_visibility, font_face, font_size, font_color,unit_name) ";
            query2 += "select '" + new_job_id + "', background_color, drag_option, curviness, diagram_width, diagram_height, flow_opacity, node_opacity, border,level_visibility, font_face, font_size, font_color,unit_name from sankey.meta_data WHERE job_id = '" + old_job_id + "'";

            string query3 = "insert into sankey.raw_data (job_id, node_data, default_node_color, flow_data, default_flow_color) ";
            query3 += "select '" + new_job_id + "', node_data, default_node_color, flow_data, default_flow_color from sankey.raw_data WHERE job_id = '" + old_job_id + "'";
            //open connection
            if (cn.open_connection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd1 = new MySqlCommand(query1, cn.connection);
                MySqlCommand cmd2 = new MySqlCommand(query2, cn.connection);
                MySqlCommand cmd3 = new MySqlCommand(query3, cn.connection);


                cmd1.ExecuteNonQuery();
                cmd2.ExecuteNonQuery();
                cmd3.ExecuteNonQuery();
                cn.close_connection();
            }
        }

        public bool checkLogin(string userName)
        {
            bool status = false;
            string query = "SELECT * FROM login where user_name= '" + userName + "'";

            if (cn.open_connection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, cn.connection);
                MySqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    status = true;
                }

                reader.Close();
                cn.close_connection();
            }

            return status;
        }
        public void showUserList(GridView gv)
        {

            string query = "select l.id, l.user_name, l.user_password, l.user_type, u.first_name, u.last_name, u.email, u.institution_name from sankey.login l inner join sankey.user_info u on l.user_name=u.user_name;";

            //open connection
            if (cn.open_connection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd = new MySqlCommand(query, cn.connection);
                MySqlDataAdapter adapter = new MySqlDataAdapter(query, cn.connection);


                DataSet ds = new DataSet();
                adapter.Fill(ds);
                gv.DataSource = ds;
                gv.DataBind();

                //while (dataReader.Read())
                //{
                //    string s = dataReader["id"] + "";
                //    string s1 = dataReader["user_id"] + "";
                //    string s2 = dataReader["user_password"] + "";


                //}

                //close connection
                cn.close_connection();
            }

        }

        public void UpdateUser(string id, string un, string pa, string ut, string fn, string ln, string ins, string em)
        {
            string query1 = "update login set user_password=@user_password, user_type=@user_type where user_name= '" + un + "'";
       
            if (cn.open_connection() == true)
            {
                MySqlCommand cmd1 = new MySqlCommand(query1, cn.connection);
                //cmd1.Parameters.AddWithValue("@user_name", un);
                cmd1.Parameters.AddWithValue("@user_password", pa);
                cmd1.Parameters.AddWithValue("@user_type", ut);
                cmd1.ExecuteNonQuery();
                cn.close_connection();
            }

            string query2 = "update user_info set first_name=@first_name, last_name=@last_name, institution_name=@institution_name, email=@email where user_name= '" + un + "'";
            
            if (cn.open_connection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd2 = new MySqlCommand(query2, cn.connection);

                cmd2.Parameters.AddWithValue("@first_name", fn);
                cmd2.Parameters.AddWithValue("@last_name", ln);
                cmd2.Parameters.AddWithValue("@institution_name", ins);
                cmd2.Parameters.AddWithValue("@email", em);
                cmd2.ExecuteNonQuery();
                cn.close_connection();
            }
            

        }

        public void DeleteUser(string un)
        {

            string query1 = "DELETE from login where user_name= '" + un + "'";

            //open connection
            if (cn.open_connection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd1 = new MySqlCommand(query1, cn.connection);
                cmd1.ExecuteNonQuery();
                cn.close_connection();
            }

            string query2 = "DELETE from user_info where user_name= '" + un + "'";

            if (cn.open_connection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd2 = new MySqlCommand(query2, cn.connection);
                cmd2.ExecuteNonQuery();
                cn.close_connection();
            }
        }
    }
}