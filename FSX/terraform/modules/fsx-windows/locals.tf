locals {
  fsx_ports = [
    # Allow users to connect SMB shares
    {
      from_port   = 445
      to_port     = 445
      description = "SMB"
      protocol    = "TCP"
      cidr_blocks = var.vpc_cidr
    },
    # Allow administrator to manage shares
    {
      from_port   = 5985
      to_port     = 5986
      description = "WinRM"
      protocol    = "TCP"
      cidr_blocks = var.vpc_cidr
    }
  ]
}