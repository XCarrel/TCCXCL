using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TCC
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void dpdCourt_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblRes.Text = "Id court = " + dpdCourt.SelectedValue;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }

    }
}