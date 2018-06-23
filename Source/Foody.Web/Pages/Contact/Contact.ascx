<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Contact.ascx.cs" Inherits="Cb.Web.Pages.Contact.Contact" %>

<!--Contact-->
<%@ Register TagPrefix="dgc" TagName="block_googlemap" Src="~/Controls/block_googlemap.ascx" %>
<%@ Register TagPrefix="dgc" TagName="block_like" Src="~/Controls/block_like.ascx" %>

<asp:Literal runat="server" ID="ltrHeaderCategory"></asp:Literal>

<section class="container">
    <div class="row-wrapper-x">
        <section class="wpb_row  m-bottom w-animate w-start_animation">
            <div class="wpb_column vc_column_container vc_col-sm-12">
                <div class="vc_column-inner vc_custom_1454746472228">
                    <div class="wpb_wrapper">
                        <hr class="vertical-space2">
                        <div class="max-title max-title5">
                            <h4>
                                <asp:Literal runat="server" ID="ltrCateNameTitle"></asp:Literal></h4>
                        </div>

                        <div class="vc_row wpb_row vc_inner vc_row-fluid easydesign-contact">
                            <div class="wpb_column vc_column_container vc_col-sm-6">
                                <div class="vc_column-inner ">
                                    <div class="wpb_wrapper">
                                        <div class="wpb_single_image wpb_content_element vc_align_left">
                                            <figure class="wpb_wrapper vc_figure">
                                                <div class="vc_single_image-wrapper   vc_box_border_grey">
                                                    <img width="61" height="35" src="/Images/EasyDesign-CONTACT-PAGE-v-4_03.png" class="vc_single_image-img attachment-full" alt="EasyDesign-CONTACT-PAGE-v-4_03">
                                                </div>
                                            </figure>
                                        </div>
                                        <div class="wpb_text_column wpb_content_element ">
                                            <div class="wpb_wrapper">
                                                <asp:Literal runat="server" ID="ltrCategoryBrief"></asp:Literal>
                                            </div>
                                        </div>
                                        <div role="form" class="wpcf7" id="wpcf7-f30-p5675-o1" lang="en-US" dir="ltr">
                                            <div class="screen-reader-response"></div>
                                            <div>

                                                <div id="talk-business">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <p class="talk-business-title">Họ và tên của bạn</p>
                                                            <p>
                                                                <span class="wpcf7-form-control-wrap Name">
                                                                    <input runat="server" id="txtFullName" type="text" name="Name" value="" size="40" class="wpcf7-form-control wpcf7-text style_contact_information" aria-invalid="false"></span>
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <p></p>
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <p class="talk-business-title">Email của bạn</p>
                                                            <p>
                                                                <span class="wpcf7-form-control-wrap Email">
                                                                    <input runat="server" id="txtEmail" name="Email" value="" size="40" class="wpcf7-form-control wpcf7-text wpcf7-email wpcf7-validates-as-email style_contact_information" aria-invalid="false"></span>
                                                            </p>
                                                        </div>

                                                    </div>
                                                    <p></p>
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <p class="talk-business-title">Nội dung cần liên hệ</p>
                                                            <p>
                                                                <span class="wpcf7-form-control-wrap Textarea">
                                                                    <textarea runat="server" id="txtMessage" name="Textarea" cols="40" rows="10" class="wpcf7-form-control wpcf7-textarea style_contact_information" aria-invalid="false"></textarea></span>
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <p></p>
                                                    <div class="row contact_information_btns">
                                                        <div class="col-sm-4"></div>
                                                        <div class="col-sm-4">
                                                            <asp:Button ID="btnSend" runat="server" CssClass="wpcf7-form-control wpcf7-submit seo_form_btn_sent seo_form_btn_style" Text="Gửi liên hệ"
                                                                OnClick="btnSend_ServerClick" />
                                                            <img class="ajax-loader" src="/Images/ajax-loader.gif" alt="Sending ..." style="visibility: hidden;">
                                                        </div>
                                                        <div class="col-sm-4"></div>
                                                    </div>
                                                </div>
                                                <div class="wpcf7-response-output wpcf7-display-none"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="wpb_column vc_column_container vc_col-sm-6 divContactRight">
                                <div class="vc_column-inner ">
                                    <div class="wpb_wrapper">

                                        <div class="wpb_text_column wpb_content_element  vc_custom_1456137138141">
                                            <div class="wpb_wrapper">

                                                <div class="max-title max-title5">
                                                    <h4>Social</h4>
                                                </div>
                                                <dgc:block_like ID="block_like1" runat="server" />

                                                <div class="max-title max-title5">
                                                    <h4>Phone</h4>
                                                </div>
                                                <p style="font-size: 14px; font-weight: bolder; color: #0cb9e7; margin-bottom: 0;" class="hidden">
                                                    <asp:Literal runat="server" ID="ltrPhoneName"></asp:Literal>:
                                                </p>
                                                
                                                    <i class="fa fa-phone fa-fw colorBlue"></i><asp:Literal runat="server" ID="ltrPhoneValue"></asp:Literal>
                                                

                                                 <div class="max-title max-title5">
                                                    <h4>Email</h4>
                                                </div>
                                                   <i class="fa fa-envelope-o fa-fw colorBlue"></i>
                                                    <asp:Literal runat="server" ID="ltrEmail"></asp:Literal>
                                               

                                                <div class="max-title max-title5">
                                                    <h4>
                                                        <asp:Literal runat="server" ID="ltrAddressName"></asp:Literal></h4>
                                                </div>
                                                <i class="fa fa-map-marker fa-fw colorBlue"></i>
                                                    <asp:Literal runat="server" ID="ltrAddressValue"></asp:Literal>
                                               

                                                <div class="max-title max-title5">
                                                    <h4>Opening Hours</h4>
                                                </div>
                                               <i class="fa fa-calendar fa-fw colorBlue"></i>
                                                    <asp:Literal runat="server" ID="ltrHouse"></asp:Literal>
                                               

                                               
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr class="vertical-space2">
                    </div>
                </div>

            </div>
        </section>
    </div>
    <div class="wpb_column vc_column_container vc_col-sm-12">
        <div class="w-map">
            <dgc:block_googlemap ID="block_googlemap" runat="server" />
        </div>
    </div>
    <hr class="vertical-space2">
</section>
