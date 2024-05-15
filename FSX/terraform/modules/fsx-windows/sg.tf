resource "aws_security_group" "this" {
  name        = "${var.fsx_name}-Security-Group"
  description = "${var.fsx_name} Security Group"

  dynamic "ingress" {
    for_each = local.fsx_ports
    iterator = fsx_ports
    content {
      description = fsx_ports.value.description
      from_port   = fsx_ports.value.from_port
      to_port     = fsx_ports.value.to_port
      protocol    = fsx_ports.value.protocol
      cidr_blocks = [fsx_ports.value.cidr_blocks]
    }
  }

  egress {
    description = "Outbound to everywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    { Name = "${var.fsx_name}-Security-Group" },
    { Owners = "${var.owners}" },
    { Environment = "${var.environment}" },
    var.sg_tags,
  )
  vpc_id = var.vpc_id
}