terraform {
  source = "../../../../modules/aws/root"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  environment  = "production"
  project_name = "dummy"
  cluster_name = "dummy-${local.environment}-cluster"
}

inputs = {
  project_name = local.project_name
  cluster_name = local.cluster_name
}
