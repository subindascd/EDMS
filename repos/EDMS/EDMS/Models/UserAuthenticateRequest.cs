using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;


namespace EDMS.Models
{
    
    public class UserAuthenticateRequest
    {
        /// <summary>
        /// Gets the user key of the user.
        /// </summary>
        [Required]
        public string UserKey { get; set; }

        /// <summary>
        /// Gets the user password
        /// </summary>
        [Required]
        public string Password { get; set; }
    }
    
}
