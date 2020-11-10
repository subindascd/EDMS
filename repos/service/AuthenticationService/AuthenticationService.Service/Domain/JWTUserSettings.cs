using System;
using System.Collections.Generic;
using System.Text;

namespace AuthenticationService.Service.Domain
{
    public class JWTUserSettings
    {
       public int emplid { get; set; }
       public bool Isadmin { get; set; }
        public int userid { get; set; }
    }
}
