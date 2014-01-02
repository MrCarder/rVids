using System;
using System.Collections.Generic;
using System.Text;
using RedditSharp;

namespace RedditVideoTool
{
    public partial class home : System.Web.UI.Page
    {
        public string videoIds;
        public int videoCount;
        public bool loadPlayer;

        protected void Page_Load(object sender, EventArgs e)
        {
            CallJavascriptFunction("alert", "'works'");
            var reddit = new Reddit();
            //var user = reddit.LogIn("MrCarder", "Cardinals08");

            var subreddit = reddit.GetSubreddit("/r/videos");
            var posts = subreddit.GetPosts();

            if (IsPostBack)
            {
                bool valid = false;
                if (!string.IsNullOrEmpty(txtVideoCount.Text))
                {
                    valid = Int32.TryParse(txtVideoCount.Text, out videoCount);
                }
                if (valid)
                {
                    var videoUrls = GetVideoUrls(posts, videoCount);
                    videoIds = GetVideoIdStrings(videoUrls);
                }
            }
        }

        public List<string> GetVideoUrls(Listing<Post> posts, int numPosts)
        {
            var urls = new List<string>();

            foreach (var p in posts)
            {
                var myUri = new Uri(p.Url);
                var host = myUri.Host;

                if (urls.Count < numPosts)
                {
                    if (host == "www.youtube.com") urls.Add(p.Url);
                }
                else
                    break;
            }

            return urls;
        }

        public string GetVideoIdStrings(List<string> urls)
        {
            //TODO Should probably be moved
            if (urls.Count < 1) return "";
            var videoIds = new List<string>();
            var arrayStringBuilder = new StringBuilder();
            foreach (var url in urls)
            {
                int index = url.IndexOf("v=", System.StringComparison.Ordinal);
                int index2 = url.IndexOf("&", System.StringComparison.Ordinal);

                if (index2 > index && index2 > 0) videoIds.Add(url.Substring(index + 2, index2 - (index + 2)));
                else videoIds.Add(url.Substring(index + 2));
            }
            foreach (var videoId in videoIds)
            {
                arrayStringBuilder.Append("'" + videoId + "',");
            }
            var arrayString = arrayStringBuilder.ToString().Substring(0, arrayStringBuilder.Length - 1);


            return arrayString;
        }

        protected void btnStartVideos_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtVideoCount.Text))
            {
                //loadPlayer = true;
                //var valid = Int32.TryParse(txtVideoCount.Text, out videoCount);
                player.Visible = true;
            }
        }

        public void CallJavascriptFunction(string fName, string fParams)
        {
            var sb = new System.Text.StringBuilder();
            //sb.Append(@"<script>");
            sb.Append(fName + "(" + fParams + ");");
            //sb.Append(@"</script>");
            System.Web.UI.ScriptManager.RegisterStartupScript(this, this.GetType(), "JCall1", sb.ToString(), true);
        }   
    }
}