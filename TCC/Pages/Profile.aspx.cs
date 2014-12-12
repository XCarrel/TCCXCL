using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;


namespace TCC
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT UserId, Firstname, LastName, UserName, address1, address2, NPA, city, phonenumber, email " +
                                  "FROM (tccmembership INNER JOIN Users ON fkuser = UserId) INNER JOIN NPA ON NPA = NPAVal " +
                                  "WHERE Username = '" + getUsername() + "'; ";

                SqlConnection cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
                cmd.Connection = cnx;
                cnx.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read()) // found details
                {
                    try { txtFname.Text = rdr.GetString(1); }
                    catch { }
                    try { txtLname.Text = rdr.GetString(2); }
                    catch { }
                    try { txtAdr1.Text = rdr.GetString(4); }
                    catch { }
                    try { txtAdr2.Text = rdr.GetString(5); }
                    catch { }
                    try { txtNPA.Text = rdr.GetSqlInt32(6).ToString(); }
                    catch { }
                    try { lblCity.Text = rdr.GetString(7); }
                    catch { }
                    try { txtTel.Text = rdr.GetString(8); }
                    catch { }
                    try { txtEmail.Text = rdr.GetString(9); }
                    catch { }
                }
                rdr.Close();
            }
        }

        protected string getUsername()
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

        protected void TextBoxChanged (object sender, EventArgs e)
        {
            TextBox tb = (TextBox)sender;
            SqlConnection cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
            cnx.Open();
            SqlCommand cmd = new SqlCommand();
            switch (tb.ID)
            {
                case "txtFname" :
                    cmd.CommandText = "UPDATE Users SET Firstname = '" + tb.Text + "' WHERE UserName = '" + getUsername() + "'; ";
                    break;
                case "txtLname" :
                    cmd.CommandText = "UPDATE Users SET Lastname = '" + tb.Text + "' WHERE UserName = '" + getUsername() + "'; ";
                    break;
                case "txtAdr1":
                    cmd.CommandText = "UPDATE tccmembership SET address1 = '" + tb.Text + "' FROM Users INNER Join tccmembership ON fkUser = Userid WHERE UserName = '" + getUsername() + "'; ";
                    break;
                case "txtAdr2":
                    cmd.CommandText = "UPDATE tccmembership SET address2 = '" + tb.Text + "' FROM Users INNER Join tccmembership ON fkUser = Userid WHERE UserName = '" + getUsername() + "'; ";
                    break;
                case "txtNPA":
                    cmd.CommandText = "UPDATE tccmembership SET NPA = " + tb.Text + " FROM Users INNER Join tccmembership ON fkUser = Userid WHERE UserName = '" + getUsername() + "'; ";
                    // There's more to do: update the city name
                    SqlCommand cmd2 = new SqlCommand();
                    cmd2.CommandText = "Select city From NPA Where NPAVal = " + tb.Text;
                    cmd2.Connection = cnx;
                    SqlDataReader rdr = cmd2.ExecuteReader();
                    if (rdr.Read()) lblCity.Text = rdr.GetString(0);
                    rdr.Close();
                    break;
                case "txtTel":
                    cmd.CommandText = "UPDATE tccmembership SET phonenumber = '" + tb.Text + "' FROM Users INNER Join tccmembership ON fkUser = Userid WHERE UserName = '" + getUsername() + "'; ";
                    break;
                case "txtEmail":
                    cmd.CommandText = "UPDATE tccmembership SET email = '" + tb.Text + "' FROM Users INNER Join tccmembership ON fkUser = Userid WHERE UserName = '" + getUsername() + "'; ";
                    break;
            }
            cmd.Connection = cnx;
            cmd.ExecuteNonQuery();
        }

    }
}