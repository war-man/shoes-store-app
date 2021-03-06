﻿using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoesStore.Models
{
    [Serializable]
    public class CartItem
    {
        public ProductView Product { get; set; }

        public int Quantity { get; set; }

        public double Size { get; set; }

        public List<double> SizeOther { get; set; }
    }
}