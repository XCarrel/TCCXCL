<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Members.aspx.cs" Inherits="TCC.Members" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <asp:DataGrid ID="Grid" runat="server" PageSize="40" AllowPaging="True" DataKeyField="UserId"
    AutoGenerateColumns="False" CellPadding="4" GridLines="None" OnPageIndexChanged="Grid_PageIndexChanged" OnCancelCommand="Grid_CancelCommand"
    OnDeleteCommand="Grid_DeleteCommand" OnEditCommand="Grid_EditCommand" OnUpdateCommand="Grid_UpdateCommand">
        <Columns>
        <asp:BoundColumn HeaderText="UserId" DataField="UserId" HeaderStyle-CssClass="GridIdColumn" ItemStyle-CssClass="GridIdColumn">
        </asp:BoundColumn>
        <asp:BoundColumn HeaderText="Nom d'utilisateur" DataField="UserName">
        </asp:BoundColumn>
        <asp:BoundColumn HeaderText="Prénom" DataField="FirstName">
        </asp:BoundColumn>
        <asp:BoundColumn HeaderText="Nom" DataField="LastName">
        </asp:BoundColumn>
        <asp:EditCommandColumn EditText="Edit" CancelText="Cancel" UpdateText="Update" HeaderText="Edit">
        </asp:EditCommandColumn>
        </Columns>
        <FooterStyle BackColor="#999999" Font-Bold="True" ForeColor="White" />
        <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <PagerStyle BackColor="#999999" ForeColor="#333333" HorizontalAlign="Center" Mode="NumericPages" />
        <AlternatingItemStyle BackColor="White" />
        <HeaderStyle BackColor="#999999" Font-Bold="True" ForeColor="White" />
    </asp:DataGrid>
 </asp:Content>
