using System;
using System.Collections.Generic;
using System.Text;

namespace AuthenticationService.Data.Entity
{
    public class ProjectEntity
    {
        public int ProjectID { get; set; }
        public string ProjectCode { get; set; }
        public string ProjectName { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public int DailyLogHours { get; set; }

        

    }
}
