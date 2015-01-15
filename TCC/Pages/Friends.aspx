<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Friends.aspx.cs" Inherits="TCC.Pages.Friends" %>

<%@ Register Src="~/Mydenticon.ascx" TagPrefix="uc1" TagName="Mydenticon" %>
<%@ Reference Control="~/Mydenticon.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <h1>Amis</h1>
    <uc1:Mydenticon runat="server" id="Mydenticon" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
