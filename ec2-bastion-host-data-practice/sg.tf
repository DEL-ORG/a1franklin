resource "aws_security_group" "bastion-sg1" {
  name   = "bastion-host1"
  vpc_id = data.aws_vpc.vpc_id.id

  tags = merge(var.common_tags, {
    Name = " bastion-sg1"
  })
}

resource "aws_security_group_rule" "sg-rule1" {
  type              = "ingress"
  security_group_id = aws_security_group.bastion-sg1.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "sg-egress-rule1" {
  security_group_id = aws_security_group.bastion-sg1.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports

}
