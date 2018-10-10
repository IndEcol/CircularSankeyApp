using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace IEF_Visualization.cls
{
    public class clsCommon
    {
        dbConnect cn = new dbConnect();
       

        public bool checkLogin(string userName, string password)
        {
            bool status = false;
            string query = "SELECT * FROM login where user_name= '" + userName + "' and user_password = '" + password + "'";

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

        public string user_type(string userName, string password)
        {
            string user_type = "";
            string query = "SELECT * FROM login where user_name= '" + userName + "' and user_password = '" + password + "'";

            if (cn.open_connection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, cn.connection);
                MySqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    user_type = reader["user_type"].ToString();
                }

                reader.Close();
                cn.close_connection();
            }

            return user_type;
        }

        public string GetUserFullName(string userName, string password)
        {
            string full_user_name = "";
            string query = "SELECT u.first_name as fn, u.last_name as ln FROM login l, user_info u where l.user_name=u.user_name and l.user_name= '" + userName + "' and l.user_password = '" + password + "'";

            if (cn.open_connection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, cn.connection);
                MySqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    full_user_name = reader["fn"].ToString() + " " + reader["ln"].ToString();
                }

                reader.Close();
                cn.close_connection();
            }

            return full_user_name;
        }
        

        ////http://www.codeproject.com/Articles/823854/How-to-connect-SQL-Database-to-your-Csharp-program
    }
}