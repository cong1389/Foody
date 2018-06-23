using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cb.Model.Products;

namespace Cb.Model.CardProduct
{
    public class PNK_CartProduct
    {
        #region fields
        private int id;
        private int cartId;
        private int productId;
        private int quantity;
        private double price;
        private int providerId;
        private string nameDesc;
        private string imageDesc;
        
        private string productCategoryDesc;

        #endregion

        #region properties
        public int Id
        {
            get { return this.id; }
            set { this.id = value; }
        }
        public int CartId
        {
            get { return this.cartId; }
            set { this.cartId = value; }
        }
        public int ProductId
        {
            get { return this.productId; }
            set { this.productId = value; }
        }
        public int Quantity
        {
            get { return this.quantity; }
            set { this.quantity = value; }
        }
        public double Price
        {
            get { return this.price; }
            set { this.price = value; }
        }
        public int ProviderId
        {
            get { return this.providerId; }
            set { this.providerId = value; }
        }

        public string NameDesc
        {
            get { return nameDesc; }
            set { nameDesc = value; }
        }

        public string ImageDesc
        {
            get { return imageDesc; }
            set { imageDesc = value; }
        }
        public string ProductCategoryDesc
        {
            get { return productCategoryDesc; }
            set { productCategoryDesc = value; }
        }
        #endregion

        #region constructor
        public PNK_CartProduct()
        {
            this.id = int.MinValue;
            this.cartId = int.MinValue;
            this.productId = int.MinValue;
            this.quantity = int.MinValue;
            this.price = double.MinValue;
            this.providerId = int.MinValue;
        }
        public PNK_CartProduct(int id,
                    int cartId,
                    int productId,
                    int quantity,
                    double price,
                    int providerId)
        {
            this.id = id;
            this.cartId = cartId;
            this.productId = productId;
            this.quantity = quantity;
            this.price = price;
            this.providerId = providerId;
        }
        #endregion
    }
}
