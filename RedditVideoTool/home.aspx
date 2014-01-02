<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="RedditVideoTool.home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
   <script type="text/javascript" src="/Scripts/MyScripts/home.js"></script>        
    <title>rVideos Home</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>/r/Videos</h1>
    </div>
        <div id="inputs">
            
            <asp:TextBox ID="txtVideoCount" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="btnStartVideos" runat="server" Text="Go!" OnClick="btnStartVideos_Click" />
            
        </div>
    <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
    <div id="player" runat="server" Visible="False"></div>
    </form>
</body>
</html>
