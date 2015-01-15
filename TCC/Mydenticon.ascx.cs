using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Devcorner.NIdenticon;
using System.IO;

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

        public void setName (string n)
        {
            lblUName.Text = n;
        }
    }
}