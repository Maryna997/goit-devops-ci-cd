variable "name" {
  description = "Name of the RDS instance or Aurora cluster"
  type        = string
}

variable "engine" {
  description = "Database engine for standard RDS instance (postgres, mysql, mariadb, etc.)"
  type    = string
  default = "postgres"

  validation {
    condition     = contains(["postgres", "mysql", "mariadb"], var.engine)
    error_message = "Engine must be one of: postgres, mysql, mariadb."
  }
}

variable "engine_cluster" {
  description = "Database engine for Aurora cluster"
  type    = string
  default = "aurora-postgresql"
}

variable "aurora_replica_count" {
  description = "Number of Aurora read replicas"
  type    = number
  default = 1
}

variable "aurora_instance_count" {
  description = "Total number of Aurora instances (1 writer + read replicas)"
  type    = number
  default = 2 
}

variable "engine_version" {
  description = "Engine version for the standard RDS instance"
  type    = string
  default = "14.7"
}

variable "instance_class" {
  description = "Instance class for the RDS or Aurora instances"
  type    = string
  default = "db.t3.medium"
}

variable "allocated_storage" {
  description = "Allocated storage size in GB for the RDS instance"
  type    = number
  default = 20
}

variable "db_name" {
  description = "Initial database name"
  type = string
}

variable "username" {
  description = "Master username for the database"
  type = string
}

variable "password" {
  description = "Master password for the database"
  type      = string
  sensitive = true
}

variable "vpc_id" {
  description = "ID of the VPC where the database will be deployed"
  type = string
}

variable "subnet_private_ids" {
  description = "List of private subnet IDs for the database subnet group"
  type = list(string)
}

variable "subnet_public_ids" {
  description = "List of public subnet IDs for the database subnet group"
  type = list(string)
}

variable "publicly_accessible" {
  description = "Whether the database instance should have a public IP address"
  type    = bool
  default = false
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment for high availability"
  type    = bool
  default = false
}

variable "parameters" {
  description = "Map of database parameter group settings"
  type    = map(string)
  default = {}
}

variable "use_aurora" {
  description = "Whether to deploy an Aurora cluster instead of a standard RDS instance"
  type    = bool
  default = false
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups"
  type    = string
  default = ""
}

variable "tags" {
  description = "Tags to apply to all created resources"
  type    = map(string)
  default = {}
}

variable "parameter_group_family_aurora" {
  description = "Aurora DB parameter group family"
  type    = string
  default = "aurora-postgresql15"
}

variable "engine_version_cluster" {
  description = "Engine version for the Aurora cluster"
  type    = string
  default = "15.3"
}

variable "parameter_group_family_rds" {
  description = "RDS DB parameter group family"
  type    = string
  default = "postgres15"
}

variable "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  type        = string
}