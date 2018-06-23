using Cb.BLL;
using Cb.DBUtility;
using Cb.Model;
using Cb.Model.Brand;
using Cb.Model.Division;
using Cb.Model.ProductGroup;
using Cb.Model.ProductType;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace Cb.Web.Common
{
    public static class BuildControl
    {
        static int total;

        /// <summary>
        /// Bind dropdownlist
        /// </summary>
        /// <param name="langId">Id ngôn ngữ</param>
        /// <param name="drp"></param>
        /// <param name="type">enum loại drp </param>
        /// <param name="isFirstRow">có cần thêm dòng đầu tiên không</param>
        /// <param name="emptyFirstRow">text dòng đầu</param>
        /// <param name="param">Biến điều kiện</param>
        public static void BuildDropDownList(int langId, DropDownList drp, Common.UtilityLocal.List type, bool isFirstRow, string emptyFirstRow, string param)
        {
            switch (type)
            {
                case Common.UtilityLocal.List.ProductDivision:
                    DivisionBLL divisionBLL = new DivisionBLL();
                    drp.Items.Clear();
                    if (isFirstRow)
                    {
                        drp.Items.Add(new ListItem(emptyFirstRow, "-1"));
                    }
                    IList<PNK_Division> lstDivision = divisionBLL.GetList(langId, string.Empty, string.Empty, string.Empty, 1, 999, out total);
                    if (lstDivision != null && lstDivision.Count > 0)
                    {
                        foreach (PNK_Division item in lstDivision)
                        {
                            drp.Items.Add(new ListItem(item.DivisionDesc.Title, DBConvert.ParseString(item.Id)));
                        }
                    }
                    break;

                case Common.UtilityLocal.List.ProductType:
                    ProductTypeBLL produtTypeBLL = new ProductTypeBLL();
                    drp.Items.Clear();
                    if (isFirstRow)
                    {
                        drp.Items.Add(new ListItem(emptyFirstRow, "-1"));
                    }

                    IList<PNK_ProductType> lstProductType = produtTypeBLL.GetList(langId, string.Empty, string.Empty, param, 1, 9999, out total);
                    if (lstProductType != null && lstProductType.Count > 0)
                    {
                        foreach (PNK_ProductType item in lstProductType)
                        {
                            drp.Items.Add(new ListItem(item.ProductTypeDesc.Title, DBConvert.ParseString(item.Id)));
                        }
                    }
                    break;

                case Common.UtilityLocal.List.ProductGroup:
                    ProductGroupBLL produtGroupBLL = new ProductGroupBLL();
                    drp.Items.Clear();
                    if (isFirstRow)
                    {
                        drp.Items.Add(new ListItem(emptyFirstRow, "-1"));
                    }

                    IList<PNK_ProductGroup> lstProductGroup = produtGroupBLL.GetList(langId, string.Empty, string.Empty, string.Empty, param, 1, 9999, out total);
                    if (lstProductGroup != null && lstProductGroup.Count > 0)
                    {
                        foreach (PNK_ProductGroup item in lstProductGroup)
                        {
                            drp.Items.Add(new ListItem(item.ProductGroupDesc.Title, DBConvert.ParseString(item.Id)));
                        }
                    }
                    break;

                //Hãng sản xuất
                case Common.UtilityLocal.List.Brand:
                    BrandBLL brandBLL = new BrandBLL();
                    drp.Items.Clear();
                    if (isFirstRow)
                    {
                        drp.Items.Add(new ListItem(emptyFirstRow, "-1"));
                    }
                    IList<PNK_Brand> lstBrand = brandBLL.GetList(langId, string.Empty, string.Empty, string.Empty, 1, 999, out total);
                    if (lstBrand != null && lstBrand.Count > 0)
                    {
                        foreach (PNK_Brand item in lstBrand)
                        {
                            drp.Items.Add(new ListItem(item.BrandDesc.Title, DBConvert.ParseString(item.Id)));
                        }
                    }
                    break;

                //Tỉnh
                case Common.UtilityLocal.List.Province:
                    ProvinceBLL provinceBLL = new ProvinceBLL();
                    drp.Items.Clear();
                    if (isFirstRow)
                    {
                        drp.Items.Add(new ListItem(emptyFirstRow, "-1"));
                    }
                    IList<PNK_Province> lstProvince = provinceBLL.GetProvinceAll();

                    if (lstProvince != null && lstProvince.Count > 0)
                    {
                        foreach (PNK_Province item in lstProvince)
                        {
                            drp.Items.Add(new ListItem(item.Name, DBConvert.ParseString(item.Id)));
                        }
                    }
                    break;

                //Đơn vị đo lường
                case Common.UtilityLocal.List.UnitMeasure:
                    UnitMeasureBLL unitMeasureBLL = new UnitMeasureBLL();
                    drp.Items.Clear();
                    if (isFirstRow)
                    {
                        drp.Items.Add(new ListItem(emptyFirstRow, "-1"));
                    }
                    IList<PNK_UnitMeasure> lstUnitMeasure = unitMeasureBLL.GetUnitMeasureAll();

                    if (lstUnitMeasure != null && lstUnitMeasure.Count > 0)
                    {
                        foreach (PNK_UnitMeasure item in lstUnitMeasure)
                        {
                            drp.Items.Add(new ListItem(item.Name, DBConvert.ParseString(item.Id)));
                        }
                    }
                    break;

                //Loại giá
                case Common.UtilityLocal.List.SalesPriceType:
                    SalesPriceTypeBLL salesPriceTypeBLL = new SalesPriceTypeBLL();
                    drp.Items.Clear();
                    if (isFirstRow)
                    {
                        drp.Items.Add(new ListItem(emptyFirstRow, "-1"));
                    }
                    IList<PNK_SalesPriceType> lstSalesPriceType = salesPriceTypeBLL.GetSalesPriceTypeAll();

                    if (lstSalesPriceType != null && lstSalesPriceType.Count > 0)
                    {
                        foreach (PNK_SalesPriceType item in lstSalesPriceType)
                        {
                            drp.Items.Add(new ListItem(item.Name, DBConvert.ParseString(item.Id)));
                        }
                    }
                    break;

                //VAT
                case Common.UtilityLocal.List.VatGroup:
                    VatGroupBLL vatGroupBLL = new VatGroupBLL();
                    drp.Items.Clear();
                    if (isFirstRow)
                    {
                        drp.Items.Add(new ListItem(emptyFirstRow, "-1"));
                    }
                    IList<PNK_VatGroup> lstVatGroup = vatGroupBLL.GetVatGroupAll();

                    if (lstVatGroup != null && lstVatGroup.Count > 0)
                    {
                        foreach (PNK_VatGroup item in lstVatGroup)
                        {
                            drp.Items.Add(new ListItem(item.Name, DBConvert.ParseString(item.Id)));
                        }
                    }
                    break;
            }
        }
    }
}