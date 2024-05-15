output "fsx_dns_name" {
  value       = aws_fsx_windows_file_system.this[*].dns_name
  description = "DNS name for the file system, e.g., fs-12345678.example.com"
}

output "preferred_fs_ip" {
  value       = aws_fsx_windows_file_system.this[*].preferred_file_server_ip
  description = "The IP address of the primary, or preferred, file server."
}

output "remote_administration_endpoint" {
  value       = aws_fsx_windows_file_system.this[*].remote_administration_endpoint
  description = "For MULTI_AZ_1 deployment types, use this endpoint when performing administrative tasks on the file system using Amazon FSx Remote PowerShell. For SINGLE_AZ_1 deployment types, this is the DNS name of the file system."
}

output "ou_distingushed_name" {
  value       = var.ou_distinguished_name
  description = "OU distinguished name for fsx computer object"
}

output "managed_ad_ip" {
  value       = var.managed_ad_ip
  description = "The IP address of the managed AD server DNS"
}