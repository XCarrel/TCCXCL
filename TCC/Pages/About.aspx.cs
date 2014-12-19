using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.Security;



namespace TCC
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ContentPlaceHolder content = Master.FindControl("MainContent") as ContentPlaceHolder;

            Button btn = new Button();
            btn.Text = "Dynamique";
            btn.Click += btn_Click;
            content.Controls.Add(btn);
        }

        void btn_Click(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }

    }
}