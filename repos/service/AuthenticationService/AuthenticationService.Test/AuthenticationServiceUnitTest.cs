using AuthenticationService.API.Controllers;
using AuthenticationService.Data.Context;
using AuthenticationService.Data.Entity;
using AuthenticationService.Service;
using AuthenticationService.Service.Domain;
using AuthenticationService.Service.Interface;
using AuthenticationService.Service.JWTAuthentication.Interface;
using AuthenticationService.Service.ViewModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Moq;
using System;
using System.Collections.Generic;
using Xunit;
namespace AuthenticationService.Test
{

    public class AuthenticationServiceUnitTest
    {
        private Mock<AuthContext> _authcontext;
        private Mock<UserProfilesEntity> _userProfile;
        private AuthService _authService;
        protected IHttpContextAccessor _contextAccessor;
        public Mock<IJwtFactory> jwtFactoryMock = null;
        public DbContextOptions<AuthContext> ConfigureAuthenticationServiceTest()
        {
            var options = new DbContextOptionsBuilder<AuthContext>()
            .UseInMemoryDatabase(databaseName: "AuthDB")
            .Options;

            return options;

        }
        public AuthService CreateServiceInstance(AuthContext context )
        {
            var httpContext = new DefaultHttpContext();
            _contextAccessor = new HttpContextAccessor();
            _contextAccessor.HttpContext = httpContext;
            jwtFactoryMock = new Mock<IJwtFactory>();
            var service = new AuthService(context, _contextAccessor, jwtFactoryMock.Object);
           
            return service;
        }
        [Fact]
        public void AuthenticationSucess()
        {
           
            var options=ConfigureAuthenticationServiceTest();
            using (var context = new AuthContext(options))
            {
                context.UserProfile.Add(new UserProfilesEntity {UserID=1,UserKey="TEST",FirstName="TEST",LastName="TEST",Password="PASS"});
                context.SaveChanges();
            }

            using (var context = new AuthContext(options))
            {
                var service = CreateServiceInstance(context);
                var _user = service.Authenticate(new UserAuthenticateRequest { Password = "PASS", UserKey = "TEST" });

                Assert.Equal("TEST", _user.Result.FirstName);
            }
           

        }
        [Fact]
        public void AuthenticationFail()
        {

            var options = ConfigureAuthenticationServiceTest();

            using (var context = new AuthContext(options))
            {
                context.UserProfile.Add(new UserProfilesEntity { UserID = 2, UserKey = "TEST1", FirstName = "TEST1", LastName = "TEST1", Password = "PASS" });
                context.SaveChanges();
            }
            using (var context = new AuthContext(options))
            {
                var service = CreateServiceInstance(context);
                var _user = service.Authenticate(new UserAuthenticateRequest { Password = "pass", UserKey = "test" });
                Assert.Null(_user.Result);
            }

        }
        [Fact]
        public void GetUserDashboardAdminSuccess()
        {
            var options = ConfigureAuthenticationServiceTest();
            DateTime d = Convert.ToDateTime("2020-10-09");
            using (var context = new AuthContext(options))
            {
                context.Timesheet.Add(new TimesheetEntity { Id = 1, IsHalfday = false, IsOff = false, TimesheeetDate = d, TimesheetHour = 8, UserID = 4 });
                context.Timesheet.Add(new TimesheetEntity { Id = 2, IsHalfday = false, IsOff = false, TimesheeetDate = d, TimesheetHour = 8, UserID = 5 });
                context.UserProfile.Add(new UserProfilesEntity { UserID = 3, UserKey = "TEST1", FirstName = "TEST1", LastName = "TEST1", Password = "PASS" });
                context.UserProfile.Add(new UserProfilesEntity { UserID = 4, UserKey = "TEST1", FirstName = "TEST1", LastName = "TEST1", Password = "PASS" });
                context.UserProfile.Add(new UserProfilesEntity { UserID = 5, UserKey = "TEST1", FirstName = "TEST1", LastName = "TEST1", Password = "PASS" });
                context.SaveChanges();
            }
            using (var context = new AuthContext(options))
            {
                var jwtUserSetting = new JWTUserSettings
                {
                    emplid = 200,
                    Isadmin = true,
                    userid = 1
                };
                jwtFactoryMock = new Mock<IJwtFactory>();
                
                jwtFactoryMock.Setup(x => x.GetUserJwtSetting(It.IsAny<string>()))
              .Returns(jwtUserSetting);
                jwtFactoryMock.Setup(x => x.GetUserJwtSetting(It.IsAny<string>()))
              .Returns(new JWTUserSettings() { 
                userid=1,
                emplid=200,
                Isadmin=true
              });

                var service = CreateServiceInstance(context);
                
                var _user = service.GetUserDashboard(10);
                Assert.NotNull(_user.Result);
            }

        }
        
