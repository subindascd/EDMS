using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EDMS.Models
{
    public class Leave
    {
        public int userid { get; set; }
        public string date { get; set; }
        public bool isHafday { get; set; }
    }
}
