using CsvFileExtractor.Entity;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace CsvFileExtractor
{
    public class FileProcessing
    {
        string _filename = "";
        SQLFactory sql = new SQLFactory();
        List<TimesheetEntity> timeAdd = new List<TimesheetEntity>();
        List<TimesheetEntity> timeupd = new List<TimesheetEntity>();
        public FileProcessing(string filename)
        {
            _filename = filename;
        }
        public bool ExtractFromCsv()
        {
            var lines = File.ReadLines(_filename);
            List<UserProfilesEntity> _userAdd=new List<UserProfilesEntity>();
            List<UserProfilesEntity> _userUpdate= new List<UserProfilesEntity>() ;
            
            foreach (var line in lines)
            {
                var values = line.Split(',');
                if (values[0] == "Empid")
                    continue;
                
                AddorUpdateTimehseet(values);
            }
            
            if(timeupd.Count>0)
            sql.AddOrUpdateUserTime(timeupd, true);
            if(timeAdd.Count>0)
            sql.AddOrUpdateUserTime(timeAdd, false);
            return true;
        }
        public void AddorUpdateTimehseet(string[] line)
        {
            int empid = Convert.ToInt32(line[0]);
            string date =line[3];
            decimal hour = Convert.ToDecimal(line[4]);
            bool isleave = line[5]=="0"?false:true;
            bool isHalfday = line[6]=="0"?false:true;
            var time = sql.GetTimesheetUser(empid, date);
            if(time.Count>0)
            {
                var _timeupd = new TimesheetEntity()
                {
                    EmpId = empid,
                    TimesheeetDate = Convert.ToDateTime(date),
                    TimesheetHour = hour,
                    IsHalfday = isHalfday,
                    IsOff = isleave,
                    ProjectId = 1,
                    UserID = time[0].UserID,
                    CreatedDate = DateTime.Now,
                    Id=time[0].Id

                };
                timeupd.Add(_timeupd);
            }
            else
            {
                var _timeAdd = new TimesheetEntity()
                {
                    EmpId = empid,
                    TimesheeetDate = DateTime.Parse(date),
                    TimesheetHour = hour,
                    IsHalfday = isHalfday,
                    IsOff = isleave,
                    ProjectId = 1,
                    CreatedDate = DateTime.Now

                };
                timeAdd.Add(_timeAdd);
            }

        }

    }
}
