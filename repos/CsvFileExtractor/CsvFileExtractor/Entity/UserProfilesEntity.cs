using System;
using System.Collections.Generic;
using System.Text;

namespace CsvFileExtractor.Entity
{
    public class UserProfilesEntity
    {
        public int UserID { get; set; }
        public int EmpId { get; set; }
        public string FirstName { get; set; }
        public string UserKey { get; set; }
        public string LastName { get; set; }
        public string Password { get; set; }
        public bool IsDeleted { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public string Token { get; set; }
    }
}
