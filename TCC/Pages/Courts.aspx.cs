using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.Security;

namespace TCC
{
    public partial class Courts : System.Web.UI.Page
    {
        private int ColDay(string sday) // Returns the column number (1-7) for the day passed as string in french
        {
            int ncol = -1;
            switch (sday.ToUpper())
            {
                case "LUNDI": ncol = 1; break;
                case "MARDI": ncol = 2; break;
                case "MERCREDI": ncol = 3; break;
                case "JEUDI": ncol = 4; break;
                case "VENDREDI": ncol = 5; break;
                case "SAMEDI": ncol = 6; break;
                case "DIMANCHE": ncol = 7; break;
            }
            return ncol;
        }

        private int RowHour(string shour) // Returns the row number (1-14) for the hour passed as an int in a string
        {
            int nrow = -1;
            if (int.TryParse(shour, out nrow))
            {
                nrow -= 7; // row number 1 is 8:00 AM
                if ((nrow <= 0) || (nrow > Court1.Rows.Count - 1)) nrow = -1;
            }
            return nrow;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Add buttons in the table cells
            for (int r = 1; r < Court1.Rows.Count; r++) // start at 1 to avoid header row
                for (int c=1; c<Court1.Rows[r].Cells.Count; c++) // start at 1 to avoid header column
                {
                    Button btn = new Button();
                    btn.ID = string.Format("c{0}{1}", r.ToString("D2"), c);
                    btn.Text = "";
                    btn.Width = 80;
                    btn.Height = 20;
                    btn.BackColor = System.Drawing.Color.Transparent;
                    btn.BorderStyle = BorderStyle.None;
                    btn.Click += btn_Click;
                    Court1.Rows[r].Cells[c].Controls.Add(btn);
                }

            // Court occupation: call to stored function
            SqlConnection cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
            cnx.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select dbo.Occupation(1,getdate(),DATEADD(MONTH,1,GETDATE()));";
            cmd.Connection = cnx;
            SqlDataReader rdr = cmd.ExecuteReader();
            lblMessage.Visible = true;
            try
            {
                if (rdr.Read()) System.Diagnostics.Debug.WriteLine("Retour de la fonction Occupation: " + rdr.GetDouble(0).ToString());
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Exception: " + ex.Message);
            }
            rdr.Close();

            // Planning content will be loaded later, when the DataBound event fires
        }

        private void readFromFile()
        {
            // Read data from file
            string path = Server.MapPath("../App_Data/res.txt");
            StreamReader res = new StreamReader(path);

            while (!res.EndOfStream)
            {
                string line = res.ReadLine();
                string[] values = line.Split('\t');
                int ncol = ColDay(values[0]);
                int nrow = RowHour(values[1]);

                if ((ncol > 0) && (nrow > 0))
                {
                    Button btn = (Button)Court1.FindControl(string.Format("c{0}{1}", nrow.ToString("D2"), ncol));
                    btn.Text = values[2];
                }
            }
        }
        void btn_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            if (string.IsNullOrEmpty(btn.Text))
                if (string.IsNullOrEmpty(txtPlayer.Text))
                {
                    lblMessage.Text = "Veuillez introduire un nom de joueur";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    lblMessage.Text = "Ajouté la réservation pour " + txtPlayer.Text;
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    btn.Text = txtPlayer.Text;
                    txtPlayer.Text = "";
                }
            else
            {
                lblMessage.Text = "Supprimé la réservation de " + btn.Text;
                lblMessage.ForeColor = System.Drawing.Color.Green;
                btn.Text = "";
            }
            lblMessage.Visible = true;
        }

