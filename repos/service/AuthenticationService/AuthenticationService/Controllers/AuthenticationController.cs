using System;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AuthenticationService.Service;
using AuthenticationService.Service.Domain;
using AuthenticationService.Service.Interface;
using AuthenticationService.Service.JWTAuthentication.Filter;
using Microsoft.AspNetCore.Cors;
using AuthenticationService.Service.JWTAuthentication.Attributes;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.Authorization;

namespace AuthenticationService.API.Controllers
{
    [Route("Auth")]
    [EnableCors("AllowCors")]
    [AuthenticationService]
    public class AuthenticationController:ControllerBase
    {
        IAuthenticationService _authenticationService = null;
        
        public AuthenticationController(IAuthenticationService authenticationService)
        {
            _authenticationService = authenticationService;
        }
        [HttpGet]
        [Route("Start")]
        [AllowAnonymous]
        public IActionResult Start()
        {
            return Ok("I am Up");
        }
        [HttpPost]
        [Route("Authenticate")]
        
        public IActionResult Authenticate([FromBody] UserAuthenticateRequest userAuthenticateRequest)
        {
            try
            {
                var authenticateResponse =  _authenticationService.Authenticate(userAuthenticateRequest);
                if(authenticateResponse.Result==null)
                    return new BadRequestObjectResult(authenticateResponse);
                return new OkObjectResult(authenticateResponse);
            }
            catch (Exception ex)
            {
                return new BadRequestObjectResult(ex);
            }
        }
        [HttpGet]
        [Route("Dashboard/{month}")]
       
        public IActionResult GetUserDashBoard(int month)
        {
            try
            {
                var dashboardResponse = _authenticationService.GetUserDashboard(month);
                if (dashboardResponse.Result == null)
                    return new BadRequestObjectResult(dashboardResponse);
                return new OkObjectResult(dashboardResponse);
            }
            catch (Exception ex)
            {
                return new BadRequestObjectResult(ex);
            }
        }
        [HttpPost]
        [Route("leave")]
        public IActionResult ApplyLeave([FromBody] Leave _leave)
        {
            try
            {
                var leaveResponse = _authenticationService.ApplyLeave(_leave);
                if (leaveResponse.Result == null)
                    return new BadRequestObjectResult(leaveResponse);
                return new OkObjectResult(leaveResponse);
            }
            catch (Exception ex)
            {
                return new BadRequestObjectResult(ex);
            }
        }
        [HttpGet]
        [Route("holiday/{month}")]
        public IActionResult Holiday(int month)
        {
            try
            {
                var leaveResponse = _authenticationService.GetHolidayForMonth(month);
                if (leaveResponse == null)
                    return new BadRequestObjectResult(leaveResponse);
                return new OkObjectResult(leaveResponse);
            }
            catch (Exception ex)
            {
                return new BadRequestObjectResult(ex);
            }
        }
        [HttpPost]
        [Route("sendmail")]
        public async Task<IActionResult> SendMail([FromBody] List<string> list )
        {
            try
            {
                var leaveResponse = await _authenticationService.SendMail(list);
                if (leaveResponse == true)
                    return Ok("Mail Send Successfully");
                return NotFound("Mail not Send");
            }
            catch (Exception ex)
            {
                return new BadRequestObjectResult(ex);
            }
        }

    }
}
