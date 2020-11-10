using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.EntityFrameworkCore;
using AuthenticationService.Data.Entity;

namespace AuthenticationService.Data.Context
{
    public class AuthContext : DbContext
    {
        public AuthContext(DbContextOptions<AuthContext> options) : base(options)
        {
        }
        public virtual DbSet<UserProfilesEntity> UserProfile { get; set; }
        public virtual DbSet<RoleEntity> Role { get; set; }
        public virtual DbSet<UserRoleEntity> UserRole { get; set; }

        public virtual DbSet<TimesheetEntity> Timesheet { get; set; }
        public virtual DbSet<ProjectEntity> Project { get; set; }
        public virtual DbSet<ProjectAllocationEntity> ProjectAllocation { get; set; }

        public virtual DbSet<HolidayEntity> Holiday { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserProfilesEntity>(entity =>
            {
                entity.HasKey(e => new { e.UserID });
                entity.Property(e => e.CreatedDate).HasColumnType("datetime");

            });
            modelBuilder.Entity<RoleEntity>(entity =>
            {
                entity.HasKey(e => new { e.RoleID });
                

            });
            modelBuilder.Entity<UserRoleEntity>(entity =>
            {
                entity.HasKey(e => new { e.UserRoleID,e.UserID,e.RoleID });
                

            });
            modelBuilder.Entity<ProjectEntity>(entity =>
            {
                entity.HasKey(e => new { e.ProjectID});


            });
            modelBuilder.Entity<ProjectAllocationEntity>(entity =>
            {
                entity.HasKey(e => new { e.ID, e.ProjectId, e.UserId });


            });

            modelBuilder.Entity<TimesheetEntity>(entity =>
            {
                entity.HasKey(e => new { e.Id });
               



            });
            modelBuilder.Entity<HolidayEntity>(entity =>
            {
                entity.HasKey(e => new { e.ID });


            });
        }
    }
}
