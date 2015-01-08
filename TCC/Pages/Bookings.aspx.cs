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
using System.Globalization;
using System.IO;

namespace TCC
{
    public partial class Bookings : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            int gleader;
            if (!Global.currentUserIsTeamLeader(out gleader)) Server.Transfer("\\Default.aspx");
            ContentPlaceHolder cnt = this.Master.FindControl("FeaturedContent") as ContentPlaceHolder;

            // Get group name
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "SELECT groupName FROM clubGroup WHERE idClubGroup = " + gleader.ToString() + "; ";
            SqlConnection cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
            cmd.Connection = cnx;
            cnx.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (!rdr.Read())
                lblTitre.Text = "Erreur!";
            else
                lblTitre.Text = "Réservations pour: " + rdr.GetString(0);
            rdr.Close();
            // Check if there are bookings
            cmd.CommandText = "SELECT idBooking, moment, courtName FROM ((Users INNER JOIN booking ON fkMadeBy = UserId) INNER JOIN court ON fkCourt = idCourt)  " +
                                "WHERE Username = '" + Global.getUsername() + "'; ";
            rdr = cmd.ExecuteReader();
            if (!rdr.Read())
            {
                Label lbl = new Label();
                lbl.Text = "Aucune";
                lbl.Font.Size = FontUnit.XLarge;
                cnt.Controls.Add(lbl);
            }
            else // There are bookings to display in a table
            {
                Table tbl = new Table();
                // Build header
                TableHeaderRow tbhr = new TableHeaderRow();
                string[] htext = { "Jour", "Date", "Court", "Heure" };
                foreach (string hdr in htext)
                {
                    TableHeaderCell tbhc = new TableHeaderCell();
                    tbhc.Text = hdr;
                    tbhc.BorderWidth = 3;
                    tbhc.BorderStyle = BorderStyle.Solid;
                    tbhc.Style.Add("padding-left", "3px");
                    tbhc.Style.Add("padding-right", "3px");
                    tbhr.Cells.Add(tbhc);
                }
                tbl.Rows.Add(tbhr);

                // Build content
                do
                {
                    TableRow tbr = new TableRow();
                    DateTime moment = rdr.GetDateTime(1);
                    string[] vals = new string[4];
                    vals[0] = DateTimeFormatInfo.CurrentInfo.GetDayName(moment.DayOfWeek);
                    vals[1] = moment.ToString("dd MMMM yyyy");
                    vals[2] = rdr.GetString(2);
                    vals[3] = moment.Hour.ToString() + "h";
                    foreach (string cv in vals)
                    {
                        TableCell tbc = new TableCell();
                        tbc.Text = cv;
                        tbc.BorderWidth = 1;
                        tbc.BorderStyle = BorderStyle.Solid;
                        tbc.Style.Add("padding-left", "3px");
                        tbc.Style.Add("padding-right", "3px");
                        tbr.Cells.Add(tbc);
                    }
                    tbl.Rows.Add(tbr);
                } while (rdr.Read());
                cnt.Controls.Add(tbl); // Insert the table between the title and de file upload
            }
        }

    }
}