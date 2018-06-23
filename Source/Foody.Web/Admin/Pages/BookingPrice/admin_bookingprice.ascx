<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin_bookingprice.ascx.cs" Inherits="Cb.Web.Admin.Pages.BookingPrice.admin_bookingprice" %>

<!--BookingPrice-->

<div id="dvGrid" style="padding: 10px; width: 550px">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:GridView ID="grdBookingPrice"
                runat="server"
                AutoGenerateColumns="False"
                AutoGenerateEditButton="false"
                AllowPaging="True"
                AllowSorting="True"
                ShowFooter="True"
                OnRowEditing="grdBookingPrice_RowEditing"
                OnRowUpdating="grdBookingPrice_RowUpdating"
                OnPageIndexChanging="grdBookingPrice_PageIndexChanging"
                OnRowCancelingEdit="grdBookingPrice_RowCancelingEdit"
                OnRowDeleting="grdBookingPrice_RowDeleted"
                OnRowDataBound="grdBookingPrice_RowDataBound"
                OnDataBound="grdBookingPrice_DataBound"
                PagerStyle-CssClass="bs-pagination"
                ShowHeaderWhenEmpty="True"
                EmptyDataText="No Records Found"
                CssClass="table table-bordered table-hover"
                DataKeyNames="ID">
                <Columns>

                    <asp:TemplateField ItemStyle-Width="30px" HeaderText="ID" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lbID" runat="server" Text='<%# Eval("ID")%>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtID" Width="40px" MaxLength="5" runat="server"></asp:TextBox>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Price class">
                        <ItemTemplate>
                            <asp:Label ID="lbPriceClass" runat="server" Text='<%# Eval("PriceClass")%>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPriceClass" Width="150px" Text='<%# Eval("PriceClass")%>' CssClass="txt" runat="server" />
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtPriceClass" Width="150px" runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtPriceClass" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="Name field is required." ValidationGroup="InsertBookingPrice" />
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Name">
                        <ItemTemplate>
                            <asp:Label ID="lbName" runat="server" Text='<%# Eval("Name")%>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtName" Width="150px" Text='<%# Eval("Name")%>' CssClass="txt" runat="server" />
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtName" Width="150px" runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtName" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="Name field is required." ValidationGroup="InsertBookingPrice" />
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Min">
                        <ItemTemplate>
                            <asp:Label ID="lbMin" runat="server" Text='<%# Eval("Min")%>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtMin" Width="100px" Text='<%# Eval("Min")%>' CssClass="txt" runat="server" />
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtMin" Width="100px" runat="server" />
                            <asp:RequiredFieldValidator ID="reqtxtMin" runat="server" ControlToValidate="txtMin" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="Min field is required." ValidationGroup="InsertBookingPrice" />
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Max">
                        <ItemTemplate>
                            <asp:Label ID="lbMax" runat="server" Text='<%# Eval("Max")%>'></asp:Label>
                        </ItemTemplate>

                        <EditItemTemplate>
                            <asp:TextBox ID="txtMax" runat="server" Text='<%# Eval("Max")%>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqTxtMax" runat="server" ControlToValidate="txtMax" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="Max field is required." ValidationGroup="EditBookingPrice" />
                        </EditItemTemplate>

                        <FooterTemplate>
                            <asp:TextBox ID="txtMax" Width="100px" runat="server" />
                            <asp:RequiredFieldValidator ID="reqTxtMax" runat="server" ControlToValidate="txtMax" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="Max field is required." ValidationGroup="InsertBookingPrice" />
                        </FooterTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Value">
                        <ItemTemplate>
                            <asp:Label ID="lbValue" runat="server" Text='<%# Eval("Value")%>'></asp:Label>
                        </ItemTemplate>

                        <EditItemTemplate>
                            <asp:TextBox ID="txtValue" runat="server" Text='<%# Eval("Value")%>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtValue" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="Value field is required." ValidationGroup="EditBookingPrice" />
                            <asp:RegularExpressionValidator ID="regv_txtValue" ControlToValidate="txtValue" runat="server" CssClass="text-danger"
                                Display="Dynamic" ErrorMessage="Only numbers allowed." ValidationExpression="^[-]?\d*\.?\d*$"
                                ValidationGroup="EditBookingPrice"></asp:RegularExpressionValidator>
                        </EditItemTemplate>

                        <FooterTemplate>
                            <asp:TextBox ID="txtValue" Width="100px" runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtValue" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="Value field is required." ValidationGroup="InsertBookingPrice" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="txtValue" runat="server" CssClass="text-danger" Display="Dynamic"
                                ErrorMessage="Only numbers allowed." ValidationExpression="^[-]?\d*\.?\d*$"
                                ValidationGroup="InsertBookingPrice"></asp:RegularExpressionValidator>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Tour group">
                        <ItemTemplate>
                            <asp:Label ID="lbGroupType" runat="server" Text='<%# Eval("GroupType")%>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lbGroupType" runat="server" Text='<%# Eval("GroupType")%>' Visible="false"></asp:Label>
                            <asp:DropDownList ID="drpGroupType" runat="server" Width="100px">
                            </asp:DropDownList>
                        </EditItemTemplate>

                        <FooterTemplate>
                            <asp:Label ID="lbGroupType" runat="server" Text='<%# Eval("GroupType")%>' Visible="false"></asp:Label>
                            <asp:DropDownList ID="drpGroupType" runat="server" Width="100px">
                            </asp:DropDownList>
                        </FooterTemplate>

                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Published">
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="chkPublished" Enabled="false" Checked='<%# (Eval("Published").ToString() == "1" ? true : false) %>' Width="100px"/>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox runat="server" ID="chkPublished" Enabled="true" Checked='<%# (Eval("Published").ToString()=="1"?true:false) %>' Width="100px"/>
                        </EditItemTemplate>

                        <FooterTemplate>
                            <asp:CheckBox runat="server" ID="chkPublished" Width="100px"/>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Published">
                        <ItemTemplate>
                            <asp:Literal runat="server" ID="ltrSort"></asp:Literal>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Literal runat="server" ID="ltrSort"></asp:Literal>
                        </EditItemTemplate>

                        <FooterTemplate>
                             <asp:Literal runat="server" ID="ltrSort"></asp:Literal>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:CommandField ShowEditButton="True" ValidationGroup="EditBookingPrice" EditImageUrl="/Admin/images/edit.png"
                        UpdateImageUrl="/Admin/images/update-arrows.png" UpdateText="Update"
                        CancelImageUrl="/Admin/images/cancel.png" CancelText="Cancel"
                        ButtonType="Image" HeaderText="Edit"></asp:CommandField>

                    <asp:CommandField ShowDeleteButton="True" DeleteImageUrl="/Admin/images/thung-rac.png"
                        ButtonType="Image" HeaderText="Remove" />

                    <asp:TemplateField ItemStyle-Width="50px">
                        <FooterTemplate>
                            <asp:Button ID="btnAdd" runat="server" Text="Add" ValidationGroup="InsertBookingPrice" CssClass="btn btn-primary btn-sm"
                                OnClick="AddNew" />
                        </FooterTemplate>
                    </asp:TemplateField>

                </Columns>
                <AlternatingRowStyle BackColor="#C2D69B" />

            </asp:GridView>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="grdBookingPrice" />
        </Triggers>
    </asp:UpdatePanel>

</div>

<!--/BookingPrice-->
