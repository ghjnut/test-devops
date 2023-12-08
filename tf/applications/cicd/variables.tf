# gce

variable "google_project_id" {
  type = string
}

variable "github_repo_name" {
  type    = string
  default = "test"
}

variable "github_branch_name" {
  type    = string
  default = "test"
}
