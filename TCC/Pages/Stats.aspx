<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Stats.aspx.cs" Inherits="TCC.Pages.Stats" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <asp:Button ID="cmdInvitations" runat="server" Text="Invitations faites par" OnClick="cmdInvitations_Click" />
    <asp:DropDownList ID="dpdMembers" runat="server" DataSourceID="SqlDataSource1" DataTextField="UserName" DataValueField="UserId">
    </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TCCXCLConnection %>" SelectCommand="SELECT [UserId], [UserName] FROM [Users]"></asp:SqlDataSource>
    <br />
    <asp:Button ID="cmdVisitors" runat="server" Text="Visiteurs durant ces 6 derniers mois" OnClick="cmdVisitors_Click" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
