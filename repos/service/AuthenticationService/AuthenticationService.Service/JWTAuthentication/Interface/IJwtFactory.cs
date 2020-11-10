using AuthenticationService.Service.Domain;
using AuthenticationService.Service.ViewModel;
using System;
using System.Collections.Generic;
using System.Text;

namespace AuthenticationService.Service.JWTAuthentication.Interface
{
    public interface IJwtFactory
    {
        public string LoginUser(User user);
        public JWTUserSettings GetUserJwtSetting(string token);
    }
}
