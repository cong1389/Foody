<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Request.ascx.cs" Inherits="Cb.Web.Pages.Contact.Request" %>

<!--Request-->
<asp:Literal runat="server" ID="ltrHeaderCategory"></asp:Literal>

<section class="blox  page-title-x    w-animate  w-start_animation" style="padding-top: 50px; padding-bottom: 50px; background-size: cover; min-height: px; background-color: #f7f7f7;">
    <div class="max-overlay" style="background-color: "></div>
    <div class="wpb_row vc_row-fluid full-row">
        <div class="container">
            <div class="wpb_column vc_column_container vc_col-sm-2">
                <div class="vc_column-inner ">
                    <div class="wpb_wrapper"></div>
                </div>
            </div>
            <div class="wpb_column vc_column_container vc_col-sm-8">
                <div class="vc_column-inner ">
                    <div class="wpb_wrapper">

                        <div class="wpb_text_column wpb_content_element ">
                            <div class="wpb_wrapper">
                                <h3 style="text-align: center;"><strong>Bạn vẫn chưa tìm được giao diện vừa ý</strong></h3>
                                <p style="text-align: center;">
                                    Bạn có thể gợi ý cho chúng tôi về giao diện mong muốn của bạn, giao diện có thể giúp bạn kinh doanh hiệu quả.
                                </p>
                            </div>
                        </div>
                        <hr class="vertical-space2">
                        <div role="form" class="wpcf7" id="wpcf7-f31-p9314-o1" lang="en-US" dir="ltr">
                            <div class="screen-reader-response"></div>
                            <div>
                                <div style="display: none;">
                                    <input type="hidden" name="_wpcf7" value="31">
                                    <input type="hidden" name="_wpcf7_version" value="4.3.1">
                                    <input type="hidden" name="_wpcf7_locale" value="en_US">
                                    <input type="hidden" name="_wpcf7_unit_tag" value="wpcf7-f31-p9314-o1">
                                    <input type="hidden" name="_wpnonce" value="abac995aef">
                                </div>
                                <div id="seo_consolation_form">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <p class="seotitle">Họ tên của bạn*</p>
                                            <p>
                                                <span class="wpcf7-form-control-wrap Name">
                                                    <input runat="server" id="txtFullName" type="text" name="Name" value="" size="40" class="wpcf7-form-control wpcf7-text wpcf7-validates-as-required seostyle" aria-required="true" aria-invalid="false"></span>
                                            </p>
                                        </div>
                                        <div class="col-sm-6">
                                            <p class="seotitle">Email của bạn*</p>
                                            <p>
                                                <span class="wpcf7-form-control-wrap Phone">
                                                    <input runat="server" id="txtEmail" type="text" name="Email" value="" size="40" class="wpcf7-form-control wpcf7-text wpcf7-email wpcf7-validates-as-required wpcf7-validates-as-email seostyle" aria-required="true" aria-invalid="false"></span>
                                            </p>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <p class="seotitle">Bạn vui lòng nhập nội dung ?</p>
                                            <p>
                                                <span class="wpcf7-form-control-wrap textarea">
                                                    <textarea runat="server" id="txtMessage" name="textarea" cols="40" rows="10" class="wpcf7-form-control wpcf7-textarea seostyle" aria-invalid="false"></textarea></span>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <p class="checkboxtitle">What is your goal?</p>
                                            <p></p>
                                        </div>
                                        <div class="col-sm-6"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <p class="checkbox_seo_title">
                                                <span class="wpcf7-form-control-wrap checkbox"><span class="wpcf7-form-control wpcf7-checkbox wpcf7-validates-as-required seo_from_checkbox"><span class="wpcf7-list-item first">
                                                    <label>
                                                        <input type="checkbox" name="checkbox[]" value="Website Design">&nbsp;<span class="wpcf7-list-item-label">Website Design</span></label></span><span class="wpcf7-list-item"><label><input type="checkbox" name="checkbox[]" value="Online Marketing">&nbsp;<span class="wpcf7-list-item-label">Online Marketing</span></label></span><span class="wpcf7-list-item last"><label><input type="checkbox" name="checkbox[]" value="Digital Branding">&nbsp;<span class="wpcf7-list-item-label">Digital Branding</span></label></span></span></span>
                                            </p>
                                            <p></p>
                                        </div>
                                        <div class="col-sm-6">
                                            <p class="checkbox_seo_title">
                                                <span class="wpcf7-form-control-wrap checkbox-745"><span class="wpcf7-form-control wpcf7-checkbox wpcf7-validates-as-required seo_from_checkbox"><span class="wpcf7-list-item first">
                                                    <label>
                                                        <input type="checkbox" name="checkbox-745[]" value="SEO Optimization">&nbsp;<span class="wpcf7-list-item-label">SEO Optimization</span></label></span><span class="wpcf7-list-item"><label><input type="checkbox" name="checkbox-745[]" value="Wordpress Hosting">&nbsp;<span class="wpcf7-list-item-label">Wordpress Hosting</span></label></span><span class="wpcf7-list-item last"><label><input type="checkbox" name="checkbox-745[]" value="VPS Hosting">&nbsp;<span class="wpcf7-list-item-label">VPS Hosting</span></label></span></span></span>
                                            </p>
                                            <p></p>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-5 seo_contact_btn">
                                            <asp:Button ID="btnSend" runat="server" CssClass="wpcf7-form-control wpcf7-submit seo_form_btn_sent seo_form_btn_style" Text="Gửi liên hệ"
                                                OnClick="btnSend_ServerClick" />
                                            <img class="ajax-loader" src="/Images/ajax-loader.gif" alt="Sending ..." style="visibility: hidden;">
                                        </div>
                                    </div>
                                </div>
                                <div class="wpcf7-response-output wpcf7-display-none"></div>
                            </div>
                        </div>
                        <hr class="vertical-space5">
                    </div>
                </div>
            </div>
            <div class="wpb_column vc_column_container vc_col-sm-2">
                <div class="vc_column-inner ">
                    <div class="wpb_wrapper"></div>
                </div>
            </div>
        </div>
    </div>
</section>
