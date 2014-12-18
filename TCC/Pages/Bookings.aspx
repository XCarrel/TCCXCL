<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Bookings.aspx.cs" Inherits="TCC.Bookings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <h1>
        <asp:Label ID="lblTitre" runat="server" CssClass="title" Text="Label"></asp:Label>
    </h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FileUpload ID="fup" runat="server" />
    <asp:Button ID="cmdImport" runat="server" Text="Importer" OnClick="cmdImport_Click" />
</asp:Content>
