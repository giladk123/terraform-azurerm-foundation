module "resource-group" {
  source = "./modules/resource-group"

  resource_groups = var.resource_groups
  
}

module "vnet" {
  source = "./modules/vnet"

  vnets = var.vnets

  depends_on = [module.resource-group]
}