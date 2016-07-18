using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using SelectPdf;
using HtmlAgilityPack;
using System.Drawing;


namespace BusinessCard
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region Event
        protected void btnPublish_Click(object sender, EventArgs e)
        {
            //ClientScriptManager script = new ClientScriptManager();

            //Get the HTML Code
            string urlAddress = "http://localhost:1280/";
            string htmlString = string.Empty;

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(urlAddress);
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            if (response.StatusCode == HttpStatusCode.OK)
            {
                Stream receiveStream = response.GetResponseStream();
                StreamReader readStream = null;
                if (response.CharacterSet == null)
                    readStream = new StreamReader(receiveStream);
                else
                    readStream = new StreamReader(receiveStream, Encoding.GetEncoding(response.CharacterSet));
                htmlString = readStream.ReadToEnd();
                response.Close();
                readStream.Close();
            }

            //rewrite html code using LingQ
            //var document = XDocument.Parse(htmlString);

            //rewrite html code using HTMLAgilityPack: http://www.mikesdotnetting.com/article/273/using-the-htmlagilitypack-to-parse-html-in-asp-net
            //var document = new HtmlAgilityPack.HtmlDocument();
            //document.Load(htmlString);
            //var root = document.DocumentNode;

            //rewrite html code by replacing css classes and ommitting break lines
            htmlString = htmlString.Replace("bodyBackground", "bodyNoBackground");
            htmlString = htmlString.Replace("non-layout", "hide");
            htmlString = htmlString.Replace("<br>", "");
            htmlString = htmlString.Replace("<br/>", "");

            //HiddenWebElements still not documented on how to bind with HtmlToPdf during conversion.
            //string[] hiddenSelectors = { "*.non-layout" };
            //HiddenWebElements hd = new HiddenWebElements();
            //hd.CssSelectors = hiddenSelectors;

            // instantiate a html to pdf converter object
            HtmlToPdf converter = new HtmlToPdf();

            SizeF bcCustomSize = new SizeF(420, 270);

            // SET CONVERTER OPTIONS
            converter.Options.WebPageWidth = 420;
            converter.Options.WebPageHeight = 270;

            //converter.Options.PdfPageSize = PdfPageSize.A4;
            converter.Options.PdfPageSize = PdfPageSize.Custom;
            converter.Options.PdfPageCustomSize = bcCustomSize;

            converter.Options.PdfPageOrientation = PdfPageOrientation.Portrait;
            converter.Options.MarginLeft = 10;
            converter.Options.MarginRight = 10;
            converter.Options.MarginTop = 20;
            converter.Options.MarginBottom = 20;

            converter.Options.JpegCompressionEnabled = false;
            converter.Options.JpegCompressionLevel = 0;

            converter.Options.AutoFitHeight = HtmlToPdfPageFitMode.AutoFit;
            converter.Options.AutoFitWidth = HtmlToPdfPageFitMode.AutoFit;

            //converter.Options.DrawBackground = false;

            // set css @media print
            //converter.Options.CssMediaType = HtmlToPdfCssMediaType.Print;

            // create a new pdf document converting an url
            //PdfDocument doc = converter.ConvertUrl("http://localhost:1280/");

            PdfDocument doc = converter.ConvertHtmlString(htmlString, urlAddress);

            // save pdf document
            doc.Save(Response, false, "Sample.pdf");

            // close pdf document
            doc.Close();
        }
        #endregion Event

        
    }

}