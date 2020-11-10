using Microsoft.AspNetCore.Authorization;
using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;
using System.Web.Http.Controllers;

namespace AuthenticationService.Service.JWTAuthentication.Attributes
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, AllowMultiple = false)]
    public class AuthenticationServiceAttribute: Attribute
    {
        //private static bool SkipAuthorization(HttpActionContext actionContext)
        //{
        //    Contract.Assert(actionContext != null);

        //    return actionContext.ActionDescriptor.GetCustomAttributes<AllowAnonymousAttribute>().Any()
        //               || actionContext.ControllerContext.ControllerDescriptor.GetCustomAttributes<AllowAnonymousAttribute>().Any();
        //}

    }

}
