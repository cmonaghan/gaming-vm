provider "aws" {
  region = "us-east-1"
}

variable "my_ip" {
  description = "The IP address you wish to game from; probably your current IP address."
}

variable "instance_type" {
  description = "Choose how powerful of a machine you want. Choose g2.2xlarge for the best performance, however this requires requesting a limit increase for your AWS account by contacting AWS support."
  default = "m5.xlarge"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "web" {
  ami = "ami-00cf55d99af33ce11" # aka "christians glorious gaming machine"
  instance_type = var.instance_type
  ebs_optimized = true
  vpc_security_group_ids = [aws_security_group.trusted_ips.id]

  root_block_device {
    volume_size = 30
    encrypted = false # encrypting makes it take way longer to snapshot a new AMI
    delete_on_termination = true
  }
}

resource "aws_security_group" "trusted_ips" {
  name        = "Trusted IPs"
  description = "allows RDP access from these IP addresses"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "trusted ips"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance_dns_addr" {
  value = aws_instance.web.public_dns
}
