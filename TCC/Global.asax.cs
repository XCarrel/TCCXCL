using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using TCC;

namespace TCC
{
    public class Global : HttpApplication
    {
        public const string appversion = "0.1";

        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            AuthConfig.RegisterOpenAuth();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }

        void Application_End(object sender, EventArgs e)
        {
            //  Code that runs on application shutdown

        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs

        }

        static public string getUsername()
        {
            try
            {
                return Membership.GetUser().UserName;
            }
            catch
            {
                return "";
            }
        }

        static public string getCurrentUserId()
        {
            SqlConnection cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
            cnx.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = string.Format("SELECT UserId FROM Users WHERE UserName = '{0}';", getUsername());
            cmd.Connection = cnx;
            SqlDataReader rdr = cmd.ExecuteReader();
            string res = null;
            if (rdr.Read()) res = rdr.GetSqlGuid(0).ToString();
            rdr.Close();
            return res;
        }

        // Returns true if the user logged in is leader of a team. If he is, the group ID is returned in clubGroup
        static public bool currentUserIsTeamLeader(out int clubGroup)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "SELECT fkGroup FROM ((((tccmembership INNER JOIN Users ON fkuser = UserId) INNER JOIN belongs ON fkMember = UserId) INNER JOIN [role] ON fkRole = idRole) INNER JOIN clubGroup ON fkGroup = idClubGroup) " +
                              "WHERE isLeading=1 and Username = '" + getUsername() + "'; ";
            SqlConnection cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
            cmd.Connection = cnx;
            cnx.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            try
            {
                rdr.Read();
                clubGroup = rdr.GetInt32(0);
            }
            catch (Exception e)
            {
                clubGroup = -1;
            }
            return (clubGroup > 0);
        }

        // Returns true if the user logged in is admin
        static public bool currentUserIsAdmin()
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "SELECT isSiteAdmin FROM (tccmembership INNER JOIN Users ON fkuser = UserId) " +
                              "WHERE Username = '" + getUsername() + "'; ";
            SqlConnection cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
            cmd.Connection = cnx;
            cnx.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.Read()) return rdr.GetBoolean(0);
            return false;
        }

    }
}
