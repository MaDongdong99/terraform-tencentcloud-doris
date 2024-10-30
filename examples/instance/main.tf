locals {
  region       = "ap-singapore"
  availability_zones = ["ap-singapore-2"]
  vpc_cidr = "10.0.0.0/16"
  subnet_cidrs = ["10.0.0.0/24"]
  name = "test-doris"

  instance_tags = [
    {
      key = "created",
      value = "terraform"
    },
  ]
  tags = { for tag in local.instance_tags: tag.key => tag.value}
}

module "network" {
  source  = "terraform-tencentcloud-modules/vpc/tencentcloud"
  version = "1.1.0"
  vpc_name         = local.name
  vpc_cidr         = local.vpc_cidr
  vpc_is_multicast = false
  tags             = local.tags

  availability_zones = local.availability_zones
  subnet_name        = local.name
  subnet_cidrs       = local.subnet_cidrs
  subnet_is_multicast = false
  subnet_tags        = local.tags
}

module "doris" {
  source = "../../modules/instance"
  create_instance = true

  availability_zone = local.availability_zones[0]
  vpc_id = module.network.vpc_id
  subnet_id = module.network.subnet_id[0]
  instance_name = local.name
  doris_user_pwd = "Passw0rd!"
  product_version = "2.1"
  charge_properties = {
    charge_type = "POSTPAID_BY_HOUR"
  }
  security_group_ids = []
  fe_spec = {
    spec_name = "S_4_16_P"
    count     = 3
    disk_size = 200
  }
  be_spec = {
    spec_name = "S_4_16_P"
    count     = 3
    disk_size = 200
  }
  tags = local.instance_tags

  workload_group_status = "open"
  workload_groups = [
    {
      workload_group_name = "wg_1"
    }
  ]
}