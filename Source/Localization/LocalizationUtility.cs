
using System.Web.UI.WebControls;
using System.Globalization;
using Cb.Localization.resources;
using System.Web.UI;

namespace Cb.Localization
{

    public class LocalizationUtility
    {
        #region Methods

        #region Public

        /// <summary>
        /// Adds the hover HTML.
        /// </summary>
        /// <param name="hyperlink">The hyperlink.</param>
        /// <param name="html">The HTML.</param>
        public static void AddHoverHtml(HyperLink hyperlink, string html)
        {
            hyperlink.Attributes.Add("onmouseover", string.Format(Overlib.SIMPLE, html));
            hyperlink.Attributes.Add("onmouseout", Overlib.MOUSEOUT);
        }


        /// <summary>
        /// Adds the image alternate text.
        /// </summary>
        /// <param name="image">The image.</param>
        public static void AddImageAlternateText(System.Web.UI.WebControls.Image image)
        {
            image.AlternateText = labels.ResourceManager.GetString(image.ID);
        }

        /// <summary>
        /// Gets the text.
        /// </summary>
        /// <param name="name">The name.</param>
        /// <returns></returns>
        public static string GetText(string name)
        {
            CultureInfo ci = new CultureInfo("vi-VN");
            return labels.ResourceManager.GetString(name, ci);
        }

        public static string GetText(string name, CultureInfo ci)
        {
            if (labels.ResourceManager.GetString(name, ci) == null)
                return name;
            else
                return labels.ResourceManager.GetString(name, ci);
        }

        /// <summary>
        /// Gets the help text.
        /// </summary>
        /// <param name="name">The name.</param>
        /// <returns></returns>
        //public static string GetHelpText(string name) {
        //  return help.ResourceManager.GetString(name);
        //}

        /// <summary>
        /// Gets the critical message text.
        /// </summary>
        /// <param name="message">The message.</param>
        /// <returns></returns>
        public static string GetCriticalMessageText(string message)
        {
            return string.Format(GetText("lblCriticalError"), message);
        }

        /// <summary>
        /// Gets the payment provider error text.
        /// </summary>
        /// <param name="message">The message.</param>
        /// <returns></returns>
        public static string GetPaymentProviderErrorText(string message)
        {
            return string.Format(GetText("lblPaymentProviderError"), message);
        }

        public static void SetValueControl(Control control)
        {
            CultureInfo ci = new CultureInfo("vi-VN");
            SetValueControl(control, ci);
        }

        public static void SetValueControl(Control control, CultureInfo ci)
        {
            foreach (Control item in control.Controls)
            {
                if (item is Literal)
                {
                    Literal item_lit = item as Literal;
                    item_lit.Text = GetText(item_lit.Text, ci);
                }

                else if (item is HyperLink)
                {
                    HyperLink hyp = item as HyperLink;
                    hyp.Text = GetText(hyp.Text, ci);
                }
                else if (item is TextBox)
                {
                    TextBox item_Text = item as TextBox;
                    item_Text.ToolTip = GetText(item_Text.ToolTip, ci);
                    item_Text.Text = GetText(item_Text.Text, ci);
                }
                else if (item is BaseValidator)
                {
                    BaseValidator item_val = item as BaseValidator;
                    item_val.ErrorMessage = GetText(item_val.ErrorMessage);
                }
                else if (item is Label)
                {
                    Label item_lbl = item as Label;
                    item_lbl.Text = GetText(item_lbl.Text, ci);
                }
                else if (item is LinkButton)
                {
                    LinkButton item_lbl = item as LinkButton;
                    item_lbl.Text = GetText(item_lbl.Text, ci);
                    item_lbl.ToolTip = GetText(item_lbl.ToolTip, ci);
                }
                else if (item is ImageButton)
                {
                    ImageButton item_lbl = item as ImageButton;
                    item_lbl.AlternateText = GetText(item_lbl.AlternateText, ci);
                }
                else if (item is CheckBox)
                {
                    CheckBox item_lbl = item as CheckBox;
                    item_lbl.Text = GetText(item_lbl.Text, ci);
                }
                else if (item is Button)
                {
                    Button item_btn = item as Button;
                    item_btn.Text = GetText(item_btn.Text, ci);
                }

                else if (item is Panel)
                {
                    Panel item_panel = item as Panel;
                    SetValueControl(item_panel, ci);
                }
            }
        }


        #endregion

        #endregion
    }
}
