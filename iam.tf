
resource "aws_iam_role" "valheim" {
  name = "valheim-ec2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ec2.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "valheim_ssm" {
  role       = aws_iam_role.valheim.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "valheim" {
  name = "valheim-ec2"
  role = aws_iam_role.valheim.name
}