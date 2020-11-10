using System;
using System.Collections.Generic;
using System.Text;

namespace AuthenticationService.Data.Entity
{
    public class ProjectAllocationEntity
    {
        public int ID { get; set; }

        public int ProjectId { get; set; }
        public int UserId { get; set; }
        public bool Isdeleted { get; set; }


    }
}
