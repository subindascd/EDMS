using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Text;
using CsvFileExtractor.Entity;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace CsvFileExtractor
{
    public class SQLFactory
    {
        public SQLFactory()
        {

        }
        
       
        public List<TimesheetEntity> GetTimesheetUser(int empid,string date)
        {
            
            using (var context = new AuthContext())
            {
                var userTime = context.Timesheet.Where(x => x.EmpId == empid&&x.TimesheeetDate==DateTime.Parse(date) ).ToList();
                return userTime;
            }
        }
        public void AddOrUpdateUserTime(List<TimesheetEntity> timesheet, bool IsUpdate)
        {
            using (var context = new AuthContext())
            {

                foreach (var time in timesheet)
                {
                    if (IsUpdate)
                    {
                       
                        context.Timesheet.Update(time);
                        context.Entry(time).State= EntityState.Modified;
                    }
                    else
                        context.Timesheet.Add(time);

                    context.SaveChanges();


                }
            }
        }

    }
}
