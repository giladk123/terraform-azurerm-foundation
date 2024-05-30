resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups

  name     = "${each.value.region}-${each.value.tnnt_env}-azus-${each.value.cmdb_prj}-${each.value.rg_name}-rg"
  location = each.value.rg_location
  tags     = each.value.rg_tags
}