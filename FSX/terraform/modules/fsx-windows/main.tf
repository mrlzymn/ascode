resource "aws_fsx_windows_file_system" "this" {
  subnet_ids                      = var.deployment_type == "SINGLE_AZ_2" ? [var.vpc_subnets[0]] : var.vpc_subnets
  throughput_capacity             = var.throughput_capacity
  automatic_backup_retention_days = var.automatic_backup_retention_days
  deployment_type                 = var.deployment_type
  kms_key_id                      = var.fsx_kms_key_arn
  preferred_subnet_id             = var.preferred_subnet_id
  security_group_ids              = [aws_security_group.this.id]
  skip_final_backup               = var.skip_final_backup_on_deletion
  storage_capacity                = var.storage_capacity
  storage_type                    = var.storage_type
  aliases                         = var.aliases


  self_managed_active_directory {
    dns_ips                                = var.managed_ad_ip
    domain_name                            = var.managed_ad_domain
    password                               = var.password
    username                               = var.username
    organizational_unit_distinguished_name = var.ou_distinguished_name
  }

  tags = merge(
    { Name = "${var.fsx_name}" },
    { Owners = "${var.owners}" },
    { Environment = "${var.environment}" },
    { Description = "${var.fsx_description}"},
    var.fsx_tags,
  )
}