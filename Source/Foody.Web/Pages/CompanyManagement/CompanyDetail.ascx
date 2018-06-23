<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CompanyDetail.ascx.cs" Inherits="Cb.Web.Pages.CompanyManagement.CompanyDetail" %>

<!--CompanyDetail-->

<link href="/Admin/Components/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />

<asp:Literal runat="server" ID="ltrHeaderCategory"></asp:Literal>

<section class="container">
    <div class="row-wrapper-x">
        <section class="wpb_row   w-animate w-start_animation">
            <div class="wpb_column vc_column_container vc_col-sm-12">
                <div class="vc_column-inner ">
                    <div class="wpb_wrapper">
                        <hr class="vertical-space2">
                    </div>
                </div>
            </div>
            <div class="wpb_column vc_column_container vc_col-sm-12">
                <div class="vc_column-inner ">
                    <div class="wpb_wrapper">
                        <div class="max-title max-title5">
                            <h4> <asp:Literal runat="server" ID="ltrTitle"></asp:Literal></h4>
                        </div>
                        <div class="wpb_text_column wpb_content_element ">
                            <div class="wpb_wrapper">
                              <asp:Literal runat="server" ID="ltrDetail"></asp:Literal>
                            </div>
                        </div>
                        <hr class="vertical-space4">
                    </div>
                </div>
            </div>
            
        </section>
    </div>
</section>
