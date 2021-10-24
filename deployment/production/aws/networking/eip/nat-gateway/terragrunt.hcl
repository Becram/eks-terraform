terraform {
  source = "../../../../../../modules/aws/networking/eip"
}

include {
  path = find_in_parent_folders("root.hcl")
}

prevent_destroy = false

inputs = {
  eip_count = 1
  eip_name  = "nat-gateway"
  vpc       = true
}
