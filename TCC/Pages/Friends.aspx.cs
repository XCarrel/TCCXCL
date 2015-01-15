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
            ContentPlaceHolder content = Master.FindControl("MainContent") as ContentPlaceHolder; // In case we want to add controls at runtime

            Mydenticon.setName(Global.getUsername());
            string[] names = {"Pierre","Paul","Jean","Luc","Jacques","Sabrina","Brigitte"};
            foreach (string name in names)
            {
                Mydenticon mi = (Mydenticon)LoadControl("~/Mydenticon.ascx");
                mi.setName(name);
                mi.ID = "dynamic" + name;
                content.Controls.Add(mi);
                content.Controls.Add(new LiteralControl("<br>"));
            }
        }
    }
}