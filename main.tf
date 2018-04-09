module "label" {
  source      = "git::https://github.com/terraform-library/terraform-label.git?ref=tags/0.3.1"
  namespace   = "${var.managedby}"
  name        = "${var.name}"
  environment = "${var.environment}"
}

resource "aws_vpc" "default" {
  cidr_block                       = "${var.cidr_block}"
  instance_tenancy                 = "${var.instance_tenancy}"
  enable_dns_hostnames             = "${var.enable_dns_hostnames}"
  enable_dns_support               = "${var.enable_dns_support}"
  enable_classiclink               = "${var.enable_classiclink}"
  enable_classiclink_dns_support   = "${var.enable_classiclink_dns_support}"
  assign_generated_ipv6_cidr_block = "${var.assign_generated_ipv6_cidr_block}"
  tags                             = "${module.label.tags}"
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
  tags   = "${module.label.tags}"
}