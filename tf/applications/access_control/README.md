Access Control Management
===========

Provisions basic user roles

Input Variables
---------------

- `environment` - environment identifier ("dev", "prod")
- `google_project_id` - project_id to provision to
- `google_data_user` - user (user@email.com) to add to data role

Usage
-----

```bash
terraform apply -var-file env/<ENV>.tfvars
```

Outputs
=======

 - `data_role_id` - id of the custom data role


Notes
=====

### Authentication
(https://cloud.google.com/docs/authentication#auth-decision-tree)

local: "Impersonate a 'service account'"
ci/cd: "Attach a 'service account'"

### IAM policies for Projects
(https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam.html)

1. (create new role with desired permissions, or use existing role)
2. Use `google_project_iam_binding` or `google_project_iam_member`
	- `google_project_iam_binding` supports multiple users/service_accs, but authoritative for the `role`
	- `google_project_iam_member` is per-user and non-destructive
3. Add constraints (to either)

#### Authoritative 
**DESTRUCTIVE**
- **UBER-DESTRUCTIVE** `google_project_iam_policy`
- `google_project_iam_binding`
- `google_project_iam_audit_config`

#### Non-Authoritative
- `google_project_iam_member`

### IAM policy for Service Account
(https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam)


#### Authoritative
- `google_service_account_iam_policy`
- `google_service_account_iam_binding`

#### Non-Authoritative
- `google_service_account_iam_member`


Authors
=======
test@company.com
