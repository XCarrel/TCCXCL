<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Bookings.aspx.cs" Inherits="TCC.Bookings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <h1>
        <asp:Label ID="lblTitre" runat="server" CssClass="title" Text="Label"></asp:Label>
    </h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Importation</h2>
    <asp:FileUpload ID="fup" runat="server" />
    <asp:Button ID="cmdImport" runat="server" Text="Importer" OnClick="cmdImport_Click" />
    <br />
    <asp:SqlDataSource ID="DBCourts" runat="server" ConnectionString="<%$ ConnectionStrings:TCCXCLConnection %>" SelectCommand="SELECT * FROM [court]"></asp:SqlDataSource>
    <h2>Réservations Périodiques</h2>
    Réserver le court &nbsp;<asp:DropDownList ID="dpdCourtSelect" runat="server" DataSourceID="DBCourts" DataTextField="courtName" DataValueField="idcourt"></asp:DropDownList>
    &nbsp;tous les <asp:DropDownList ID="dpdPeriod" runat="server">
        <asp:ListItem Value="1">Lundi</asp:ListItem>
        <asp:ListItem Value="2">Mardi</asp:ListItem>
        <asp:ListItem Value="3">Mercredi</asp:ListItem>
        <asp:ListItem Value="4">Jeudi</asp:ListItem>
        <asp:ListItem Value="5">Vendredi</asp:ListItem>
        <asp:ListItem Value="6">Samedi</asp:ListItem>
        <asp:ListItem Value="0">Dimanche</asp:ListItem>
        <asp:ListItem Value="99">jours</asp:ListItem>
    </asp:DropDownList>
&nbsp;à
    <asp:DropDownList ID="dpdHeure" runat="server">
        <asp:ListItem Value="0">-- Heure --</asp:ListItem>
        <asp:ListItem Value="8">8:00</asp:ListItem>
        <asp:ListItem Value="9">9:00</asp:ListItem>
        <asp:ListItem Value="10">10:00</asp:ListItem>
        <asp:ListItem Value="11">11:00</asp:ListItem>
        <asp:ListItem Value="12">12:00</asp:ListItem>
        <asp:ListItem Value="13">13:00</asp:ListItem>
        <asp:ListItem Value="14">14:00</asp:ListItem>
        <asp:ListItem Value="15">15:00</asp:ListItem>
        <asp:ListItem Value="16">16:00</asp:ListItem>
        <asp:ListItem Value="17">17:00</asp:ListItem>
        <asp:ListItem Value="18">18:00</asp:ListItem>
        <asp:ListItem Value="19">19:00</asp:ListItem>
        <asp:ListItem Value="20">20:00</asp:ListItem>
        <asp:ListItem Value="21">21:00</asp:ListItem>
    </asp:DropDownList>
    &nbsp;entre:<asp:Calendar ID="CalFrom" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px">
        <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
        <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
        <OtherMonthDayStyle ForeColor="#999999" />
        <SelectedDayStyle BackColor="#333399" ForeColor="White" />
        <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
        <TodayDayStyle BackColor="#CCCCCC" />
    </asp:Calendar>
    et:<asp:Calendar ID="CalTo" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px">
        <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
        <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
        <OtherMonthDayStyle ForeColor="#999999" />
        <SelectedDayStyle BackColor="#333399" ForeColor="White" />
        <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
        <TodayDayStyle BackColor="#CCCCCC" />
    </asp:Calendar>
    <br />
    <br />
    <br />
    <asp:Button ID="cmdCreate" runat="server" OnClick="cmdCreate_Click" Text="Créer" />
</asp:Content>
