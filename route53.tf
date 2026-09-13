resource "aws_eip" "lb" {
  instance = aws_instance.valheim.id
  domain   = "vpc"
}

resource "aws_route53_record" "valheim" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "valheim.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.valheim.public_ip]
}