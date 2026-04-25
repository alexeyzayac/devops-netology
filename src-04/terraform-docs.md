## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_analytics_vm"></a> [analytics\_vm](#module\_analytics\_vm) | git::https://github.com/udjin10/yandex_compute_instance.git | main |
| <a name="module_marketing_vm"></a> [marketing\_vm](#module\_marketing\_vm) | git::https://github.com/udjin10/yandex_compute_instance.git | main |
| <a name="module_vpc_dev"></a> [vpc\_dev](#module\_vpc\_dev) | ./vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [template_file.cloudinit](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | Идентификатор облака Яндекс Облака | `string` | `"b1guknff8nknnqp3g18s"` | no |
| <a name="input_default_cidr"></a> [default\_cidr](#input\_default\_cidr) | Список CIDR-блоков для подсети | `list(string)` | <pre>[<br/>  "10.0.1.0/24"<br/>]</pre> | no |
| <a name="input_default_zone"></a> [default\_zone](#input\_default\_zone) | Зона доступности по умолчанию | `string` | `"ru-central1-a"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Идентификатор каталога Яндекс Облака | `string` | `"b1gb00710li9ve0ujpkm"` | no |
| <a name="input_token"></a> [token](#input\_token) | OAuth-токен Яндекс Облака | `string` | n/a | yes |
| <a name="input_vms_ssh_root_key"></a> [vms\_ssh\_root\_key](#input\_vms\_ssh\_root\_key) | Публичный SSH-ключ для доступа к виртуальным машинам | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Название VPC сети и подсети | `string` | `"develop"` | no |

## Outputs

No outputs.
