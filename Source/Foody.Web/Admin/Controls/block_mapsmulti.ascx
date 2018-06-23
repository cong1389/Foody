<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="block_mapsmulti.ascx.cs" Inherits="Cb.Web.Admin.Controls.block_mapsmulti" %>

<!--block_mapsmulti-->

<div id="dvGrid" style="padding: 10px; width: 550px">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:GridView ID="grdMultiMaps"
                runat="server"
                AutoGenerateColumns="False"
                AutoGenerateEditButton="false"
                AllowPaging="True"
                AllowSorting="True"
                ShowFooter="True"
                OnRowEditing="grdMultiMaps_RowEditing"
                OnRowUpdating="grdMultiMaps_RowUpdating"
                OnPageIndexChanging="grdMultiMaps_PageIndexChanging"
                OnRowCancelingEdit="grdMultiMaps_RowCancelingEdit"
                OnRowDeleting="grdMultiMaps_RowDeleted"
                PagerStyle-CssClass="bs-pagination"
                ShowHeaderWhenEmpty="True"
                EmptyDataText="No Records Found"
                CssClass="table table-bordered table-hover tbl-news"
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

                    <asp:TemplateField HeaderText="Name">
                        <ItemTemplate>
                            <asp:Label ID="lbName" runat="server" Text='<%# Eval("Name")%>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtName" Width="400px" Text='<%# Eval("Name")%>' CssClass="txt" runat="server" />
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtName" Width="400px" runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtName" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="Name field is required." ValidationGroup="Insert" />
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Latitude">
                        <ItemTemplate>
                            <asp:Label ID="lbLatitude" runat="server" Text='<%# Eval("Latitude")%>'></asp:Label>
                        </ItemTemplate>

                        <EditItemTemplate>
                            <asp:TextBox ID="txtLatitude" runat="server" Text='<%# Eval("Latitude")%>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtLatitude" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="Latitude field is required." ValidationGroup="Edit" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtLatitude" runat="server" CssClass="text-danger"
                                Display="Dynamic" ErrorMessage="Only numbers allowed." ValidationExpression="^[-]?\d*\.?\d*$"
                                ValidationGroup="Edit"></asp:RegularExpressionValidator>
                        </EditItemTemplate>

                        <FooterTemplate>
                            <asp:TextBox ID="txtLatitude" Width="100px" runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLatitude" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="Latitude field is required." ValidationGroup="Insert" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="txtLatitude" runat="server" CssClass="text-danger" Display="Dynamic"
                                ErrorMessage="Only numbers allowed." ValidationExpression="^[-]?\d*\.?\d*$"
                                ValidationGroup="Insert"></asp:RegularExpressionValidator>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="LongiTude">
                        <ItemTemplate>
                            <asp:Label ID="lbLongiTude" runat="server" Text='<%# Eval("LongiTude")%>'></asp:Label>
                        </ItemTemplate>

                        <EditItemTemplate>
                            <asp:TextBox ID="txtLongiTude" runat="server" Text='<%# Eval("LongiTude")%>'></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLongiTude" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="LongiTude field is required." ValidationGroup="Edit" />
                            <asp:RegularExpressionValidator ControlToValidate="txtLongiTude" runat="server" CssClass="text-danger" Display="Dynamic"
                                ErrorMessage="Only numbers allowed." ValidationExpression="^[-]?\d*\.?\d*$"
                                ValidationGroup="Edit"></asp:RegularExpressionValidator>
                        </EditItemTemplate>

                        <FooterTemplate>
                            <asp:TextBox ID="txtLongiTude" Width="100px" runat="server" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLongiTude" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="LongiTude field is required." ValidationGroup="Insert" />
                            <asp:RegularExpressionValidator ControlToValidate="txtLongiTude" runat="server" CssClass="text-danger" Display="Dynamic"
                                ErrorMessage="Only numbers allowed." ValidationExpression="^[-]?\d*\.?\d*$"
                                ValidationGroup="Insert"></asp:RegularExpressionValidator>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:CommandField ShowEditButton="True" ValidationGroup="Edit" EditImageUrl="/Admin/images/edit.png"
                        UpdateImageUrl="/Admin/images/update-arrows.png" UpdateText="Update"
                        CancelImageUrl="/Admin/images/cancel.png" CancelText="Cancel"
                        ButtonType="Image" HeaderText="Edit"></asp:CommandField>

                    <asp:CommandField ShowDeleteButton="True" DeleteImageUrl="/Admin/images/thung-rac.png"
                        ButtonType="Image" HeaderText="Remove" />

                    <asp:TemplateField ItemStyle-Width="50px">
                        <%-- <ItemTemplate>
                            <asp:LinkButton ID="lnkRemove" runat="server" CommandArgument='<%# Bind("ID")%>'
                                OnClientClick="return confirm('Are you sure you want to delete this row?')" Text="Delete"
                                OnClick="grdMultiMaps_RowDeleted"></asp:LinkButton>
                        </ItemTemplate>--%>
                        <FooterTemplate>
                            <asp:Button ID="btnAdd" runat="server" Text="Add" ValidationGroup="Insert" CssClass="btn btn-primary btn-sm"
                                OnClick="AddNewCustomer" />
                        </FooterTemplate>
                    </asp:TemplateField>

                </Columns>
                <AlternatingRowStyle BackColor="#C2D69B" />

            </asp:GridView>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="grdMultiMaps" />
        </Triggers>
    </asp:UpdatePanel>

</div>
<!--/block_mapsmulti-->
