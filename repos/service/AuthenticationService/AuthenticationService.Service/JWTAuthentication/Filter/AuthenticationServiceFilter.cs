using AuthenticationService.Service.Domain;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Authorization;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Text;


namespace AuthenticationService.Service.JWTAuthentication.Filter
{
    public class AuthenticationServiceFilter : IAuthorizationFilter
    {
        public AuthenticationServiceFilter()
        {

        }
        private static bool HasAllowAnonymous(AuthorizationFilterContext context)
        {
            var filters = context.Filters;
            return filters.OfType<IAllowAnonymousFilter>().Any();
        }
        public void OnAuthorization(AuthorizationFilterContext context)
        {
            var name = ((Microsoft.AspNetCore.Mvc.Controllers.ControllerActionDescriptor)context.ActionDescriptor).ActionName;
            if (name == "Start" || name == "Authenticate")
                return;
            var token = context.HttpContext.Request.Headers["Authorization"];
            if (token.Count > 0)
                if (!ValidateToken(token))
                {
                    context.Result = new UnauthorizedResult();
                    return;
                }
                else
                    return;
            
            
        }
        public bool ValidateToken(string token)
        {
            token = token.Replace("Bearer ","");
            var key = System.Text.Encoding.ASCII.GetBytes
                ("YourKey-2374-OFFKDI940NG7:56753253-tyuw-5769-0921-kfirox29zoxv");
            SymmetricSecurityKey signingKey = new SymmetricSecurityKey(key);
            var tokenHandler = new JwtSecurityTokenHandler();

            var validationParameters = new TokenValidationParameters
            {
                ValidateIssuer = false,
                ValidIssuer = "test",

                ValidateAudience = false,
                ValidAudience = "",

                ValidateIssuerSigningKey = true,
                IssuerSigningKey = signingKey,

                RequireExpirationTime = true,
                ValidateLifetime = true,

                ClockSkew = TimeSpan.Zero
            };

            SecurityToken validatedToken;
            try
            {
                tokenHandler.ValidateToken(token, validationParameters, out validatedToken);
                
            }
            catch (Exception ex)
            {
                return false;
            }
            return validatedToken != null;
        }

        
    }
    }
