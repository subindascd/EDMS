using System;
using System.Collections.Generic;
using System.Text;

namespace AuthenticationService.Service.Domain
{
    public class Leave
    {
        public int userid { get; set; }
        public string date { get; set; }
        public bool isHafday { get; set; }
    }
}
