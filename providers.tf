provider "http" {}

provider "aws" {
  region = "${var.region}"
}

resource "aws_key_pair" "ssh" {
  key_name   = "${var.cluster_name}"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com"
}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {}
