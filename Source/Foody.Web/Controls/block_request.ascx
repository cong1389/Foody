<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_request.ascx.cs" Inherits="Cb.Web.Controls.block_request" %>

<!--block_request-->
<!--Yêu cầu-->
<section class="blox  dark  bg-colorskin w-animate w-start_animation" style="padding-top: 30px; background-size: cover; min-height: px; background-color: #ED4022;">
    <div class="max-overlay" style="background-color: "></div>
    <div class="wpb_row vc_row-fluid full-row">
        <div class="container">
            <div class="wpb_column vc_column_container vc_col-sm-12">
                <div class="vc_column-inner ">
                    <div class="wpb_wrapper">
                        <div class="wpb_text_column wpb_content_element ">
                            <div class="wpb_wrapper">
                                <h3 style="text-align: center; margin-bottom: 15px;">
                                    <asp:Literal runat="server" ID="ltrRequireCus"></asp:Literal>
                                </h3>

                            </div>
                        </div>
                        <div id='domain-form'>
                            <div id='wdc-style'>

                                <form method='get' accept-charset="UTF-8" action='' id='form' class='pure-form'>

                                    <div class='input-group' style='max-width: 900px;'>
                                        <input type='text' class='form-control searchTemplate' autocomplete='off' id='Search' name='search'
                                            placeholder='Nhập các từ khóa, vd: shop hoa tươi, du lịch, du học...' onkeypress="return checkEnter(event)" />
                                        <span class='input-group-btn'>
                                            <button type='submit' id='btnSubmit' class='search btn btn-default btn-info' onclick="return submitButtonSearchThemes(event)">
                                                <asp:Literal runat="server" ID="ltrContinus"></asp:Literal></button>
                                        </span>
                                    </div>
                                    <div id='loading'>
                                        <img src='/Images/preloader.gif' />
                                    </div>
                                </form>

                                <div style='max-width: 900px;'>
                                    <div id='results' class='result'></div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
