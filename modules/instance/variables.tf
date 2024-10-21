variable "create_instance" {
  type = bool
  default = true
}
variable "instance_id" {
  type = string
  default = ""
}

variable "availability_zone" {
  type = string
  default = ""
}
variable "subnet_id" {
  type = string
  default = ""
}
variable "vpc_id" {
  type = string
  default = ""
}
variable "product_version" {
  type = string
  default = "2.1"
}
variable "instance_name" {
  type = string
  default = ""
}
variable "doris_user_pwd" {
  type = string
  default = ""
}
variable "ha_type" {
  type = number
  default = 1
  description = " High availability type: 0 indicates non-high availability (only one FE, FeSpec.CreateInstanceSpec.Count=1), 1 indicates read high availability (at least 3 FEs must be deployed, FeSpec.CreateInstanceSpec.Count>=3, and it must be an odd number), 2 indicates read and write high availability (at least 5 FEs must be deployed, FeSpec.CreateInstanceSpec.Count>=5, and it must be an odd number)."
}
variable "case_sensitive" {
  type = number
  default = 1
  description = "Whether the table name is case sensitive, 0 refers to sensitive, 1 refers to insensitive, compared in lowercase; 2 refers to insensitive, and the table name is changed to lowercase for storage."
}
variable "enable_multi_zones" {
  type = bool
  default = false
  description = ") Whether to enable multi-availability zone."
}
variable "workload_group_status" {
  type = string
  default = "close"
  description = "Whether to enable resource group. open - enable, close - disable."
}
variable "security_group_ids" {
  type = list(string)
  default = []
}
variable "charge_properties" {
  type = object({
    charge_type = string # PREPAID for prepayment, and POSTPAID_BY_HOUR for post payment.
    time_span   = optional(number, 1)
    time_unit   = optional(string, "m")
    renew_flag =  optional(number, 1)
  })
  default = {
    charge_type = "POSTPAID_BY_HOUR"
  }
}
variable "fe_spec" {
  type = object({
    spec_name = string # "S_4_16_P"
    count     = number # 3
    disk_size = number # 200
  })
  default = {
    spec_name = "S_4_16_P"
    count     = 3
    disk_size = 200
  }
}
variable "be_spec" {
  type = object({
    spec_name = string # "S_4_16_P"
    count     = number # 3
    disk_size = number # 200
  })
  default = {
    spec_name = "S_4_16_P"
    count     = 3
    disk_size = 200
  }
}

variable "workload_groups" {
  default = []
  type = any
}

variable "tags" {
  type = any
  default = []
}