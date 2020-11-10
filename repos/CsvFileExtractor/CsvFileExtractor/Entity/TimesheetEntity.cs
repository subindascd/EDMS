using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace CsvFileExtractor.Entity
{
    public class TimesheetEntity
    {
        
        public int Id { get; set; }
        public int ProjectId { get; set; }
        public int EmpId { get; set; }
        [Column(TypeName = "Date")]
        public DateTime TimesheeetDate { get; set; }
        [Column(TypeName = "decimal(2,1)")]
        public decimal TimesheetHour { get; set; }
        public int UserID { get; set; }

        public bool IsOff { get; set; }

        public bool IsHalfday { get; set; }

        public DateTime CreatedDate { get; set; }
    }
}
