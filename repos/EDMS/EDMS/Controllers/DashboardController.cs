using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using EDMS.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Net.Mail;
using System.Net.Http.Headers;
//using Microsoft.Exchange.WebServices.Data;

namespace EDMS.Controllers
{
    public class DashboardController : Controller
    {
        [HttpGet]
        public async Task<string> DashboardDetails(string currentMonth)
        {
            try
            {
                ViewBag.Iscalled = 2;
                string csv = "";
                string csvdata = "";
                Month myEnum = (Month)Enum.Parse(typeof(Month), currentMonth);
                var monthNumber = (int)myEnum;
                monthNumber = monthNumber + 1;
                ViewBag.SelectedMonth = monthNumber;
                string strMonthNumber = "";
                if (monthNumber < 10)
                    strMonthNumber = "0" + monthNumber.ToString();
                else
                    strMonthNumber =  monthNumber.ToString();
                string month = "-" + strMonthNumber + "-" + DateTime.Today.Year.ToString();
                var content = (TempData["user"]) as string;
                TempData.Keep();
                User _user = JsonConvert.DeserializeObject<User>(content);
                using (HttpClient client = new HttpClient())
                {
                    var token = HttpContext.Request.Headers["Authorization"];
                    
                    client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
                    string endpoint = "https://localhost:44335/Auth/Dashboard/" + monthNumber.ToString();

                    int days = DateTime.DaysInMonth(DateTime.Today.Year, monthNumber);
                   
                    ViewBag.Current = month;
                    using (var Response = await client.GetAsync(endpoint))
                    {
                        if (Response.StatusCode == System.Net.HttpStatusCode.OK)
                        {

                            using (HttpContent _content = Response.Content)
                            {

                                Task<string> result = _content.ReadAsStringAsync();
                                string _dashboard = result.Result.Replace("result", "users");
                                DashboardDetails deserialized = JsonConvert.DeserializeObject<DashboardDetails>(_dashboard);

                                //_user = deserialized.result;
                                //TempData["user"] = JsonConvert.SerializeObject(_user);
                                //ViewBag.Name = _user.firstName + " " + _user.lastName;

                                var holiday = GetHolidayForMonth(monthNumber);
                                var users = deserialized.users;
                                TempData["DashBoardUser"]= _dashboard;
                               
                                int trcolorcount = 1;
                                string trcolor = "background-color: lemonchiffon;";
                                string color = "";
                                string table = "";
                                string head = "<tr><th></th><th>Name</th><th style='display:none'></th>";
                                csv = "Name,";
                                for (int k=1; k <= days; k++)
                                {
                                    if (k < 10)
                                    {
                                        head = head + "<th>0" + k + "</th>";
                                        csv = csv + "0" + k + ",";
                                    }
                                    else
                                    {
                                        head = head + "<th>" + k + "</th>";
                                        csv = csv + k + ",";
                                    }
                                }
                                head = head + "<th>BurnedEffort</th><th>ActualEffort</th><th>PendingHours</th></tr >";
                                csv = csv + "BurnedEffort,ActualEffort,PendingHours" + Environment.NewLine;
                                foreach (var user in users)
                                {
                                    if ((trcolorcount % 2) == 0)
                                        color = trcolor;
                                    else
                                        color = "background-color: white;";
                                    trcolorcount++;
                                    table = table + "<tr style='" + color + "'><td><input type='checkbox' class='form-check' /></td><td>" + user.Username + "</td><td style='display: none'>" + user.UserID + "</td>";
                                    csvdata = csvdata + user.Username+",";
                                    var time = user.timeEntries;
                                    decimal totalHours = 0;
                                    decimal burnedHours = 0;
                                    decimal leaveHours = 0;
                                    for (var i = 1; i <= days; i++)
                                    {
                                        string day = "";
                                        if (i < 10)
                                            day = "0" + i.ToString() + month;
                                        else
                                            day = i.ToString() + month;
                                        var entry = time.Where(x => x.date.ToShortDateString() == day).FirstOrDefault();
                                        var offday = Convert.ToDateTime(day);
                                        if (holiday.Result.Where(x => x == i).Any())
                                        {

                                            table = table + "<td style='color:red'>H</td>";
                                            csvdata = csvdata + "Holiday,";
                                            continue;

                                        }
                                        if (offday.DayOfWeek == DayOfWeek.Saturday)
                                        {
                                            table = table + "<td style='color:red'>Sa</td>";
                                            csvdata = csvdata + "Saturday,";
                                        }
                                        else if (offday.DayOfWeek == DayOfWeek.Sunday)
                                        {
                                            table = table + "<td style='color:red'>Su</td>";
                                            csvdata = csvdata + "Sunday,";
                                        }
                                        else
                                        {
                                            totalHours = totalHours + Convert.ToDecimal(6.5);
                                            if (entry != null)
                                            {

                                                if (entry.IsOff == false)
                                                {
                                                    burnedHours = burnedHours + entry.hours;
                                                    //if (_user.isAdmin == false)
                                                    //    table = table + "<td onclick='ShowModal(" + user.UserID + "," + i.ToString() + ")'>" + entry.hours + "</td>";
                                                    //else
                                                        table = table + "<td>" + entry.hours + "</td>";
                                                    csvdata = csvdata + entry.hours+",";
                                                }
                                                else
                                                {
                                                    if (entry.IsHalfday)
                                                    {
                                                        table = table + "<td>" + entry.hours + "</td>";
                                                        leaveHours = leaveHours + Convert.ToDecimal(3.25);
                                                        burnedHours = burnedHours + Convert.ToDecimal(3.25);
                                                        csvdata = csvdata + entry.hours + ",";
                                                    }
                                                    else
                                                    {
                                                        table = table + "<td>L</td>";
                                                        csvdata = csvdata + "Leave,";
                                                        leaveHours = leaveHours + Convert.ToDecimal(6.5);
                                                    }
                                                }
                                            }
                                            else
                                            {
                                                if (_user.isAdmin == false)
                                                    table = table + "<td onclick='ShowModal(" + user.UserID + "," + i + ")'>0</td>";
                                                else
                                                    table = table + "<td>0</td>";
                                                csvdata = csvdata + "0,";
                                            }
                                        }
                                    }
                                    var pending = totalHours - (burnedHours + leaveHours);
                                    table = table = table + "<td>" + burnedHours + "/" + leaveHours + "</td><td>" + totalHours.ToString() + "</td><td>"+ pending+"</td>";
                                    table = table + "</tr>";
                                    csvdata=csvdata+ burnedHours + "/" + leaveHours+","+ totalHours.ToString()+Environment.NewLine;
                                    
                                }
                                TempData["Download"] = csv  + csvdata;
                                return table+"|"+head;

                            }

                            //return result;


                        }
                        else if(Response.StatusCode == System.Net.HttpStatusCode.Unauthorized)
                        {
                            return "404";
                        }
                        else
                        {
                            return null;
                        }


                    }
                }
            }
            catch(Exception ex)
            {
                return null;
            }
        }
        [HttpGet]
        public IActionResult UserDetials()
        {
            var content = (TempData["user"]) as string;
            User _user = JsonConvert.DeserializeObject<User>(content);
            ViewBag.Name = _user.firstName + " " + _user.lastName;
            int m = Int32.Parse(DateTime.Today.Month.ToString()) - 1;
            if (ViewBag.SelectedMonth==null)
                ViewBag.Count = DateTime.DaysInMonth(DateTime.Today.Year, DateTime.Today.Month);
            else
                ViewBag.Count = DateTime.DaysInMonth(DateTime.Today.Year, (int)ViewBag.SelectedMonth);
            


            string month = Enum.GetName(typeof(Month), m);
            ViewBag.Month = month;

            TempData.Keep();
            ViewBag.Iscalled = 1;
            return View("Dashboard", _user);

        }
        [HttpGet]
        public IActionResult Download()
        {
            //string csv = "Charlie, Chaplin, Chuckles";

            //return File(new System.Text.UTF8Encoding().GetBytes(csv), "text/csv", "Report123.csv");
            string csv = (TempData["Download"]) as string;
            TempData.Keep();
            var stream = new MemoryStream(new System.Text.UTF8Encoding().GetBytes(csv));
            stream.Position = 0;
            var result = new FileStreamResult(stream, "text/plain");
            result.FileDownloadName = "export_" + DateTime.Now + ".csv";

            return result;

        }
        [HttpPost]
        public async Task<IActionResult> ApplyLeave(Leave _leave)
        {
            var content = (TempData["user"]) as string;
            User _user = JsonConvert.DeserializeObject<User>(content);
            TempData.Keep();
            using (HttpClient client = new HttpClient())
            {
                string endpoint = "https://localhost:44335/Auth/leave";
                var token = HttpContext.Request.Headers["Authorization"];
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
                StringContent _content = new StringContent(JsonConvert.SerializeObject(_leave), Encoding.UTF8, "application/json");
                using (var Response = await client.PostAsync(endpoint, _content))
                {
                    if (Response.StatusCode == System.Net.HttpStatusCode.OK)
                    {
                        return View("Dashboard", _user);
                    }
                    else
                    {
                        ModelState.Clear();
                        ModelState.AddModelError(string.Empty, "Eroor happend");
                        return View("Dashboard", _user);

                    }
                }
            }
        }

