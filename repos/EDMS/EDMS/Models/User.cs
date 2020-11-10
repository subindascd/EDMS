using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EDMS.Models
{
    
    public class Result
    {
        public User result { get; set; }
    }
    public class User
    {
        
        public int userID { get; set; }
        
        public string firstName { get; set; }
       
        public string userKey { get; set; }
        
        public string lastName { get; set; }

        public bool isAdmin { get; set; }
        public string Token { get; set; }

        public int empID { get; set; }

    }
    public enum Month
    {
        Jan,
        February,
        March,
        April,
        May,
        June,
        July,
        August,
        September,
        October,
        November,
        December,
    }

}
