# Datadog for Google Cloud Platform project Terraform module

This Terraform module integrates a Google Cloud Platform project into Datadog

## Usage

```hcl
module "datadog_integration" {
  source  = "nephosolutions/datadog-integration/google"
  version = "2.1.1"

  project_id   = "..."
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| datadog | >= 1.9 |
| google | >= 2.10 |
| random | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| datadog | >= 1.9 |
| google | >= 2.10 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| host\_filters | List of key:value pairs for host tags / labels to filter Datadog montoring | `list(string)` | `[]` | no |
| project\_id | The ID of the GCP project that the service account will be created in. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| host\_filters | Datadog monitoring host filters |
| service\_account\_email | Datadog IAM service account email |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
