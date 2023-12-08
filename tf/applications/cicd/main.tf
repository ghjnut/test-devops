# TODO: modularize

# TODO: shared vs exclusive worker pools?
#resource "google_cloudbuild_worker_pool" "this" {
#  name     = "my-pool"
#  location = "europe-west1"
#  worker_config {
#    disk_size_gb   = 100
#    machine_type   = "e2-standard-4"
#    no_external_ip = false
#  }
#}

data "google_project" "project" {}

resource "google_service_account" "cloudbuild" {
  account_id = "cloudbuild"
}

resource "google_project_iam_member" "act_as" {
  project = data.google_project.project.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.cloudbuild.email}"
}

resource "google_project_iam_member" "logs_writer" {
  project = data.google_project.project.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cloudbuild.email}"
}

resource "google_cloudbuild_trigger" "service-account-trigger" {
  trigger_template {
    branch_name = var.github_branch_name
    repo_name   = var.github_repo_name
  }

  service_account = google_service_account.cloudbuild_service_account.id
  # see https://cloud.google.com/build/docs/build-config-file-schema
  filename = "cloudbuild.yaml"
  depends_on = [
    google_project_iam_member.act_as,
    google_project_iam_member.logs_writer
  ]
}

# TODO: advanced github-specific w/ build-steps
#resource "google_cloudbuild_trigger" "react-trigger" {
#  github {
#    owner = var.github_repo_owner
#    name  = local.name
#
#  }
#  ignored_files = [".gitignore"]
#  filename      = "cloudbuild.yaml"
#  #build {
#  #    step {
#  #    name       = "node"
#  #    entrypoint = "npm"
#  #    args       = ["install"]
#  #    }
#  #    step{...}
#  #    ...
#  #  }  //Advanced section
#  #substitutions = {
#  #	<key1>= "<value1>"    <key2> = "<value2>"
#  #}
#}
