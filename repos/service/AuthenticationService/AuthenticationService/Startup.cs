using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using AuthenticationService.Data.Context;
using Microsoft.EntityFrameworkCore;
using AuthenticationService.Service.Interface;
using AuthenticationService.Service;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using AuthenticationService.Service.JWTAuthentication.Attributes;
using AuthenticationService.Service.JWTAuthentication.Filter;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Http;
using AuthenticationService.Service.JWTAuthentication.Interface;
using AuthenticationService.Service.JWTAuthentication;

namespace AuthenticationService
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddControllers();
            services.AddMvc();
            var ConnectionString = Configuration.GetConnectionString("EDMSeConnection");
            MvcOptions a = new MvcOptions();
            a.EnableEndpointRouting = false;
            //Entity Framework  
           services.AddDbContext<AuthContext>(options => options.UseSqlServer(ConnectionString));
            services.AddScoped<IAuthenticationService, AuthService>();
            services.AddCors();
            services.AddScoped<AuthenticationServiceAttribute>();
            services.AddScoped<IAuthorizationFilter, AuthenticationServiceFilter>();
            services.AddScoped<IJwtFactory, JWTFactory>();
            services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();
            services.Configure<MvcOptions>(options =>
            {
                options.Filters.Add(typeof(AuthenticationServiceFilter));
            });
            var SecretKey = System.Text.Encoding.ASCII.GetBytes
         ("YourKey-2374-OFFKDI940NG7:56753253-tyuw-5769-0921-kfirox29zoxv");
            //Configure JWT Token Authentication
            services.AddAuthentication(auth =>
            {
                auth.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                auth.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            })
            .AddJwtBearer(token =>
            {
                token.RequireHttpsMetadata = false;
                token.SaveToken = true;
                token.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
            //Same Secret key will be used while creating the token
            IssuerSigningKey = new SymmetricSecurityKey(SecretKey),
                    ValidateIssuer = true,
            //Usually, this is your application base URL
            ValidIssuer = "http://localhost:44379/",
                    ValidateAudience = true,
            //Here, we are creating and using JWT within the same application.
            //In this case, base URL is fine.
            //If the JWT is created using a web service, then this would be the consumer URL.
            ValidAudience = "http://localhost:44379/",
                    RequireExpirationTime = true,
                    ValidateLifetime = true,
                    ClockSkew = TimeSpan.Zero
                };
            });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();
            app.UseCors();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
            
        }
    }
}
