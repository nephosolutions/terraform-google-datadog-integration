# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

## [2.1.0] - 2021-01-13

- Add Terraform 0.13 compatibility
- enable required Google Cloud Platform service APIs
- update required project IAM roles granted to the service account

## [2.0.0] - 2019-09-18

- Update to nephosolutions/iam-service-account/google v3.0.0
- Loop over `for_each` sets instead of `count` lists when assigning IAM roles to the service account

## [1.0.0] - 2019-08-01

- Initial release

[Unreleased]: https://github.com/nephosolutions/terraform-google-gcp-project/compare/v2.1.0...HEAD
[2.1.0]: https://github.com/nephosolutions/terraform-google-gcp-project/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/nephosolutions/terraform-google-gcp-project/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/nephosolutions/terraform-google-gcp-project/releases/tag/v1.0.0
