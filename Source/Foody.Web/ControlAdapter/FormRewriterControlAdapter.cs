
using System.Web;

namespace Cb.Web.ControlAdapter {
  public class FormRewriterControlAdapter : System.Web.UI.Adapters.ControlAdapter {
    /// <summary>
    /// Generates the target-specific markup for the control to which the control adapter is attached.
    /// </summary>
    /// <param name="writer">The <see cref="T:System.Web.UI.HtmlTextWriter"/> to use to render the target-specific output.</param>
    protected override void Render(System.Web.UI.HtmlTextWriter writer) {
      base.Render(new RewriteFormHtmlTextWriter(writer));
    }
  }

  public class RewriteFormHtmlTextWriter : System.Web.UI.HtmlTextWriter {
    
    /// <summary>
    /// Initializes a new instance of the <see cref="RewriteFormHtmlTextWriter"/> class.
    /// </summary>
    /// <param name="writer">The writer.</param>
    public RewriteFormHtmlTextWriter(System.IO.TextWriter writer)
      : base(writer) {
      base.InnerWriter = writer;
    }

    /// <summary>
    /// Initializes a new instance of the <see cref="RewriteFormHtmlTextWriter"/> class.
    /// </summary>
    /// <param name="writer">The writer.</param>
    public RewriteFormHtmlTextWriter(System.Web.UI.HtmlTextWriter writer)
      : base(writer) {
      this.InnerWriter = writer.InnerWriter;
    }

    /// <summary>
    /// Writes the specified markup attribute and value to the output stream, and, if specified, writes the value encoded.
    /// </summary>
    /// <param name="name">The markup attribute to write to the output stream.</param>
    /// <param name="value">The value assigned to the attribute.</param>
    /// <param name="fEncode">true to encode the attribute and its assigned value; otherwise, false.</param>
    public override void WriteAttribute(string name, string value, bool fEncode) {
      // If the attribute we are writing is the "action" attribute, and we are not on a sub-control, 
      // then replace the value to write with the raw URL of the request - which ensures that we'll
      // preserve the PathInfo value on postback scenarios
      if (name == "action") {
        HttpContext Context;
        Context = HttpContext.Current;
        if (Context.Items["ActionAlreadyWritten"] == null) {
          // Because we are using the UrlRewriting.net HttpModule, we will use the 
          // Request.RawUrl property within ASP.NET to retrieve the origional URL
          // before it was re-written.  You'll want to change the line of code below
          // if you use a different URL rewriting implementation.
          value = Context.Request.RawUrl;

          // Indicate that we've already rewritten the <form>'s action attribute to prevent
          // us from rewriting a sub-control under the <form> control
          Context.Items["ActionAlreadyWritten"] = true;
        }
      }
      base.WriteAttribute(name, value, fEncode);
    }
  }
}