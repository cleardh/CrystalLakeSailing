using System;
using System.Collections.Generic;

namespace DKSail.Models
{
    public partial class Town
    {
        public string TownName { get; set; }
        public string ProvinceCode { get; set; }

        public Province ProvinceCodeNavigation { get; set; }
    }
}
