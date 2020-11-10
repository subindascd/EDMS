using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace CsvFileExtractor.Entity
{
    
        public class AuthContext : DbContext
        {
            public AuthContext(DbContextOptions<AuthContext> options) : base(options)
            {
            }
            public AuthContext()
            {
            
            }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {

            optionsBuilder.UseSqlServer(@"Data Source=CTSDCLOUDMC165;Database=Auth;Persist Security Info=True;Integrated Security=SSPI;");
        }
        public virtual DbSet<UserProfilesEntity> UserProfile { get; set; }
            public virtual DbSet<TimesheetEntity> Timesheet { get; set; }
            
            protected override void OnModelCreating(ModelBuilder modelBuilder)
            {
                modelBuilder.Entity<UserProfilesEntity>(entity =>
                {
                    entity.HasKey(e => new { e.UserID });
                    entity.Property(e => e.CreatedDate).HasColumnType("datetime");

                });
               
                modelBuilder.Entity<TimesheetEntity>(entity =>
                {
                    entity.HasKey(e => new { e.Id });
                    




                });
               
            }
        }
    

}
