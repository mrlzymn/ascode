# FSx variables
variable "fsx_name" {
  type        = string
  description = "File System Name"
  nullable    = false
}

variable "environment" {
  type        = string
  description = "AWS environment to deploy FSx"
  nullable    = false
}

variable "region" {
  type        = string
  description = "AWS region to deploy FSx"
  nullable    = false
}

variable "owners" {
  type        = string
  description = "The owner(s) of the FSx resource"
  nullable    = false
}

variable "fsx_description" {
  type        = string
  description = "Provide quick description about its usage"
  nullable    = false
}

variable "aliases" {
  type        = list(string)
  description = "FSx DNS aliases"
  nullable    = true
}

variable "automatic_backup_retention_days" {
  type        = number
  default     = 0
  description = "The number of days to retain automatic backups. Minimum of 0 and maximum of 90"
}

variable "skip_final_backup_on_deletion" {
  type        = bool
  default     = false
  description = "Take a final backup when FSx is deleted"
}

variable "deployment_type" {
  type        = string
  default     = "SINGLE_AZ_2"
  description = "Specifies the file system deployment type, valid values are MULTI_AZ_1, and SINGLE_AZ_2"
  validation {
    condition     = contains(["MULTI_AZ_1", "SINGLE_AZ_2"], var.deployment_type)
    error_message = "The storage type value must be MULTI_AZ_1, SINGLE_AZ_1, or SINGLE_AZ_2"
  }
}

variable "fsx_kms_key_arn" {
  type        = string
  description = "ARN for the KMS Key to encrypt the file system at rest"
  nullable    = false
}

variable "storage_capacity" {
  type        = number
  default     = 32
  description = "Storage capacity (GiB) of the file system. Minimum of 32 and maximum of 65536"
}

variable "storage_type" {
  type        = string
  default     = "HDD"
  description = "Specifies the storage type, valid values are SSD and HDD"
  validation {
    condition     = contains(["HDD", "SSD"], var.storage_type)
    error_message = "The storage type value must be HDD or SSD."
  }
}

variable "throughput_capacity" {
  type        = number
  default     = 16
  description = "Throughput (megabytes per second) of the file system in power of 2 increments. Minimum of 8 and maximum of 2048"
}

# Network variables
variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR where the FSx will be deployed"
  nullable    = false
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the FSx will be deployed"
  nullable    = false
}

variable "vpc_subnets_ids" {
  type        = list(string)
  description = "List of subnet IDs that the FSx can be located"
  nullable    = false
}

variable "preferred_subnet_id" {
  type        = string
  description = "Preferred subnet ID that the FSx can be located"
  nullable    = false
}

# Managed AD variables
variable "managed_ad_ip" {
  type        = list(string)
  description = "AD IP(s) of the AWS Managed Microsoft AD"
  nullable    = false
}

variable "managed_ad_domain" {
  type        = string
  description = "FQDN of the Managed Microsoft AD"
  nullable    = false
}

variable "username" {
  type        = string
  description = "AD user to join FSx to the Managed AD domain"
  nullable    = false
}

variable "password" {
  type        = string
  description = "AD user password to join FSx to the Managed AD domain"
  nullable    = false
}

variable "ou_distinguished_name" {
  type        = string
  description = "OU distinguished name for fsx computer object"
  nullable    = false
}

# Tag variables
variable "sg_tags" {
  type = map(string)
  default = {
    Terraform = "True"
    Resource  = "SG"
  }
  description = "SG tags"
}

variable "fsx_tags" {
  type = map(string)
  default = {
    Terraform = "True"
    Resource  = "FSx"
  }
  description = "FSx tags"
}
