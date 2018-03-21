provider "google" {
  project = "gcp-workshop-197121"
  region  = "us-central1"
}

module "sandbox" {
  source           = "../../../../modules/gcp-workshop-rc"
  name             = "${var.name}"
  zone             = "${var.zone}"
  node_count       = "${var.node_count}"
  additional_zones = "${var.additional_zones}"
  username         = "${var.username}"
  password         = "${var.password}"
  labels_owner     = "${var.labels_owner}"
  labels_env       = "${var.labels_env}"
  image            = "${var.image}"
  gitsha           = "${var.gitsha}"
}

output "lb_ip" {
  value = "${module.sandbox.lb_ip}"
}
