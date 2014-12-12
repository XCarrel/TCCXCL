<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Courts.aspx.cs" Inherits="TCC.Courts" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <asp:DropDownList ID="dpdCourtSelect" runat="server" DataSourceID="DBCourts" DataTextField="courtName" DataValueField="idcourt" OnDataBound="dpdCourtSelect_DataBound" OnSelectedIndexChanged="dpdCourtSelect_SelectedIndexChanged">
    </asp:DropDownList>
    <asp:SqlDataSource ID="DBCourts" runat="server" ConnectionString="<%$ ConnectionStrings:TCCXCLConnection %>" SelectCommand="SELECT * FROM [court]"></asp:SqlDataSource>
    <asp:Button ID="cmdCourtSelect" runat="server" Text="Afficher" />
    <asp:Table ID="Court1" runat="server" CssClass="tccPanel" Height="88px" Width="217px">
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" ID="cell0000"> </asp:TableCell>
            <asp:TableCell runat="server" ID="cell0001">Lundi</asp:TableCell>
            <asp:TableCell runat="server" ID="cell0002">Mardi</asp:TableCell>
            <asp:TableCell runat="server" ID="cell0003">Mercredi</asp:TableCell>
            <asp:TableCell runat="server" ID="cell0004">Jeudi</asp:TableCell>
            <asp:TableCell runat="server" ID="cell0005">Vendredi</asp:TableCell>
            <asp:TableCell runat="server" ID="cell0006">Samedi</asp:TableCell>
            <asp:TableCell runat="server" ID="cell0007">Dimanche</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" ID="cell0100">08:00</asp:TableCell>
            <asp:TableCell runat="server" ID="cell0101"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0102"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0103"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0104"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0105"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0106"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0107"></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" ID="cell0200">09:00</asp:TableCell>
            <asp:TableCell runat="server" ID="cell0201"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0202"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0203"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0204"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0205"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0206"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0207"></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" ID="cell0300">10:00</asp:TableCell>
            <asp:TableCell runat="server" ID="cell0301"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0302"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0303"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0304"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0305"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0306"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0307"></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" ID="cell0400">11:00</asp:TableCell>
            <asp:TableCell runat="server" ID="cell0401"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0402"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0403"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0404"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0405"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0406"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0407"></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" ID="cell0500">12:00</asp:TableCell>
            <asp:TableCell runat="server" ID="cell0501"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0502"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0503"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0504"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0505"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0506"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0507"></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" ID="cell0600">13:00</asp:TableCell>
            <asp:TableCell runat="server" ID="cell0601"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0602"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0603"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0604"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0605"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0606"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0607"></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" ID="cell0700">14:00</asp:TableCell>
            <asp:TableCell runat="server" ID="cell0701"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0702"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0703"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0704"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0705"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0706"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0707"></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" ID="cell0800">15:00</asp:TableCell>
            <asp:TableCell runat="server" ID="cell0801"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0802"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0803"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0804"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0805"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0806"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0807"></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" ID="cell0900">16:00</asp:TableCell>
            <asp:TableCell runat="server" ID="cell0901"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0902"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0903"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0904"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0905"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0906"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell0907"></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" ID="cell1000">17:00</asp:TableCell>
            <asp:TableCell runat="server" ID="cell1001"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1002"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1003"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1004"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1005"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1006"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1007"></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" ID="cell1100">18:00</asp:TableCell>
            <asp:TableCell runat="server" ID="cell1101"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1102"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1103"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1104"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1105"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1106"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1107"></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" ID="cell1200">19:00</asp:TableCell>
            <asp:TableCell runat="server" ID="cell1201"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1202"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1203"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1204"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1205"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1206"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1207"></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" ID="cell1300">20:00</asp:TableCell>
            <asp:TableCell runat="server" ID="cell1301"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1302"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1303"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1304"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1305"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1306"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1307"></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" ID="cell1400">21:00</asp:TableCell>
            <asp:TableCell runat="server" ID="cell1401"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1402"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1403"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1404"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1405"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1406"></asp:TableCell>
            <asp:TableCell runat="server" ID="cell1407"></asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <asp:Label ID="lblMessage" runat="server" Font-Size="X-Large" Text="Label" Visible="False"></asp:Label>
    <br />
    <asp:DropDownList ID="dpdJour" runat="server">
        <asp:ListItem Value="-1">-- Jour --</asp:ListItem>
        <asp:ListItem Value="1">Lundi</asp:ListItem>
        <asp:ListItem Value="2">Mardi</asp:ListItem>
        <asp:ListItem Value="3">Mercredi</asp:ListItem>
        <asp:ListItem Value="4">Jeudi</asp:ListItem>
        <asp:ListItem Value="5">Vendredi</asp:ListItem>
        <asp:ListItem Value="6">Samedi</asp:ListItem>
        <asp:ListItem Value="0">Dimanche</asp:ListItem>
    </asp:DropDownList>
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
    <asp:DropDownList ID="dpdPartner" runat="server" DataSourceID="DBMembers" DataTextField="LastName" DataValueField="UserId">
    </asp:DropDownList>
    <asp:SqlDataSource ID="DBMembers" runat="server" ConnectionString="<%$ ConnectionStrings:TCCXCLConnection %>" SelectCommand="SELECT [UserId], [Firstname], [LastName] FROM [Users]"></asp:SqlDataSource>
    Invité<asp:TextBox ID="txtPlayer" runat="server"></asp:TextBox>
    <br />
    <asp:Button ID="cmdBook" runat="server" OnClick="cmdBook_Click" Text="Réserver" />
    <br />
    <br />
</asp:Content>