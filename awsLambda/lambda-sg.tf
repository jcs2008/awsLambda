resource "aws_security_group" "lambda-sg" {
  lifecycle {
    create_before_destroy = true
  }

  name          = "sg-aws-lambda"
  description   = "LAMBDA security group"
  vpc_id        = "${data.aws_vpc.lambda_vpc.id}"
  tags          = "${merge(map(
    "CostCentre", "${var.cost_centre}",
    "Environment", "${var.environment}",
    "EnvironmentZone", "${var.environment_zone}",
    "Name", "sg-${var.service}-${var.environment}",
    "Product", "Inisheer",
    "Owner", "${var.owner}",
    "Region", "${var.region}",
    "Role", "${var.role}",
    "Service", "${var.service}",
    "CreatedBy", "${var.created_by}"),
    "${var.tags}")}"
}
# VPC-level security group: allow all egress traffic
resource "aws_security_group_rule" "vpc_https_egress_all" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.lambda-sg.id}"

}
resource "aws_security_group_rule" "vpc_tcp_egress_all" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = 53
  to_port           = 53
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.lambda-sg.id}"


}
resource "aws_security_group_rule" "vpc_udp_egress_all" {
  type              = "egress"
  protocol          = "udp"
  from_port         = 53
  to_port           = 53
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.lambda-sg.id}"

}
data "aws_vpc" "lambda_vpc" {
  id = "${var.aws_lambda_vpc}"
}
