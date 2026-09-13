# Creds for the discord bot, which runs on my raspberry pi

resource "aws_iam_user" "valheim_bot" {
  name = "valheim-discord-bot"
}

resource "aws_iam_user_policy" "valheim_bot" {
  user = aws_iam_user.valheim_bot.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:StartInstances",
          "ec2:DescribeInstances",
          "ec2:StopInstances"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_access_key" "valheim_bot" {
  user = aws_iam_user.valheim_bot.name
}