resource "aws_security_group" "bastion-sg" {
  name   = "bastion-host"
  vpc_id = aws_vpc.gymef_vpc.id

  tags = merge(var.common_tags, {
    Name = " bastion-sg"
  })
}

resource "aws_security_group_rule" "sg-rule" {
  type              = "ingress"
  security_group_id = aws_security_group.bastion-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "sg-egress-rule" {
  security_group_id = aws_security_group.bastion-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports

}

