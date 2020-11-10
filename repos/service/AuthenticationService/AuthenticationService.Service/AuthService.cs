using System;
using System.Collections.Generic;
using System.Text;
using AuthenticationService.Data.Context;
using AuthenticationService.Service.Domain;
using AuthenticationService.Service.ViewModel;
using AuthenticationService.Service.Interface;
using System.Linq;
using System.Threading.Tasks;
using AuthenticationService.Data.Entity;
using System.Net.Mail;
using AuthenticationService.Service.JWTAuthentication;
using Microsoft.AspNetCore.Http;
using AuthenticationService.Service.JWTAuthentication.Interface;

namespace AuthenticationService.Service
{
    public class AuthService:IAuthenticationService
    {
        AuthContext _authContext = null;
        IHttpContextAccessor _httpContextAccessor;
        JWTUserSettings _jWTUserSettings = null;
        IJwtFactory _jwtFactory;
        public AuthService(AuthContext authContext, IHttpContextAccessor httpContextAccessor, IJwtFactory jwtFactory)
        {
            _authContext = authContext;
            _httpContextAccessor = httpContextAccessor;
            _jwtFactory = jwtFactory;
            var token = _httpContextAccessor.HttpContext.Request.Headers["Authorization"].ToString();
            token = token.Replace("Bearer ", "");
            if (token != "") 
            _jWTUserSettings = _jwtFactory.GetUserJwtSetting(token);
        }
        public async Task<User> Authenticate(UserAuthenticateRequest userAuthenticateRequest)
        {
            User _user=null;
            try
            {
                var user = _authContext.UserProfile.Where(x => x.UserKey == userAuthenticateRequest.UserKey && x.Password == userAuthenticateRequest.Password).FirstOrDefault();

                if (user == null)
                    return null;
                bool isAdmin = false;
                string role = "";
                var userRole = _authContext.UserRole.Where(x => x.UserID == user.UserID).FirstOrDefault();
                if (userRole != null)
                    role = _authContext.Role.Where(x => x.RoleID == userRole.RoleID).FirstOrDefault().RoleName;

                if (role == "Admin")
                    isAdmin = true;

                _user = new User()
                {
                    FirstName = user.FirstName,
                    LastName = user.LastName,
                    UserID = user.UserID,
                    UserKey = user.UserKey,
                    IsAdmin = isAdmin,
                    EmpId=user.EmpId
                    
                };
                _user.Token=_jwtFactory.LoginUser(_user);

                user.Token = _user.Token;
                _authContext.UserProfile.Update(user);
                _authContext.SaveChanges();
            }
            catch(Exception x)
            {

            }
            return _user;


        }
       
        public async Task<List<UserDetails>> GetUserDashboard(int month)
        {
            try
            {
                List<UserDetails> userDetails = new List<UserDetails>();
                List<UserProfilesEntity> _users;
                int userID = _jWTUserSettings.emplid;
                bool Isadmin = _jWTUserSettings.Isadmin;
                if (Isadmin == true)
                    _users = _authContext.UserProfile.ToList();
                else
                    _users = _authContext.UserProfile.Where(x => x.EmpId == userID).ToList();
                foreach (var user in _users)
                {
                    var test = _authContext.Timesheet.Where(x => x.EmpId == user.EmpId).Select(x => x.TimesheeetDate.Month);
                    var _timentry = _authContext.Timesheet.Where(x => x.EmpId == user.EmpId && x.TimesheeetDate.Month == month).ToList();
                    List<TimeEntry> _timesheet = new List<TimeEntry>();
                    decimal completedtime = 0;
                    foreach (var time in _timentry)
                    {
                        var _time = new TimeEntry
                        {
                            date = time.TimesheeetDate,
                            hours = time.TimesheetHour,
                            IsHalfday = time.IsHalfday,
                            IsOff = time.IsOff

                        };
                        //completedtime = completedtime + _time.hours;

                        _timesheet.Add(_time);
                    }

                    var _user = new UserDetails
                    {
                        Username = user.FirstName + " " + user.LastName,
                        UserID = user.EmpId,
                        UserKey = user.UserKey,
                        timeEntries = _timesheet.OrderBy(x => x.date).ToList()
                    };
                    userDetails.Add(_user);
                }


                return userDetails;
            }
            catch(Exception ex)
            {
                return null;
            }

        }

        public async Task<string> ApplyLeave(Leave _leave)
        {
            try
            {
                var leaveday = new TimesheetEntity
                {
                    UserID = _leave.userid,
                    IsOff = true,
                    TimesheeetDate = Convert.ToDateTime(_leave.date),
                    IsHalfday = _leave.isHafday,
                    CreatedDate = DateTime.Today,
                    ProjectId = 1,
                    TimesheetHour = _leave.isHafday?(decimal)3.25:0
                };
                var sucees = _authContext.Timesheet.Add(leaveday);
                _authContext.SaveChanges();
                return "true";
            }
            catch(Exception x)
            {
                return "false";
            }
        }
        public List<int> GetHolidayForMonth(int month)
        {
            try
            {
                var holiday = _authContext.Holiday.Where(x => x.month == month).Select(x => x.date).ToList();
                return holiday;
            }
            catch
            {
                return null;
            }
        }

        public async Task<bool> SendMail(List<string> list)
        {
            try
            {
                foreach (var u in list)
                {
                    if (u != "")
                    {
                        await SendEmail(u, "Please enter the time sheet details");
                    }
                }
                return true;
            }
            catch
            {
                return false;
            }
        }
        private async Task<bool> SendEmail(string to, string message)
        {
            try
            {
                using (SmtpClient client = new SmtpClient("smtp.gmail.com", 587))
                {
                    client.UseDefaultCredentials = false;
                    client.Credentials = new System.Net.NetworkCredential("dassubin@gmail.com", "Year@2020#$%");
                    MailMessage mailMessage = new MailMessage();
                    mailMessage.From = new MailAddress("dassubin@gamil.com");
                    mailMessage.BodyEncoding = Encoding.UTF8;
                    mailMessage.To.Add(to);
                    mailMessage.Body = message;
                    mailMessage.Subject = "Burned Effort";
                    mailMessage.IsBodyHtml = true;

                    client.EnableSsl = true;
                   await client.SendMailAsync(mailMessage);
                    return true;
                }
            }
            catch (Exception ex)
            {
                throw ex; ;
            }
        }
       
    }
}