        private void LoadPlanning()
        {
            // Clean current values
            for (int r = 1; r < Court1.Rows.Count; r++) // start at 1 to avoid header row
                for (int c = 1; c < Court1.Rows[r].Cells.Count; c++) // start at 1 to avoid header column
                {
                    TableCell cell = (TableCell)Court1.FindControl(string.Format("cell{0}{1}", r.ToString("D2"), c.ToString("D2")));
                    cell.BackColor = System.Drawing.Color.Transparent;
                    Button btn = (Button)Court1.FindControl(string.Format("c{0}{1}", r.ToString("D2"), c));
                    btn.Text = "";
                }

            // Load new values
            SqlConnection cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
            cnx.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "SELECT courtName, moment, MadeBy.LastName, Partner.LastName, guest " +
                              "FROM ((booking INNER JOIN court ON fkCourt = idcourt) LEFT JOIN Users AS MadeBy ON fkMadeBy = MadeBy.UserId) LEFT JOIN Users AS Partner ON fkPartner = Partner.UserId " +
                              "WHERE idcourt = " + dpdCourtSelect.SelectedValue + " AND moment > GETDATE() and moment < DATEADD(WEEK,1,GETDATE());";
            cmd.Connection = cnx;
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read()) // found details
            {
                try
                {
                    int row = 0, col = 0; // cell to fill
                    string madeBy = null;
                    string partner = null;
                    string guest = null;

                    // Get data from reader
                    DateTime moment = rdr.GetDateTime(1);
                    if (!rdr.IsDBNull(2)) madeBy = rdr.GetString(2);
                    if (!rdr.IsDBNull(3)) partner = rdr.GetString(3);
                    if (!rdr.IsDBNull(4)) guest = rdr.GetString(4);

                    // Compute cell coordinates
                    switch (moment.DayOfWeek)
                    {
                        case DayOfWeek.Monday: col = 1; break;
                        case DayOfWeek.Tuesday: col = 2; break;
                        case DayOfWeek.Wednesday: col = 3; break;
                        case DayOfWeek.Thursday: col = 4; break;
                        case DayOfWeek.Friday: col = 5; break;
                        case DayOfWeek.Saturday: col = 6; break;
                        case DayOfWeek.Sunday: col = 7; break;
                    }
                    row = moment.Hour - 7; // row 1 is for 8:00AM

                    // Compute cell attributes
                    string name = null;
                    System.Drawing.Color bcolor = System.Drawing.Color.Transparent;

                    if (madeBy != null)
                    {
                        name = madeBy;
                        if (partner != null)
                            bcolor = System.Drawing.Color.DarkOliveGreen;
                        else
                            bcolor = System.Drawing.Color.ForestGreen;
                    }
                    else
                    {
                        name = guest;
                        bcolor = System.Drawing.Color.LemonChiffon;
                    }

                    // Set cell attributes
                    TableCell cell = (TableCell)Court1.FindControl(string.Format("cell{0}{1}", row.ToString("D2"), col.ToString("D2")));
                    cell.BackColor = bcolor;
                    Button btn = (Button)Court1.FindControl(string.Format("c{0}{1}", row.ToString("D2"), col));
                    btn.Text = name;
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.Write("Error reading bookings from database. " + ex.Message);
                }
            }
        }
        protected void dpdCourtSelect_DataBound(object sender, EventArgs e)
        {
            LoadPlanning();
        }

        protected void dpdCourtSelect_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadPlanning();
        }

        protected void cmdBook_Click(object sender, EventArgs e)
        {
            int deltadays = (int.Parse(dpdJour.SelectedValue) - (int)DateTime.Now.DayOfWeek + 7) % 7;
            DateTime moment = DateTime.Now.AddDays(deltadays);
            moment = new DateTime(moment.Year, moment.Month, moment.Day, int.Parse(dpdHeure.SelectedValue),0,0);
            SqlConnection cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
            cnx.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = string.Format("INSERT INTO booking (moment, fkMadeBy, fkPartner, guest, fkCourt) VALUES ('{0}','{1}','{2}',null,{3});", moment.ToString("yyyy-MM-d HH:mm"), Global.getCurrentUserId(),dpdPartner.SelectedValue,dpdCourtSelect.SelectedValue);
            cmd.Connection = cnx;
            try
            {
                cmd.ExecuteNonQuery();
                LoadPlanning();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.Write("Error inserting booking: "+ ex.Message);
            }
        }

    }
}