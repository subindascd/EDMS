using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using EDMS.Models;
using System.Net.Http;
using Newtonsoft.Json;
using System.Text;
using Microsoft.AspNetCore.Http;

namespace EDMS.Controllers
{
    public class AuthenticationController : Controller
    {
        [HttpGet]
        public IActionResult Login()
        {
            HttpContext.Session.Clear();
            return View();
        }
        [HttpPost]

        public async Task<ActionResult> Login(UserAuthenticateRequest userAuthenticateRequest, string returnUrl)
        {
            User _user = null;
            if (ModelState.IsValid)
            {
                using (HttpClient client = new HttpClient())
                {

                    string endpoint = "https://localhost:44335/Auth/Authenticate";
                   
                    StringContent content = new StringContent(JsonConvert.SerializeObject(userAuthenticateRequest), Encoding.UTF8, "application/json");
                    using (var Response = await client.PostAsync(endpoint, content))
                    {
                        if (Response.StatusCode == System.Net.HttpStatusCode.OK)
                        {

                            using (HttpContent _content = Response.Content)
                            {
                                
                                Task<string> result =  _content.ReadAsStringAsync();
                                 Result deserialized = JsonConvert.DeserializeObject<Result>(result.Result);
                                _user = deserialized.result;
                                TempData["user"] = JsonConvert.SerializeObject(_user);
                                ViewBag.Name = _user.firstName + " " + _user.lastName;

                            }
                            var userToken = _user.Token;
                            HttpContext.Session.SetString("JWToken", userToken);
                            return RedirectToAction("UserDetials", "Dashboard", new { area = "Admin" });
                            

                        }
                        else
                        {
                            ModelState.Clear();
                            ModelState.AddModelError(string.Empty, "Username or Password is Incorrect");
                            return View();

                        }

                    }
                }


            }
            return View();
        }

    }
}
