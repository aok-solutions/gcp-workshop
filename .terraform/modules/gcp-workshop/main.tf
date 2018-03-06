module "k8s" {
  source           = "../gke"
  name             = "${var.name}"
  zone             = "${var.zone}"
  node_count       = "${var.node_count}"
  additional_zones = "${var.additional_zones}"
  username         = "${var.username}"
  password         = "${var.password}"
  labels_owner     = "${var.labels_owner}"
  labels_env       = "${var.labels_env}"
}

provider "kubernetes" {
  host                   = "${module.k8s.endpoint}"
  username               = "${var.username}"
  password               = "${var.password}"
  client_certificate     = "${base64decode(module.k8s.client_certificate)}"
  client_key             = "${base64decode(module.k8s.client_key)}"
  cluster_ca_certificate = "${base64decode(module.k8s.cluster_ca_certificate)}"
}

resource "kubernetes_replication_controller" "rc" {
  metadata {
    name = "${var.name}"

    labels {
      App = "${var.name}"
    }
  }

  spec {
    replicas = 3

    selector {
      App = "${var.name}"
    }

    template {
      container {
        image = "${var.image}"
        name  = "${var.name}"

        port {
          container_port = 3000
        }

        env {
          name  = "GITSHA"
          value = "${var.gitsha}"
        }
      }
    }
  }
}

resource "kubernetes_service" "service" {
  metadata {
    name = "${var.name}"
  }

  spec {
    selector {
      App = "${kubernetes_replication_controller.rc.metadata.0.labels.App}"
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}
