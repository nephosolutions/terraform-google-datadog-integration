# Copyright 2021 NephoSolutions srl, Sebastian Trebitz
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

locals {
  project_id = var.project_id != "" ? var.project_id : null
  project_roles = [
    "roles/cloudasset.viewer",
    "roles/compute.viewer",
    "roles/monitoring.viewer",
  ]
  project_services = [
    "cloudasset.googleapis.com",
    "cloudbilling.googleapis.com",
    "compute.googleapis.com",
    "monitoring.googleapis.com",
  ]
}

module "service_account" {
  source  = "nephosolutions/iam-service-account/google"
  version = "3.0.0"

  display_name = "Datadog integration"
  project_id   = local.project_id
}

resource "google_project_service" "required" {
  for_each = toset(local.project_services)

  disable_on_destroy = false
  service            = each.key
}

resource "google_service_account_key" "datadog" {
  service_account_id = module.service_account.email
}

resource "google_project_iam_member" "service_account" {
  for_each = toset(local.project_roles)

  project = local.project_id
  role    = each.value
  member  = "serviceAccount:${module.service_account.email}"
}

resource "datadog_integration_gcp" "project" {
  project_id     = jsondecode(base64decode(google_service_account_key.datadog.private_key))["project_id"]
  private_key    = jsondecode(base64decode(google_service_account_key.datadog.private_key))["private_key"]
  private_key_id = jsondecode(base64decode(google_service_account_key.datadog.private_key))["private_key_id"]
  client_email   = jsondecode(base64decode(google_service_account_key.datadog.private_key))["client_email"]
  client_id      = jsondecode(base64decode(google_service_account_key.datadog.private_key))["client_id"]
  host_filters   = join(",", sort(var.host_filters))
}
