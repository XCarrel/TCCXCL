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
        }

    }
}