variable "availability_zone" {
  default = "ap-guangzhou-7"
}

resource "tencentcloud_vpc" "vpc" {
  name       = "vpc-example"
  cidr_block = "10.0.0.0/16"
}

resource "tencentcloud_subnet" "subnet" {
  vpc_id            = tencentcloud_vpc.vpc.id
  name              = "subnet-example"
  cidr_block        = "10.0.0.0/16"
  availability_zone = var.availability_zone
  is_multicast      = false
}

resource "tencentcloud_security_group" "sglab_1" {
  name        = "mysg_1"
  description = "favourite sg_1"
  project_id  = 0
}

resource "tencentcloud_security_group_rule" "sglab_1" {
  security_group_id = tencentcloud_security_group.sglab_1.id
  type              = "ingress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "TCP"
  port_range        = "80"
  policy            = "ACCEPT"
  description       = "favourite sg rule_1"
}

data "tencentcloud_images" "default" {
  image_type = ["PUBLIC_IMAGE"]
  image_name_regex = "Final"
}

data "tencentcloud_instance_types" "default" {
  filter {
    name   = "zone"
    values = [var.availability_zone]
  }
  cpu_core_count = 2
  exclude_sold_out = true
}

resource "tencentcloud_instance" "foo" {
  instance_name     = "test-sg-order"
  availability_zone = var.availability_zone
  image_id          = data.tencentcloud_images.default.images.0.image_id
  instance_type     = data.tencentcloud_instance_types.default.instance_types.0.instance_type
  system_disk_type  = "CLOUD_PREMIUM"
  vpc_id            = tencentcloud_vpc.vpc.id
  subnet_id         = tencentcloud_subnet.subnet.id
  private_ip        = "10.0.0.123"
  data_disks {
    data_disk_size         = 100
    data_disk_type         = "CLOUD_SSD"
    delete_with_instance   = true
    encrypt                = false
    throughput_performance = 0
  }
  allocate_public_ip = true
}