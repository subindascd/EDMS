using System;
using System.Collections.Generic;
using System.Text;

namespace AuthenticationService.Service.Domain
{
    public class UserAuthenticateRequest
    {
        
        public string UserKey { get; set; }

        
        public string Password { get; set; }
    }
}