        public void GetUserDashboardMemberSuccess()
        {
            var options = ConfigureAuthenticationServiceTest();
            DateTime d = Convert.ToDateTime("2020-10-09");
            using (var context = new AuthContext(options))
            {
                context.Timesheet.Add(new TimesheetEntity { Id = 3, IsHalfday = false, IsOff = false, TimesheeetDate = d, TimesheetHour = 8, UserID = 6 });
                context.Timesheet.Add(new TimesheetEntity { Id = 4, IsHalfday = false, IsOff = false, TimesheeetDate = d, TimesheetHour = 8, UserID = 7 });
                context.UserProfile.Add(new UserProfilesEntity { UserID = 6, UserKey = "TEST1", FirstName = "TEST1", LastName = "TEST1", Password = "PASS" });
                context.UserProfile.Add(new UserProfilesEntity { UserID = 7, UserKey = "TEST1", FirstName = "TEST1", LastName = "TEST1", Password = "PASS" });
                context.UserProfile.Add(new UserProfilesEntity { UserID = 8, UserKey = "TEST1", FirstName = "TEST1", LastName = "TEST1", Password = "PASS" });
                context.SaveChanges();
            }
            using (var context = new AuthContext(options))
            {
                var service = CreateServiceInstance(context);
                var _user = service.GetUserDashboard(10);
                Assert.Equal(1,_user.Result.Count);
            }

        }
        
        public void GetUserDashboardUserReturnZeroRows()
        {
            var options = ConfigureAuthenticationServiceTest();
            DateTime d = Convert.ToDateTime("2020-10-09");
            
            using (var context = new AuthContext(options))
            {
                var service = CreateServiceInstance(context);
                var _user = service.GetUserDashboard(10);
                Assert.Equal(0, _user.Result.Count);
            }

        }
        [Fact]
        public void ApplyLeaveSuccess()
        {
            var options = ConfigureAuthenticationServiceTest();
            DateTime d = Convert.ToDateTime("2020-10-09");
            Leave _req = new Leave
            {
                date = "2020-10-09",
                isHafday = false,
                userid = 1
            };
            using (var context = new AuthContext(options))
            {
                var service = CreateServiceInstance(context);
                var _user = service.ApplyLeave(_req);
                Assert.Equal("true",_user.Result);
            }

        }
        [Fact]
        public void GetHolidaySuccess()
        {
            var options = ConfigureAuthenticationServiceTest();
            DateTime d = Convert.ToDateTime("2020-10-09");
            using (var context = new AuthContext(options))
            {
                context.Holiday.Add(new HolidayEntity { date=10,ID=1,month=10});
                
                context.SaveChanges();
            }
            using (var context = new AuthContext(options))
            {
                var service = CreateServiceInstance(context);
                var _user = service.GetHolidayForMonth(10);
                Assert.Equal(1, _user.Count);
            }
        }
        [Fact]
        public void GetHolidayReturnZeroRow()
        {
            var options = ConfigureAuthenticationServiceTest();
            DateTime d = Convert.ToDateTime("2020-10-09");
            using (var context = new AuthContext(options))
            {
                context.Holiday.Add(new HolidayEntity { date = 10, ID = 2, month = 10 });

                context.SaveChanges();
            }
            using (var context = new AuthContext(options))
            {
                var service = CreateServiceInstance(context);
                var _user = service.GetHolidayForMonth(11);
                Assert.Equal(0, _user.Count);
            }
        }


    }
}
