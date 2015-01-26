using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Devcorner.NIdenticon;
using System.IO;
using System.Data.SqlClient;
using System.Web.Security;
using System.Configuration;


namespace TCC
{
    public partial class Mydenticon : System.Web.UI.UserControl
    {
        static Random rand = new Random(); // To pick identicon colors

        protected void Page_Load(object sender, EventArgs e)
        {
            // Generate identicon
            System.Drawing.Size isize = new System.Drawing.Size(32,32);
            System.Drawing.Size iblocks = new System.Drawing.Size(6,6);
            System.Drawing.Color icol = System.Drawing.Color.FromArgb(rand.Next(0, 255), rand.Next(0, 255), rand.Next(0, 255));
            Devcorner.NIdenticon.BrushGenerators.IBrushGenerator ibrush = new Devcorner.NIdenticon.BrushGenerators.StaticColorBrushGenerator(icol);
            System.Drawing.Bitmap mybitmap = (new IdenticonGenerator()).Create(lblUName.Text, isize, System.Drawing.Color.Transparent, iblocks, System.Text.Encoding.Default, IdenticonGenerator.ExtendedBlockGeneratorsConfig, ibrush);

            // Load it into the control
            MemoryStream ms = new MemoryStream();
            mybitmap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
            var base64Data = Convert.ToBase64String(ms.ToArray());
            pctIdenticon.Src = "data:image/gif;base64," + base64Data;
            pctIdenticon.Border = 1;
        }

        public void setName (string Uname)
        {
            lblUName.Text = Uname;
            string uid = Global.getUserId(Uname);
            // Find last game
            SqlConnection cnx = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
            cnx.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = string.Format("SELECT moment, courtName FROM booking INNER JOIN court ON fkCourt = idcourt WHERE fkMadeBy={0} OR fkPartner={0} ORDER BY moment DESC;", Uname);
            cmd.Connection = cnx;
            SqlDataReader rdr = cmd.ExecuteReader();
            string court = null;
            DateTime moment;
            if (rdr.Read())
            {
                moment = rdr.GetDateTime(0);
                court = rdr.GetString(1);
                lblLastGame.Text = string.Format("{0}, court {1}", moment, court);
            }
            rdr.Close();
            
            // Show it

        }
    }
}