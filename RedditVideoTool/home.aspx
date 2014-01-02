<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="Reddit_rVideos.home" %>

<!DOCTYPE html>
<script>
    // 2. This code loads the IFrame Player API code asynchronously.
    var tag = document.createElement('script');

    tag.src = "https://www.youtube.com/iframe_api";
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    // 3. This function creates an <iframe> (and YouTube player) after the API code downloads.
    var player;
    function onYouTubeIframeAPIReady() {
        player = new YT.Player('player', {
            height: '390',
            width: '640',
            events: {
                'onReady': onPlayerReady,
                'onStateChange': onPlayerStateChange
            }
        });
    }

    // 4. The API will call this function when the video player is ready.
    function onPlayerReady(event) {
        player.loadPlaylist([<%=videoIds%>]);
        event.target.playVideo();
    }

    // 5. The API calls this function when the player's state changes. The function indicates that when playing a video (state=1), the player should play for six seconds and then stop.
    var done = false;
    function onPlayerStateChange(event) {
        if (event.data == YT.PlayerState.PLAYING) {
            var currentUrl = player.getVideoUrl();
        }
        //if (event.data == YT.PlayerState.PLAYING && !done) {
        //    setTimeout(stopVideo, 6000);
        //    done = true;
        //}
    }
    function stopVideo() {
        player.stopVideo();
    }


</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
