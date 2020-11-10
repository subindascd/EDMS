using AuthenticationService.API.Controllers;
using AuthenticationService.Service.Domain;
using AuthenticationService.Service.Interface;
using AuthenticationService.Service.ViewModel;
using Microsoft.AspNetCore.Mvc;
using Moq;
using System;
using System.Collections.Generic;
using Xunit;

namespace AuthenticationService.Test
{
    public class AuthenticationControllerTest
    {
        private AuthenticationController _AuthController;
        private Mock<IAuthenticationService> _authenticationService;
        
        public AuthenticationControllerTest() { }

        public void ConfigureAuthenticationControllerTest()
        {
            _authenticationService = new Mock<IAuthenticationService>();

            _AuthController = new AuthenticationController(_authenticationService.Object);
        }
        [Fact]
        public void AuthenticatecalledOk()
        {
            ConfigureAuthenticationControllerTest();
            var req = new UserAuthenticateRequest
            {
                UserKey = "test@test.com",
                Password = "123"
            };
            //var guid = Guid.NewGuid().ToString();
            _authenticationService.Setup(x => x.Authenticate(req)).ReturnsAsync(new User());

            var result = _AuthController.Authenticate(req);
            var okResult = result as OkObjectResult;
            Assert.Equal(200, okResult.StatusCode);
        }
        [Fact]
        public void AuthenticateFail()
        {
            ConfigureAuthenticationControllerTest();
            var req = new UserAuthenticateRequest
            {
                UserKey = "test@test.com",
                Password = "123"
            };
            //var guid = Guid.NewGuid().ToString();
            _authenticationService.Setup(x => x.Authenticate(req)).ThrowsAsync(new Exception());

            var result = _AuthController.Authenticate(req);
            var fail = result as BadRequestObjectResult;
            Assert.Equal(400, fail.StatusCode);
        }
        [Fact]
        public void GetUserDashBoardOk()
        {
            ConfigureAuthenticationControllerTest();
            
            _authenticationService.Setup(x => x.GetUserDashboard(10)).ReturnsAsync(new List<UserDetails>());

            var result = _AuthController.GetUserDashBoard(10);
            var okResult = result as OkObjectResult;
            Assert.Equal(200, okResult.StatusCode);
        }
        [Fact]
        public void GetUserDashBoardFail()
        {
            ConfigureAuthenticationControllerTest();
            _authenticationService.Setup(x => x.GetUserDashboard(10)).ThrowsAsync(new Exception());

            var result = _AuthController.GetUserDashBoard(10);
                       
            var fail = result as BadRequestObjectResult;
            Assert.Equal(400, fail.StatusCode);
        }
        [Fact]
        public void ApplyLeaveOk()
        {
            ConfigureAuthenticationControllerTest();
            var req = new Leave
            {
               date="10-10-2020",
               isHafday=false,
               userid=1
            };
            //var guid = Guid.NewGuid().ToString();
            _authenticationService.Setup(x => x.ApplyLeave(req)).ReturnsAsync("true");

            var result = _AuthController.ApplyLeave(req);
            var okResult = result as OkObjectResult;
            Assert.Equal(200, okResult.StatusCode);
        }
        [Fact]
        public void ApplyLeaveFail()
        {
            ConfigureAuthenticationControllerTest();
            var req = new Leave
            {
                date = "10-10-2020",
                isHafday = false,
                userid = 1
            };
            //var guid = Guid.NewGuid().ToString();
            _authenticationService.Setup(x => x.ApplyLeave(req)).ThrowsAsync(new Exception());

            var result = _AuthController.ApplyLeave(req);
            var fail = result as BadRequestObjectResult;
            Assert.Equal(400, fail.StatusCode);
        }
        [Fact]
        public void GetHolidayOk()
        {
            ConfigureAuthenticationControllerTest();

            //var guid = Guid.NewGuid().ToString();
            _authenticationService.Setup(x => x.GetHolidayForMonth(10)).Returns(new List<int>());

            var result = _AuthController.Holiday(10);
            var okResult = result as OkObjectResult;
            Assert.Equal(200, okResult.StatusCode);
        }
        [Fact]
        public void GetHolidayFail()
        {
            ConfigureAuthenticationControllerTest();
            _authenticationService.Setup(x => x.GetHolidayForMonth(10)).Throws(new Exception());

            var result = _AuthController.Holiday(10);

            var fail = result as BadRequestObjectResult;
            Assert.Equal(400, fail.StatusCode);
        }
        [Fact]
        public  async void SendmailOk()
        {
            ConfigureAuthenticationControllerTest();

           var req= new List<string>()
            {
                "test@test.com"
            };
            //var guid = Guid.NewGuid().ToString();
            _authenticationService.Setup(x => x.SendMail(req)).ReturnsAsync(true);

            var result = await _AuthController.SendMail(req);
            var okResult = result as OkObjectResult;
            Assert.Equal(200, okResult.StatusCode);
        }
        [Fact]
        public async void SendMailFail()
        {
            ConfigureAuthenticationControllerTest();
            var req = new List<string>()
            {
                "test@test.com"
            };
            //var guid = Guid.NewGuid().ToString();
            _authenticationService.Setup(x => x.SendMail(req)).ThrowsAsync(new Exception());

            var result = await _AuthController.SendMail(req);

            var fail = result as BadRequestObjectResult;
            Assert.Equal(400, fail.StatusCode);
        }
    }
}
