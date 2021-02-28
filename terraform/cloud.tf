terraform {
  backend "remote" {
    organization = "other13"

    workspaces {
      name = "exam_itea"
    }
  }
}