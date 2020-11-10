using System;
using System.Collections.Generic;
using System.Text;

namespace AuthenticationService.Service.JWTAuthentication.Model
{
    class JWTUserSetting
    {
        
           
            public string UserId { get; set; }
            public string UserKey { get; set; }
           public string UserRole { get; set; }

        
    }
}
