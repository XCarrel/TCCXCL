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


namespace TCC.Pages
{
    public partial class Stats : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Global.currentUserIsAdmin()) Server.Transfer("Niet.aspx");
        }

        protected void cmdInvitations_Click(object sender, EventArgs e)
        {
            // We create the table in the LoadComplete event so that the file upload event has been processed before
            ContentPlaceHolder cnt = this.Master.FindControl("MainContent") as ContentPlaceHolder;

            // Show member's name
            Label lbl = new Label();
            lbl.Text = "Réservations faites par " + dpdMembers.SelectedItem;
            lbl.Font.Size = FontUnit.XLarge;
            cnt.Controls.Add(lbl);
            cnt.Controls.Add(new LiteralControl("<br>"));
            cnt.Controls.Add(new LiteralControl("<br>"));

            // Get bookings
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = string.Format("select moment, guest from booking where fkMadeBy = '{0}' and guest is not null",dpdMembers.SelectedValue.ToString());
            SqlConnection cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
            cmd.Connection = cnx;
            cnx.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (!rdr.Read())
            {
                lbl = new Label();
                lbl.Text = "Aucune";
                lbl.Font.Size = FontUnit.XLarge;
                cnt.Controls.Add(lbl);
            }
            else // There are bookings to display in a table
            {
                Table tbl = new Table();
                // Build header
                TableHeaderRow tbhr = new TableHeaderRow();
                string[] htext = { "Date", "Invité" };
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
                    DateTime moment = rdr.GetDateTime(0);
                    string[] vals = new string[2];
                    vals[0] = moment.ToString("dd MMMM yyyy");
                    vals[1] = rdr.GetString(1);
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
                cnt.Controls.Add(tbl); 
            }

        }

        protected void cmdVisitors_Click(object sender, EventArgs e)
        {
            // We create the table in the LoadComplete event so that the file upload event has been processed before
            ContentPlaceHolder cnt = this.Master.FindControl("MainContent") as ContentPlaceHolder;

            // Show member's name
            Label lbl = new Label();
            lbl.Text = "Ces six derniers mois, il y a eu ";

            // Get visitors
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select count(*) from booking where guest is not null and fkMadeBy is null and fkPartner is null and moment > dateadd(month, -6, getdate())";
            SqlConnection cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
            cmd.Connection = cnx;
            cnx.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            rdr.Read();
            int nb = rdr.GetInt32(0);
            lbl.Text += nb.ToString();
            lbl.Text += " visiteurs, ";
            rdr.Close();

            // Get unpaid visits
            cmd.CommandText = "select count(*) from booking where guest is not null and fkMadeBy is null and fkPartner is null and moment > dateadd(month, -6, getdate()) and paid = 0";
            cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
            cmd.Connection = cnx;
            cnx.Open();
            rdr = cmd.ExecuteReader();
            rdr.Read();
            nb = rdr.GetInt32(0);
            lbl.Text += nb.ToString();
            lbl.Text += " n'ont pas payé leur facture";

            lbl.Font.Size = FontUnit.XLarge;
            cnt.Controls.Add(lbl);
        }

    }
}