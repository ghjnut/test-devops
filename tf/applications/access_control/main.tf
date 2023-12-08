# redundant? keep for referential integrity
#data "google_project" "test" {
#  project_id = var.google_project_id
#}

# can probably just use role/owner
#resource "google_project_iam_custom_role" "admin" {
#  role_id     = "admin"
#  title       = "Administrator"
#  description = ""
#  permissions = [""]
#}

# https://console.cloud.google.com/iam-admin/roles/details/roles%3Ccompute.osLogin
resource "google_project_iam_custom_role" "backend" {
  role_id = "${var.env}Backend"
  title   = "${var.env} Backend Engineer"
  # TODO
  permissions = [""]
}
resource "google_project_iam_custom_role" "frontend" {
  role_id = "${var.env}Frontend"
  title   = "${var.env} Frontend Engineer"
  # TODO
  permissions = [""]
}

# TODO: good starting place for perms
# https://console.cloud.google.com/iam-admin/roles/details/roles%3Cdatastore.user
resource "google_project_iam_custom_role" "data" {
  role_id = "${var.env}Data"
  title   = "${var.env} Data Engineer"
  # TODO
  permissions = [""]
}
resource "google_project_iam_custom_role" "machine_learning" {
  role_id = "${var.env}MachineLearning"
  title   = "${var.env} Machine Learning Engineer"
  # TODO
  permissions = [""]
}

# okay to use because we're using a custom role we have full control of
resource "google_project_iam_binding" "data_member" {
  project = var.google_project_id
  #project = data.google_project.test.project_id
  role = google_project_iam_custom_role.data.id

  members = [
    "user:${var.google_data_user}",
    #"user:<user-email>@<your-gcp-project-id>.iam.gserviceaccount.com",
  ]

  condition {
    # Restrict access to only United States regions
    title = "location-restriction"
    # TODO: Unsure if this works in the context of e.g. VPN
    expression  = "request.origin.attributes['region'] =~ '^us-'"
    description = "Restrict access to United States regions"
  }
}

# ALTERNATIVE (use for multiple role bindings)
#resource "google_project_iam_member" "member-role" {
#  for_each = toset([
#    "roles/cloudsql.admin",
#    "roles/secretmanager.secretAccessor",
#    "roles/datastore.owner",
#    "roles/storage.admin",
#  ])
#
#  role    = each.key
#  member  = "serviceAccount:${google_service_account.service_account_1.email}"
#  project = my_project_id
#}
