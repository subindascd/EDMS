using System;
using System.Collections.Generic;
using System.Text;

namespace AuthenticationService.Service.ViewModel
{
    public class User
    {
        public int UserID { get; set; }
        public string FirstName { get; set; }
        public string UserKey { get; set; }
        public string LastName { get; set; }

        public bool IsAdmin { get; set; }
        public string Token { get; set; }
        public int EmpId { get; set; }
    }
}
