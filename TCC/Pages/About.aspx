<%@ Page Title="Sand Box" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="TCC.About" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:DropDownList ID="dpdCourt" runat="server" OnSelectedIndexChanged="dpdCourt_SelectedIndexChanged">
        <asp:ListItem Value="10">Court 10</asp:ListItem>
        <asp:ListItem Value="11">Court 11</asp:ListItem>
        <asp:ListItem Value="12">Court 12</asp:ListItem>
    </asp:DropDownList>
    <asp:Label ID="lblRes" runat="server" Text="Label"></asp:Label>
    <br />
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
</asp:Content>