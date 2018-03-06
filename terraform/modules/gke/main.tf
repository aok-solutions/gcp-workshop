resource "google_container_cluster" "primary" {
  name               = "${var.name}"
  zone               = "${var.zone}"
  initial_node_count = "${var.node_count}"
  additional_zones   = ["${var.additional_zones}"]

  master_auth {
    username = "${var.username}"
    password = "${var.password}"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      app   = "${var.name}"
      env   = "${var.labels_env}"
      owner = "${var.labels_owner}"
    }

    tags = ["k8s", "provisioning"]
  }

  enable_kubernetes_alpha = true
}
