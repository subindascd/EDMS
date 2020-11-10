using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace EDMS.Models
{
    public class DashboardDetails
    {
       public List<UserDetails> users { get; set; }
    }
    public class UserDetails
    {
        public string Username { get; set; }
        public int UserID { get; set; }

        public string UserKey { get; set; }
        public decimal expectedTime { get; set; }
        public decimal completedTime { get; set; }
        public List<TimeEntry> timeEntries { get; set; }
    }
    public class TimeEntry
    {
        [Column(TypeName = "Date")]
        public DateTime date { get; set; }
        public decimal hours { get; set; }
        public bool IsOff { get; set; }
        public bool IsHalfday { get; set; }

    }
}
