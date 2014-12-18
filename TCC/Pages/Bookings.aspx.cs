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
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            int gleader;
            if (!Global.currentUserIsTeamLeader(out gleader)) Server.Transfer("/Default.aspx");
            
            // We create the table in the LoadComplete event so that the file upload event has been processed before
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

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void cmdImport_Click(object sender, EventArgs e)
        {
            ContentPlaceHolder cnt = this.Master.FindControl("FeaturedContent") as ContentPlaceHolder;
            int nbres = 0;
            if (fup.HasFile)
            {
                try
                {
                    string filename = Path.GetFileName(fup.FileName);
                    string localname = Server.MapPath("~/Upload/") + filename;
                    string errorlist = "";
                    fup.SaveAs(localname);
                    StreamReader res = new StreamReader(localname,System.Text.Encoding.UTF8);
                    while (!res.EndOfStream)
                    {
                        string line = res.ReadLine();
                        string[] values = line.Split('\t');
                        string[] dateparts = values[0].Split('.');
                        // Get courtid
                        int courtid;
                        // Get group name
                        SqlCommand cmd = new SqlCommand();
                        cmd.CommandText = "SELECT idcourt FROM court WHERE courtName = '" + values[2] + "'; ";
                        SqlConnection cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
                        cmd.Connection = cnx;
                        cnx.Open();
                        SqlDataReader rdr = cmd.ExecuteReader();
                        if (!rdr.Read())
                            courtid = -1;
                        else
                            courtid = rdr.GetInt32(0);
                        rdr.Close();

                        // Insert
                        cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
                        cnx.Open();
                        cmd = new SqlCommand();
                        cmd.CommandText = string.Format("INSERT INTO booking (moment, fkMadeBy, fkPartner, guest, fkCourt) VALUES ('{0}-{1}-{2} {3}:00','{4}','{5}',null,{6});", dateparts[2], dateparts[1], dateparts[0], values[1], Global.getCurrentUserId(), Global.getCurrentUserId(), courtid);
                        cmd.Connection = cnx;
                        try
                        {
                            cmd.ExecuteNonQuery();
                            nbres++;
                        }
                        catch (Exception ex)
                        {
                            System.Diagnostics.Debug.Write("Error inserting booking (" + cmd.CommandText + "): " + ex.Message);
                            errorlist += ("<br>" + line);
                        }
                    }
                    res.Close();
                    File.Delete(localname);
                    Label errors = new Label();
                    errors.Text = nbres.ToString() + " réservation(s) importé(s).";
                    if (errorlist != "")
                        errors.Text += "<br>Les réservations suivantes n'ont pas pu être importées:<br>" + errorlist;
                    cnt.Controls.Add(errors);
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Upload status: The file could not be uploaded. The following error occured: " + ex.Message);
                }
            }
        }
    }
}