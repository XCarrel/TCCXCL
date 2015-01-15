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
            Mydenticon.setName(Global.getUsername());
        }
    }
}