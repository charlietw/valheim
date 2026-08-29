
resource "aws_instance" "valheim" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3a.nano"

  subnet_id              = data.aws_subnet.default.vpc_id
  vpc_security_group_ids = [aws_security_group.valheim.id]
  iam_instance_profile = aws_iam_instance_profile.valheim.name
  associate_public_ip_address = true

  user_data = file("${path.module}/user-data.sh")

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 10
    delete_on_termination = false
  }

  tags = {
    Name = "valheim"
  }
}



resource "aws_security_group" "valheim" {
  name        = "valheim"
  description = "Valheim server"
  vpc_id      = data.aws_subnet.default.vpc_id

  ingress {
    description = "Valheim"
    protocol    = "udp"
    from_port   = 2456
    to_port     = 2457
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "valheim" {
  name   = "valheim"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "Valheim"
    protocol    = "udp"
    from_port   = 2456
    to_port     = 2457
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}