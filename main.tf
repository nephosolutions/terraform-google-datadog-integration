#   Copyright 2019 NephoSolutions SPRL, Sebastian Trebitz
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

module "service_account_datadog" {
  source  = "nephosolutions/iam-service-account/google"
  version = "2.0.0"

  account_id   = "datadog"
  display_name = "Datadog integration"
  project_id   = var.project_id

  create_service_account_key_pair = true

  pgp_key = ""
}

locals {
  service_account_datadog_project_roles = [
    "roles/compute.viewer",
    "roles/container.viewer",
    "roles/monitoring.viewer",
  ]
}

resource "google_project_iam_member" "service_account_datadog" {
  count = length(local.service_account_datadog_project_roles)

  project = var.project_id
  role    = local.service_account_datadog_project_roles[count.index]
  member  = "serviceAccount:${module.service_account_datadog.email}"
}

resource "datadog_integration_gcp" "project" {
  project_id     = var.project_id
  private_key    = jsondecode(base64decode(module.service_account_datadog.private_key))["private_key"]
  private_key_id = jsondecode(base64decode(module.service_account_datadog.private_key))["private_key_id"]
  client_email   = module.service_account_datadog.email
  client_id      = module.service_account_datadog.unique_id
  host_filters   = join(",", sort(var.host_filters))
}
