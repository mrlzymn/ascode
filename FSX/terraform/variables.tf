#---------------------------------------------------------------------------------------------------
# Provider/Remote backend variables
#---------------------------------------------------------------------------------------------------
variable "region" {
  type        = string
  description = "AWS Region"
}

variable "environment" {
  type        = string
  description = "AWS deployment environment"
}

variable "shared_config_files" {
  type        = list(string)
  description = "AWS config file location"
}

variable "shared_credentials_files" {
  type        = list(string)
  description = "AWS credentials file location"
}

#---------------------------------------------------------------------------------------------------
# FSX settings variables
#---------------------------------------------------------------------------------------------------
variable "fsx_name" {
  type        = string
  description = "File System Name"
}

variable "aliases" {
  type        = list(string)
  description = "FSx DNS aliases"
}

variable "fsx_kms_key_arn" {
  type        = string
  description = "ARN for the KMS Key to encrypt the file system at rest"
}

variable "automatic_backup_retention_days" {
  type        = number
  description = "The number of days to retain automatic backups. Minimum of 0 and maximum of 90"
}

variable "skip_final_backup_on_deletion" {
  type        = bool
  description = "Take a final backup when FSx is deleted"
}

variable "deployment_type" {
  type        = string
  description = "Specifies the file system deployment type, valid values are MULTI_AZ_1, and SINGLE_AZ_2"
}

variable "storage_capacity" {
  type        = number
  description = "Storage capacity (GiB) of the file system. Minimum of 32 and maximum of 65536"
}

variable "storage_type" {
  type        = string
  description = "Specifies the storage type, valid values are SSD and HDD"
}

variable "throughput_capacity" {
  type        = number
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
}

variable "vpc_subnets_ids" {
  type        = list(string)
  description = "List of subnet IDs that the FSx can be located"
}

variable "preferred_subnet_id" {
  type        = string
  description = "Preferred subnet ID that the FSx can be located"
}

# Managed domain variables
variable "managed_ad_domain" {
  type        = string
  description = "FQDN of the Managed Microsoft AD"
}

variable "managed_ad_ip" {
  type        = list(string)
  description = "AD IP(s) of the AWS Managed Microsoft AD"
}

variable "ou_distinguished_name" {
  type        = string
  description = "OU distinguished name for fsx computer object"
}

variable "username" {
  type        = string
  description = "AD user to join FSx to the Managed AD domain"
}

variable "password" {
  type        = string
  description = "AD user password to join FSx to the Managed AD domain"
}

variable "owners" {
  type        = string
  description = "The owner(s) of the FSx resource"
}

variable "fsx_description" {
  type        = string
  description = "FSx description"
}