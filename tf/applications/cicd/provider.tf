provider "google" {
  credentials = file("terraform-private-key.json")

  project = var.google_project_id
}
