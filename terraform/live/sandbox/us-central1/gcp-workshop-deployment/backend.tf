terraform {
  backend "gcs" {
    bucket = "tf-state-workshop-deployment"
    prefix = "terraform/state"
  }
}
