<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_salesprice.ascx.cs" Inherits="Cb.Web.Admin.Controls.block_salesprice" %>

<!--block_salesprice-->

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>

<div id="dvGrid" style="padding: 10px; width: 550px">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <asp:GridView ID="grdSalesPrice"
                runat="server"
                AutoGenerateColumns="False"
                AutoGenerateEditButton="false"
                AllowPaging="True"
                AllowSorting="True"
                ShowFooter="True"
                OnRowEditing="grdSalesPrice_RowEditing"
                OnRowUpdating="grdSalesPrice_RowUpdating"
                OnPageIndexChanging="grdSalesPrice_PageIndexChanging"
                OnRowCancelingEdit="grdSalesPrice_RowCancelingEdit"
                OnRowDeleting="grdSalesPrice_RowDeleted"
                OnRowDataBound="grdSalesPrice_RowDataBound"
                OnDataBound="grdSalesPrice_DataBound"
                PagerStyle-CssClass="bs-pagination"
                ShowHeaderWhenEmpty="True"
                EmptyDataText="No Records Found" 
                CssClass="table table-bordered table-hover tbl-news"
                DataKeyNames="Id">
                <Columns>

                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="Id" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lbID" runat="server" Text='<%# Eval("Id")%>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtID" Width="40px" MaxLength="5" runat="server"></asp:TextBox>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="STT">
                        <ItemTemplate>
                            <asp:Label ID="lbRowDesc" runat="server" Text='<%# Eval("RowDesc")%>'></asp:Label>
                        </ItemTemplate>

                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Khu vực">
                        <ItemTemplate>
                            <asp:Label ID="lbStoreGroup" runat="server" Text='<%# Eval("ProvinceNameDesc")%>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lbStoreGroup" runat="server" Text='<%# Eval("StoreGroup")%>' Visible="false"></asp:Label>
                            <asp:DropDownList ID="drpStoreGroup" runat="server" Width="100px">
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="drpStoreGroup" runat="server" Width="100px">
                            </asp:DropDownList>
                        </FooterTemplate>

                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Lọai giá">
                        <ItemTemplate>
                            <asp:Label ID="lbSalesPriceType" runat="server" Text='<%# Eval("SalePriceTypeNameDesc")%>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lbSalesPriceType" runat="server" Text='<%# Eval("SalesPriceId")%>' Visible="false"></asp:Label>
                            <asp:DropDownList ID="drpSalesPriceType" runat="server" Width="100px">
                            </asp:DropDownList>
                        </EditItemTemplate>

                        <FooterTemplate>
                            <asp:DropDownList ID="drpSalesPriceType" runat="server" Width="100px">
                            </asp:DropDownList>
                        </FooterTemplate>

                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Ðơn vị tính">
                        <ItemTemplate>
                            <asp:Label ID="lbUnit" runat="server" Text='<%# Eval("UnitNameDesc")%>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lbUnit" runat="server" Text='<%# Eval("UnitOfMeasureId")%>' Visible="false"></asp:Label>
                            <asp:DropDownList ID="drpUnit" runat="server" Width="100px">
                            </asp:DropDownList>
                        </EditItemTemplate>

                        <FooterTemplate>
                            <asp:DropDownList ID="drpUnit" runat="server" Width="100px">
                            </asp:DropDownList>
                        </FooterTemplate>

                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Ngày bắt đầu">
                        <ItemTemplate>
                            <asp:Label ID="lbStartingDate" runat="server" Text='<%#DateTime.Parse( Eval("StartingDate").ToString())==DateTime.MinValue?"": Eval("StartingDate", "{0:dd/MM/yyyy}" )%>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lbStartingDate" runat="server" Text='<%#DateTime.Parse( Eval("StartingDate").ToString())==DateTime.MinValue?"": Eval("StartingDate", "{0:dd/MM/yyyy}" )%>' Visible="false"></asp:Label>
                            <asp:TextBox ID="txtStartingDate" runat="server" Width="80px"></asp:TextBox>
                            <ajax:CalendarExtender ID="CalendarExtender6" runat="server" TargetControlID="txtStartingDate"
                                Format="dd/MM/yyyy" Enabled="True">
                            </ajax:CalendarExtender>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtStartingDate" runat="server" Width="80px"></asp:TextBox>
                            <ajax:CalendarExtender ID="CalendarExtender6" runat="server" TargetControlID="txtStartingDate"
                                Format="dd/MM/yyyy" Enabled="True">
                            </ajax:CalendarExtender>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Ngày kết thúc">
                        <ItemTemplate>
                            <asp:Label ID="lbEndingDate" runat="server" Text='<%#DateTime.Parse( Eval("EndingDate").ToString())==DateTime.MinValue?"": Eval("EndingDate", "{0:dd/MM/yyyy}" )%>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lbEndingDate" runat="server" Text='<%#DateTime.Parse( Eval("EndingDate").ToString())==DateTime.MinValue?"": Eval("EndingDate", "{0:dd/MM/yyyy}" )%>' Visible="false"></asp:Label>
                            <asp:TextBox ID="txtEndingDate" runat="server" Width="80px"></asp:TextBox>
                            <ajaxajaxcalendarextender id="calEndingDate" runat="server" targetcontrolid="txtEndingDate"
                                format="dd/MM/yyyy" enabled="True">
                            </ajaxajaxcalendarextender>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtEndingDate" runat="server" Width="80px"></asp:TextBox>
                            <ajax:CalendarExtender ID="calEndingDate" runat="server" TargetControlID="txtEndingDate"
                                Format="dd/MM/yyyy" Enabled="True">
                            </ajax:CalendarExtender>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Giá bán">
                        <ItemTemplate>
                            <asp:Label ID="lbUnitPrice" runat="server" Text='<%#  decimal.Parse(Eval("UnitPrice").ToString())==decimal.MinValue?"":Cb.Utility.FormatHelper.FormatDonviTinh(Cb.DBUtility.DBConvert.ParseDouble(Eval("UnitPrice").ToString()), Cb.Utility.enuCostId.dong, Ci)%>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lbUnitPrice" runat="server" Text='<%# decimal.Parse(Eval("UnitPrice").ToString())==decimal.MinValue?"":String.Format("{0:#,000}", Eval("UnitPrice"))%>' Visible="false"></asp:Label>
                            <asp:TextBox ID="txtUnitPrice" runat="server" Width="120px"></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtUnitPrice" runat="server" Width="120px"></asp:TextBox>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Giá khuyến mãi" >
                        <ItemTemplate>
                            <asp:Label ID="lbDealPrice" runat="server" Text='<%#  decimal.Parse(Eval("DealPrice").ToString())==decimal.MinValue?"":Cb.Utility.FormatHelper.FormatDonviTinh(Cb.DBUtility.DBConvert.ParseDouble( Eval("DealPrice").ToString()), Cb.Utility.enuCostId.dong, Ci)%>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lbDealPrice" runat="server" Text='<%# decimal.Parse(Eval("DealPrice").ToString())==decimal.MinValue?"":String.Format("{0:#,000}",Eval("DealPrice")) %>' Visible="false"></asp:Label>
                            <asp:TextBox ID="txtDealPrice" runat="server" Width="100px"></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtDealPrice" runat="server" Width="100px"></asp:TextBox>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:CommandField ShowEditButton="True" EditImageUrl="/Admin/images/edit.png" HeaderStyle-Width="200" ItemStyle-Width="200" 
                        UpdateImageUrl="/Admin/images/update-arrows.png" UpdateText="Update"
                        CancelImageUrl="/Admin/images/cancel.png" CancelText="Cancel"
                        ButtonType="Image" HeaderText="Edit"></asp:CommandField>

                    <asp:CommandField ShowDeleteButton="True" DeleteImageUrl="/Admin/images/thung-rac.png"
                        ButtonType="Image" HeaderText="Remove" />

                    <asp:TemplateField ItemStyle-Width="50px">
                        <FooterTemplate>
                            <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-primary btn-sm" OnClick="AddNew" />
                        </FooterTemplate>
                    </asp:TemplateField>

                </Columns>
                <AlternatingRowStyle BackColor="#C2D69B" />

            </asp:GridView>
        </ContentTemplate>
        <%-- <Triggers>
            <asp:AsyncPostBackTrigger ControlID="block_salesprice" />
        </Triggers>--%>
    </asp:UpdatePanel>

</div>

<script>
    $(document).ready(function () {
        $('.txtExpectedDepartureDate').datepicker();
    });

</script>
<!--/block_salesprice-->


