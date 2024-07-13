## Usage

This is a foundation module that creates a spoke 
the module creates a resource group/s and vnet/s with subnets.
this module also include submodules that can be used to create resources inside the spoke.


```terraform

locals {
  resource_group          = jsondecode(file("./ccoe/rg.json"))
  vnet_settings           = jsondecode(file("./network/vnet.json"))
}

module "spoke" {
  source  = "app.terraform.io/hcta-azure-dev/spoke/azurerm"
  version = "<version>"
 
  resource_groups = local.resource_group.resource_groups
  vnets = local.vnet_settings.vnets
  providers = {
    azurerm = azurerm.<alias>
  }
}
```

Jsons Examples:

rg.json:

```json
{
    "resource_groups": {
        "<resource group name>": {
            "rg_location": "West Europe",
            "rg_tags": {
                "environment": "dev"
            }
        },
        "<resource group name>": {
            "rg_location": "West Europe",
            "rg_tags": {
                "environment": "dev"
            }
        }
    }
}
```

vnet.json:

```json
{
    "vnets": {
        "<vnet name>": {
            "resource_group_name": "resource group name",
            "location": "westeurope",
            "address_space": ["10.62.252.0/24"],
            "tags": {"environment": "dev"},
            "subnets": [
                {"name": "<subnet_1_name>", "address_prefix": "10.62.252.0/28"},
                {"name": "<subnet_2_name>", "address_prefix": "10.62.252.16/28"}
        ]
        },
        "<vnet name>": {
            "resource_group_name": "<resource group name>",
            "location": "westeurope",
            "address_space": ["10.62.253.0/24"],
            "tags": {"environment": "dev"},
            "subnets": [
                {"name": "<subnet_1_name>", "address_prefix": "10.62.253.0/28"},
                {"name": "<subnet_2_name>", "address_prefix": "10.62.253.16/28"}
        ]
        }
    }
}
```

Outputs Examples:

```terraform
output "resource-groups" {
  value = module.spoke.resource-groups
  description = "value of resource-groups"
}

output "vnets" {
  value = module.spoke.vnets
  description = "value of vnets"
}

output "subnets" {
  value       = module.vnet.subnet
  description = "shows All subnets created in the subscription"
}

```



## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.81.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource-group"></a> [resource-group](#module\_resource-group) | ./modules/resource-group | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | ./modules/vnet | n/a |
| <a name="module_keyvault"></a> [keyvault](#module\_keyvault) | ./modules/keyvault | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_keyvaults"></a> [keyvaults](#input\_keyvaults) | The keyvaults to create | `map(any)` | n/a | yes |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | Map of resource group details | <pre>map(object({<br>    rg_location = string<br>    rg_tags     = map(string)<br>  }))</pre> | n/a | yes |
| <a name="input_vnets"></a> [vnets](#input\_vnets) | n/a | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource-groups"></a> [resource-groups](#output\_resource-groups) | shows All resource groups created in the subscription |
| <a name="output_vnets"></a> [vnets](#output\_vnets) | shows All vnets created in the subscription |
