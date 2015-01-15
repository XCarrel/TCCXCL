using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Devcorner.NIdenticon;
using System.IO;

namespace TCC.Pages
{
    public partial class Friends : System.Web.UI.Page
    {
        static Random rand = new Random();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblUname.Text = Global.getUsername();

            // Generate ideticon
            System.Drawing.Size isize = new System.Drawing.Size(32, 32);
            System.Drawing.Size iblocks = new System.Drawing.Size(6, 6);
            Devcorner.NIdenticon.BrushGenerators.IBrushGenerator ibrush = new Devcorner.NIdenticon.BrushGenerators.StaticColorBrushGenerator(System.Drawing.Color.Black);
            System.Drawing.Bitmap mybitmap = (new IdenticonGenerator()).Create(lblUname.Text, isize, System.Drawing.Color.Transparent, iblocks, System.Text.Encoding.Default, IdenticonGenerator.ExtendedBlockGeneratorsConfig, ibrush);

            // Load it into the control
            MemoryStream ms = new MemoryStream();
            mybitmap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
            var base64Data = Convert.ToBase64String(ms.ToArray());
            imgIdenticon.Src = "data:image/gif;base64," + base64Data;
            imgIdenticon.Border = 1;
        }
    }
}