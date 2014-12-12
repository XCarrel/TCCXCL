<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="TCC.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="Label6" runat="server" Text="Votre Profil"></asp:Label>
<br />
    Prénom&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="txtFname" runat="server" OnTextChanged="TextBoxChanged"></asp:TextBox>
&nbsp;Nom
    <asp:TextBox ID="txtLname" runat="server" OnTextChanged="TextBoxChanged"></asp:TextBox>
<br />
<asp:Label ID="Label1" runat="server" Text="Adresse"></asp:Label>
&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="txtAdr1" runat="server" OnTextChanged="TextBoxChanged" Width="295px"></asp:TextBox>
<br />
<asp:Label ID="Label2" runat="server" Text="Adresse"></asp:Label>
&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="txtAdr2" runat="server" OnTextChanged="TextBoxChanged" Width="296px"></asp:TextBox>
<br />
<asp:Label ID="Label3" runat="server" Text="NPA"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="txtNPA" runat="server" Width="46px" OnTextChanged="TextBoxChanged"></asp:TextBox>
<asp:Label ID="lblCity" runat="server"></asp:Label>
<br />
<asp:Label ID="Label4" runat="server" Text="Téléphone"></asp:Label>
&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="txtTel" runat="server" OnTextChanged="TextBoxChanged"></asp:TextBox>
<br />
<asp:Label ID="Label5" runat="server" Text="Email"></asp:Label>
&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="txtEmail" runat="server" OnTextChanged="TextBoxChanged"></asp:TextBox>
    <br />
    <asp:Button ID="cmdOk" runat="server" Text="Ok" />
</asp:Content>
