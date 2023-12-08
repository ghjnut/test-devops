provider "google" {
  project     = var.google_project_id
  credentials = file("terraform-private-key.json")
}