        [HttpGet]
        public async Task<bool> Sendmail(string userId)
        {
            var _dashboard = (TempData["DashBoardUser"]) as string;
            DashboardDetails deserialized = JsonConvert.DeserializeObject<DashboardDetails>(_dashboard);
            TempData.Keep();
            var _user = deserialized.users;
            var user = userId.Split('|');
            List<string> list = new List<string>();
            foreach (var u in user)
            {
                if (u != "")
                {
                    var userMail = _user.Where(x => x.UserID == Int32.Parse(u)).FirstOrDefault();
                    //SendEmail(userMail.UserKey, "test");
                    list.Add(userMail.UserKey);
                }
            }
            using (HttpClient client = new HttpClient())
            {
                var token = HttpContext.Request.Headers["Authorization"];
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
                string endpoint = "https://localhost:44335/Auth/sendmail";

                StringContent content = new StringContent(JsonConvert.SerializeObject(list), Encoding.UTF8, "application/json");
                using (var Response = await client.PostAsync(endpoint, content))
                {
                    if (Response.StatusCode == System.Net.HttpStatusCode.OK)
                    {

                        using (HttpContent _content = Response.Content)
                        {
                            return true;
                        }

                    }
                    else
                    {
                        return false;
                    }
                }
            }
        }
        private async Task<List<int>> GetHolidayForMonth(int month)
        {
            using (HttpClient client = new HttpClient())
            {
                string endpoint = "https://localhost:44335/Auth/holiday/" + month;
                using (var Response = await client.GetAsync(endpoint))
                {
                    if (Response.StatusCode == System.Net.HttpStatusCode.OK)
                    {

                        using (HttpContent _content = Response.Content)
                        {

                            Task<string> result = _content.ReadAsStringAsync();
                            string holidayresponse = result.Result.Replace("result", "users");
                            List<int> _holiday = JsonConvert.DeserializeObject<List<int>>(holidayresponse);
                            return _holiday;
                        }

                    }
                    else
                    {
                        ModelState.Clear();
                        ModelState.AddModelError(string.Empty, "Eroor happend");
                        return null;
                    }
                }
            }

        }
        public void SendEmail(string to,string message)
        {
            try
            {
                using (SmtpClient client = new SmtpClient("smtp.gmail.com",587))
                {
                    client.UseDefaultCredentials = false;
                    client.Credentials = new System.Net.NetworkCredential("dassubin@gmail.com", "Year@2020#$%");
                    MailMessage mailMessage = new MailMessage();
                    mailMessage.From = new MailAddress("dassubin@gamil.com");
                    mailMessage.BodyEncoding = Encoding.UTF8;
                    mailMessage.To.Add(to);
                    mailMessage.Body = message;
                    mailMessage.Subject = "Test";
                    mailMessage.IsBodyHtml = true;
                    
                    client.EnableSsl = true;
                    client.Send(mailMessage);
                }
            }
            catch(Exception ex)
            {
                throw ex; ;
            }
        }
    
