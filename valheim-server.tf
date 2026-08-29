
resource "aws_instance" "valheim" {
  ami           = data.aws_ssm_parameter.amazon_linux.value
  instance_type = "t3a.small"

  subnet_id                   = data.aws_subnet.default.id
  vpc_security_group_ids      = [aws_security_group.valheim.id]
  iam_instance_profile        = aws_iam_instance_profile.valheim.name
  associate_public_ip_address = true

  user_data = file("${path.module}/user-data.sh")

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    delete_on_termination = true
  }

  tags = {
    Name = "valheim"
  }
}



resource "aws_security_group" "valheim" {
  name        = "valheim"
  description = "Valheim server"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Valheim"
    protocol    = "udp"
    from_port   = 2456
    to_port     = 2458
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ebs_volume" "valheim" {
  availability_zone = data.aws_subnet.default.availability_zone
  size              = 10
  type              = "gp3"

  tags = {
    Name = "valheim-data"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_volume_attachment" "valheim" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.valheim.id
  instance_id = aws_instance.valheim.id
}