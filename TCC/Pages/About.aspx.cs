using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.Security;



namespace TCC
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ContentPlaceHolder p = Master.FindControl("MainContent") as ContentPlaceHolder;

            Button dynab = new Button();
            dynab.Text = "dyn";
            dynab.Click += dynab_Click;
            p.Controls.Add(dynab);
        }

        void dynab_Click(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }

        protected void dpdCourt_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblRes.Text = "Id court = " + dpdCourt.SelectedValue;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlConnection cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
            cnx.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "EXEC MemberBooking '" + Membership.GetUser().ToString() + "', 'toto', "+dpdCourt.SelectedValue + ", '2014-12-19 16:00'";
            cmd.Connection = cnx;
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                System.Diagnostics.Debug.Write("SQL Exception: " + ex.Message);
            }
        }

    }
}