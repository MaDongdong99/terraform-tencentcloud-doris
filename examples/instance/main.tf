locals {
  region       = "ap-singapore"
  azs          = ["ap-singapore-2"]
  vpc_id = "vpc-j0sqtqk7"
  subnet_id = "subnet-p6xvdq6i"
  sg_id = "sg-3fj6w1au"
  name = "test-doris"

  tags = [
    {
      key = "env",
      value = "dev"
    },
    {
      key = "created",
      value = "terraform"
    },
  ]
}

module "doris" {
  source = "../../modules/instance"
  create_instance = true

  availability_zone = local.azs[0]
  vpc_id = local.vpc_id
  subnet_id = local.subnet_id
  instance_name = local.name
  doris_user_pwd = "Passw0rd!"
  product_version = "2.1"
  charge_properties = {
    charge_type = "POSTPAID_BY_HOUR"
  }
  security_group_ids = [ local.sg_id ]
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
  tags = local.tags

  workload_group_status = "open"
  workload_groups = [
    {
      workload_group_name = "wg_1"
    }
  ]
}