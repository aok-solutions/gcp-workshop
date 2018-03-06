terraform {
  backend "gcs" {
    bucket = "tf-state-workshop"
    prefix = "terraform/state"
  }
}
