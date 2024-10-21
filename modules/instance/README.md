# tencentcloud TCHose-D (Doris)



## usage

```terraform

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

```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_tencentcloud"></a> [tencentcloud](#requirement\_tencentcloud) | >1.78.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tencentcloud"></a> [tencentcloud](#provider\_tencentcloud) | >1.78.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tencentcloud_cdwdoris_instance.instance](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/cdwdoris_instance) | resource |
| [tencentcloud_cdwdoris_workload_group.example](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/cdwdoris_workload_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | n/a | `string` | `""` | no |
| <a name="input_be_spec"></a> [be\_spec](#input\_be\_spec) | n/a | <pre>object({<br>    spec_name = string # "S_4_16_P"<br>    count     = number # 3<br>    disk_size = number # 200<br>  })</pre> | <pre>{<br>  "count": 3,<br>  "disk_size": 200,<br>  "spec_name": "S_4_16_P"<br>}</pre> | no |
| <a name="input_case_sensitive"></a> [case\_sensitive](#input\_case\_sensitive) | Whether the table name is case sensitive, 0 refers to sensitive, 1 refers to insensitive, compared in lowercase; 2 refers to insensitive, and the table name is changed to lowercase for storage. | `number` | `1` | no |
| <a name="input_charge_properties"></a> [charge\_properties](#input\_charge\_properties) | n/a | <pre>object({<br>    charge_type = string # PREPAID for prepayment, and POSTPAID_BY_HOUR for post payment.<br>    time_span   = optional(number, 1)<br>    time_unit   = optional(string, "m")<br>    renew_flag =  optional(number, 1)<br>  })</pre> | <pre>{<br>  "charge_type": "POSTPAID_BY_HOUR"<br>}</pre> | no |
| <a name="input_create_instance"></a> [create\_instance](#input\_create\_instance) | n/a | `bool` | `true` | no |
| <a name="input_doris_user_pwd"></a> [doris\_user\_pwd](#input\_doris\_user\_pwd) | n/a | `string` | `""` | no |
| <a name="input_enable_multi_zones"></a> [enable\_multi\_zones](#input\_enable\_multi\_zones) | ) Whether to enable multi-availability zone. | `bool` | `false` | no |
| <a name="input_fe_spec"></a> [fe\_spec](#input\_fe\_spec) | n/a | <pre>object({<br>    spec_name = string # "S_4_16_P"<br>    count     = number # 3<br>    disk_size = number # 200<br>  })</pre> | <pre>{<br>  "count": 3,<br>  "disk_size": 200,<br>  "spec_name": "S_4_16_P"<br>}</pre> | no |
| <a name="input_ha_type"></a> [ha\_type](#input\_ha\_type) | High availability type: 0 indicates non-high availability (only one FE, FeSpec.CreateInstanceSpec.Count=1), 1 indicates read high availability (at least 3 FEs must be deployed, FeSpec.CreateInstanceSpec.Count>=3, and it must be an odd number), 2 indicates read and write high availability (at least 5 FEs must be deployed, FeSpec.CreateInstanceSpec.Count>=5, and it must be an odd number). | `number` | `1` | no |
| <a name="input_instance_id"></a> [instance\_id](#input\_instance\_id) | n/a | `string` | `""` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | n/a | `string` | `""` | no |
| <a name="input_product_version"></a> [product\_version](#input\_product\_version) | n/a | `string` | `"2.1"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `""` | no |
| <a name="input_workload_group_status"></a> [workload\_group\_status](#input\_workload\_group\_status) | Whether to enable resource group. open - enable, close - disable. | `string` | `"close"` | no |
| <a name="input_workload_groups"></a> [workload\_groups](#input\_workload\_groups) | n/a | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | n/a |
