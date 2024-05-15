# FSx outputs
output "fsx_dns_name" {
  value       = module.fsx_windows.fsx_dns_name
  description = "DNS name for the file system, e.g., fs-12345678.example.com"
}

output "preferred_fs_ip" {
  value       = module.fsx_windows.preferred_fs_ip
  description = "The IP address of the primary, or preferred, file server."
}

output "remote_administration_endpoint" {
  value       = module.fsx_windows.remote_administration_endpoint
  description = "For MULTI_AZ_1 deployment types, use this endpoint when performing administrative tasks on the file system using Amazon FSx Remote PowerShell. For SINGLE_AZ_1 deployment types, this is the DNS name of the file system."
}

output "ou_distingushed_name" {
  value       = module.fsx_windows.ou_distingushed_name
  description = "OU distinguished name for fsx computer object"
}

output "managed_ad_ip" {
  value       = module.fsx_windows.managed_ad_ip
  description = "The IP address of the managed AD server DNS"
}
