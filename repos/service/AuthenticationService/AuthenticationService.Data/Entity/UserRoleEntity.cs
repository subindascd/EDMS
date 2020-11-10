using System;
using System.Collections.Generic;
using System.Text;

namespace AuthenticationService.Data.Entity
{
    public class UserRoleEntity
    {
        public int UserRoleID { get; set; }
        public int UserID { get; set; }
        public int RoleID { get; set; }

        public bool Isdeleted { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }


    }
}
