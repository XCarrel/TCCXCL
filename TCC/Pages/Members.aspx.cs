using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Collections;

namespace TCC
{
    public partial class Members : System.Web.UI.Page
    {
        SqlDataAdapter da;
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand();
        SqlConnection con;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }

        public void BindData()
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
            cmd.CommandText = "Select UserId, FirstName, LastName, UserName from Users";
            cmd.Connection = con;
            da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            con.Open();
            cmd.ExecuteNonQuery();
            Grid.DataSource = ds;
            Grid.DataBind();
            con.Close();
        }

        protected void Grid_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
        {
            Grid.CurrentPageIndex = e.NewPageIndex;
            BindData();
        }

        protected void Grid_EditCommand(object source, DataGridCommandEventArgs e)
        {
            Grid.EditItemIndex = e.Item.ItemIndex;
            BindData();
        }

        protected void Grid_CancelCommand(object source, DataGridCommandEventArgs e)
        {
            Grid.EditItemIndex = -1;
            BindData();
        }

        protected void Grid_DeleteCommand(object source, DataGridCommandEventArgs e)
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
            cmd.Connection = con;
            string uid = Grid.DataKeys[(int)e.Item.ItemIndex].ToString();
            cmd.CommandText = "Delete from Users where UserName='" + uid + "'";
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();
            Grid.EditItemIndex = -1;
            BindData();
        }

        protected void Grid_UpdateCommand(object source, DataGridCommandEventArgs e)
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["TCCXCLConnection"].ConnectionString);
            cmd.Parameters.Add("@UserId", SqlDbType.UniqueIdentifier).Value = new Guid(((TextBox)e.Item.Cells[0].Controls[0]).Text);
            cmd.Parameters.Add("@UserName", SqlDbType.Char).Value = ((TextBox)e.Item.Cells[1].Controls[0]).Text;
            cmd.Parameters.Add("@FirstName", SqlDbType.Char).Value = ((TextBox)e.Item.Cells[2].Controls[0]).Text;
            cmd.Parameters.Add("@LastName", SqlDbType.Char).Value = ((TextBox)e.Item.Cells[3].Controls[0]).Text;
            cmd.CommandText = "Update Users set UserName=@UserName,FirstName=@FirstName,LastName=@LastName where UserId=@UserId";
            cmd.Connection = con;
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();
            Grid.EditItemIndex = -1;
            BindData();
        }

    }
}