    //private MimeMessage CreateMimeMessageFromEmailMessage(EmailMessage message)
    //{
    //    var mimeMessage = new MimeMessage();
    //    mimeMessage.From.Add(message.Sender);
    //    mimeMessage.To.Add(message.Reciever);
    //    mimeMessage.Subject = message.Subject;
    //    mimeMessage.Body = new TextPart(MimeKit.Text.TextFormat.Text)
    //    { Text = message.Content };
    //    return mimeMessage;
    //}
    //private string MailToUser(string email)
    //{
    //    EmailMessage message = new EmailMessage();
    //    message.Sender = new MailboxAddress("Self", "dassubin@gmail.com");
    //    message.Reciever = new MailboxAddress("Self", email);
    //    message.Subject = "Welcome";
    //    message.Content = "Hello World!";
    //    var mimeMessage = CreateEmailMessage(message);
    //    using (SmtpClient smtpClient = new SmtpClient())
    //    {
    //        smtpClient.Connect("smtp.gmail.com",
    //        465, true);
    //        smtpClient.Authenticate("dassubin@gamil.com",
    //        "Gamil2020#");
    //        smtpClient.Send(mimeMessage);
    //        smtpClient.Disconnect(true);
    //    }
    //    return "Email sent successfully";
    //}
}
}
