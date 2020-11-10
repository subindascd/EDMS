using System;
using System.Collections.Generic;
using System.Text;
using AuthenticationService.Service.Domain;
using AuthenticationService.Service.ViewModel;
using System.Threading.Tasks;
using System.Linq;

namespace AuthenticationService.Service.Interface
{
    public interface IAuthenticationService
    {
        public  Task<User> Authenticate(UserAuthenticateRequest userAuthenticateRequest);

        public Task<List<UserDetails>> GetUserDashboard(int month);

        public Task<string> ApplyLeave(Leave _leave);

        public List<int> GetHolidayForMonth(int month);
        public  Task<bool> SendMail(List<string> list);

    }
}
