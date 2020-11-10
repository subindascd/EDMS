using AuthenticationService.Service.Domain;
using AuthenticationService.Service.JWTAuthentication.Interface;
using AuthenticationService.Service.ViewModel;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Security.Principal;
using System.Threading.Tasks;

 namespace AuthenticationService.Service.JWTAuthentication
{
    public  class JWTFactory:IJwtFactory
    {
        public JWTFactory()
        {

        }
        public  string LoginUser(User user)
        {
            
                //Authentication successful, Issue Token with user credentials 
                //Provide the security key which is given in 
                //Startup.cs ConfigureServices() method 
                var key = System.Text.Encoding.ASCII.GetBytes
                ("YourKey-2374-OFFKDI940NG7:56753253-tyuw-5769-0921-kfirox29zoxv");
                //Generate Token for user 
                var JWToken = new JwtSecurityToken(
                    issuer: "http://localhost:45092/",
                    audience: "http://localhost:45092/",
                    claims: GetUserClaims(user),
                    notBefore: new DateTimeOffset(DateTime.Now).DateTime,
                    expires: new DateTimeOffset(DateTime.Now.AddDays(1)).DateTime,
                    //Using HS256 Algorithm to encrypt Token  
                    signingCredentials: new SigningCredentials
                    (new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
                );
                var token = new JwtSecurityTokenHandler().WriteToken(JWToken);
                return token;
            
        }
        private  IEnumerable<Claim> GetUserClaims(User user)
        {
            IEnumerable<Claim> claims = new Claim[]
                    {
                    
                    new Claim("Det", user.UserID.ToString()),
                    new Claim("Det",user.EmpId.ToString()),
                    new Claim("Det", user.IsAdmin?"true":"false"),
                    };
            return claims;
        }
        public  JWTUserSettings GetUserJwtSetting(string token)
        {
            var handler = new JwtSecurityTokenHandler();
            var jsonToken = handler.ReadToken(token);
            var claims = ((JwtSecurityToken)jsonToken)?.Claims;
            var jwtUserSetting = claims?.Where(x => x.Type == "Det")?.Select(x => x.Value).ToList();

            if (jwtUserSetting==null)
                return null;
            var jwtSetting = new JWTUserSettings
            {
                userid = Convert.ToInt32(jwtUserSetting[0]),
                emplid = Convert.ToInt32(jwtUserSetting[1]),
                Isadmin = jwtUserSetting[2] == "true" ? true : false
            };
            return jwtSetting;
        }
    }


}

