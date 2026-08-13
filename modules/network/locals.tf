locals {
  az_count         = length(var.az)
  required_subnets = local.az_count * 2
  dynamic_newbits  = ceil(log(local.required_subnets, 2))
}
