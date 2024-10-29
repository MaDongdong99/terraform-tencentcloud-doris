
locals {
  instance_id = var.create_instance ? concat(tencentcloud_cdwdoris_instance.instance.*.id, [""])[0] : var.instance_id
}

resource "tencentcloud_cdwdoris_instance" "instance" {
  count = var.create_instance ? 1 : 0
  zone                  = var.availability_zone
  user_vpc_id           = var.vpc_id
  user_subnet_id        = var.subnet_id
  product_version       = var.product_version # "2.1"
  instance_name         = var.instance_name # "tf-example"
  doris_user_pwd        = var.doris_user_pwd # "Password@test"
  ha_flag               = var.ha_type == 0 ? false : true # false
  ha_type = var.ha_type
  case_sensitive        = var.case_sensitive # 0
  enable_multi_zones    = var.enable_multi_zones # false
  workload_group_status = var.workload_group_status # "close"

  security_group_ids = var.security_group_ids

  charge_properties {
    charge_type = try(var.charge_properties.charge_type, "POSTPAID_BY_HOUR") # "PREPAID"
    time_span   = try(var.charge_properties.charge_type, "POSTPAID_BY_HOUR") == "PREPAID" ? try(var.charge_properties.time_span, 1) : null
    time_unit   = try(var.charge_properties.charge_type, "POSTPAID_BY_HOUR") == "PREPAID" ? try(var.charge_properties.time_unit, "m") : null
    renew_flag =  try(var.charge_properties.charge_type, "POSTPAID_BY_HOUR") == "PREPAID" ? try(var.charge_properties.renew_flag, 1) : null
  }

  fe_spec {
    spec_name = var.fe_spec.spec_name # "S_4_16_P"
    count     = var.fe_spec.count # 3
    disk_size = var.fe_spec.disk_size # 200
  }

  be_spec {
    spec_name = var.be_spec.spec_name # "S_4_16_P"
    count     = var.be_spec.count # 3
    disk_size = var.be_spec.disk_size # 200
  }

  dynamic tags {
    for_each = var.tags
    content {
      tag_key   = tags.value.key # "createBy"
      tag_value = tags.value.value # "Terraform"
    }
  }
}

resource "tencentcloud_cdwdoris_workload_group" "example" {
  count = var.create_instance && var.workload_group_status == "open" ? 1 : 0
  instance_id = local.instance_id
  dynamic "workload_group" {
    for_each =  var.workload_groups
    content {
      workload_group_name       = workload_group.value.workload_group_name # "example"
      cpu_share                 = try(workload_group.value.cpu_share, 1024)
      memory_limit              = try(workload_group.value.memory_limit, 20)
      enable_memory_over_commit = try(workload_group.value.enable_memory_over_commit, true)
      cpu_hard_limit            = try(workload_group.value.cpu_hard_limit, "30%")
    }
  }
}

#data "tencentcloud_cam_users" "all" {
#}
#
#locals {
#  user_uins = {
#    for user in data.tencentcloud_cam_users.all.user_list: user.name => user.uin
#  }
#}
#
#
#resource "tencentcloud_cdwdoris_user" "ordinary_users" {
#  api_type = "AddSystemUser"
#  user_privilege = 0
#  dynamic "user_info" {
#    for_each = var.ordinary_users
#    content {
#      instance_id = local.instance_id
#      password = user_info.value.password
#      username = user_info.value.username
#      cam_ranger_group_ids = try(user_info.value.cam_ranger_group_ids, null)
#      cam_uin = local.user_uins[user_info.value.username]
#      describe = try(user_info.value.describe, "")
#      white_host = try(user_info.value.white_host, null)
#    }
#  }
#}
#
#resource "tencentcloud_cdwdoris_user" "administrators" {
#  api_type = "AddSystemUser"
#  user_privilege = 1
#  dynamic "user_info" {
#    for_each = var.administrators
#    content {
#      instance_id = local.instance_id
#      password = user_info.value.password
#      username = user_info.value.username
#      cam_ranger_group_ids = try(user_info.value.cam_ranger_group_ids, null)
#      cam_uin = local.user_uins[user_info.value.username]
#      describe = try(user_info.value.describe, "")
#      white_host = try(user_info.value.white_host, null)
#    }
#  }
#}
