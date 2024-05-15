<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_fsx_windows_file_system.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_windows_file_system) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aliases"></a> [aliases](#input\_aliases) | FSx DNS aliases | `list(string)` | n/a | yes |
| <a name="input_automatic_backup_retention_days"></a> [automatic\_backup\_retention\_days](#input\_automatic\_backup\_retention\_days) | The number of days to retain automatic backups. Minimum of 0 and maximum of 90 | `number` | `0` | no |
| <a name="input_deployment_type"></a> [deployment\_type](#input\_deployment\_type) | Specifies the file system deployment type, valid values are MULTI\_AZ\_1, and SINGLE\_AZ\_2 | `string` | `"SINGLE_AZ_2"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | AWS environment to deploy FSx | `string` | n/a | yes |
| <a name="input_fsx_description"></a> [fsx\_description](#input\_fsx\_description) | Provide quick description about its usage | `string` | n/a | yes |
| <a name="input_fsx_kms_key_arn"></a> [fsx\_kms\_key\_arn](#input\_fsx\_kms\_key\_arn) | ARN for the KMS Key to encrypt the file system at rest | `string` | n/a | yes |
| <a name="input_fsx_name"></a> [fsx\_name](#input\_fsx\_name) | File System Name | `string` | n/a | yes |
| <a name="input_fsx_tags"></a> [fsx\_tags](#input\_fsx\_tags) | FSx tags | `map(string)` | <pre>{<br>  "Resource": "FSx",<br>  "Terraform": "True"<br>}</pre> | no |
| <a name="input_managed_ad_domain"></a> [managed\_ad\_domain](#input\_managed\_ad\_domain) | FQDN of the Managed Microsoft AD | `string` | n/a | yes |
| <a name="input_managed_ad_ip"></a> [managed\_ad\_ip](#input\_managed\_ad\_ip) | AD IP(s) of the AWS Managed Microsoft AD | `list(string)` | n/a | yes |
| <a name="input_ou_distinguished_name"></a> [ou\_distinguished\_name](#input\_ou\_distinguished\_name) | OU distinguished name for fsx computer object | `string` | n/a | yes |
| <a name="input_owners"></a> [owners](#input\_owners) | The owner(s) of the FSx resource | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | AD user password to join FSx to the Managed AD domain | `string` | n/a | yes |
| <a name="input_preferred_subnet_id"></a> [preferred\_subnet\_id](#input\_preferred\_subnet\_id) | Preferred subnet ID that the FSx can be located | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region to deploy FSx | `string` | n/a | yes |
| <a name="input_sg_tags"></a> [sg\_tags](#input\_sg\_tags) | SG tags | `map(string)` | <pre>{<br>  "Resource": "SG",<br>  "Terraform": "True"<br>}</pre> | no |
| <a name="input_skip_final_backup_on_deletion"></a> [skip\_final\_backup\_on\_deletion](#input\_skip\_final\_backup\_on\_deletion) | Take a final backup when FSx is deleted | `bool` | `false` | no |
| <a name="input_storage_capacity"></a> [storage\_capacity](#input\_storage\_capacity) | Storage capacity (GiB) of the file system. Minimum of 32 and maximum of 65536 | `number` | `32` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | Specifies the storage type, valid values are SSD and HDD | `string` | `"HDD"` | no |
| <a name="input_throughput_capacity"></a> [throughput\_capacity](#input\_throughput\_capacity) | Throughput (megabytes per second) of the file system in power of 2 increments. Minimum of 8 and maximum of 2048 | `number` | `16` | no |
| <a name="input_username"></a> [username](#input\_username) | AD user to join FSx to the Managed AD domain | `string` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR where the FSx will be deployed | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where the FSx will be deployed | `string` | n/a | yes |
| <a name="input_vpc_subnets_ids"></a> [vpc\_subnets\_ids](#input\_vpc\_subnets\_ids) | List of subnet IDs that the FSx can be located | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fsx_dns_name"></a> [fsx\_dns\_name](#output\_fsx\_dns\_name) | DNS name for the file system, e.g., fs-12345678.example.com |
| <a name="output_managed_ad_ip"></a> [managed\_ad\_ip](#output\_managed\_ad\_ip) | The IP address of the managed AD server DNS |
| <a name="output_ou_distingushed_name"></a> [ou\_distingushed\_name](#output\_ou\_distingushed\_name) | OU distinguished name for fsx computer object |
| <a name="output_preferred_fs_ip"></a> [preferred\_fs\_ip](#output\_preferred\_fs\_ip) | The IP address of the primary, or preferred, file server. |
| <a name="output_remote_administration_endpoint"></a> [remote\_administration\_endpoint](#output\_remote\_administration\_endpoint) | For MULTI\_AZ\_1 deployment types, use this endpoint when performing administrative tasks on the file system using Amazon FSx Remote PowerShell. For SINGLE\_AZ\_1 deployment types, this is the DNS name of the file system. |
<!-- END_TF_DOCS -->