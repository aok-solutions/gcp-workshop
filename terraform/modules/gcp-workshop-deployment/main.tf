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

data "template_file" "deploy" {
  template = "${file("${path.module}/kubernetes/gcp-workshop.yaml.tpl")}"

  vars {
    name = "${var.name}"
  }
}

resource "random_id" "random" {
  keepers {
    tm = "${timestamp()}"
  }

  byte_length = 8
}

resource "null_resource" "deploy" {
  triggers {
    id = "${random_id.random.hex}"
  }

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.name} --zone ${var.zone} --project ${var.project}"
  }

  provisioner "local-exec" {
    command = "kubectl apply -f - <<EOF\n${data.template_file.deploy.rendered}\nEOF"
  }
}

resource "kubernetes_service" "service" {
  metadata {
    name = "${var.name}"
  }

  spec {
    selector {
      App = "${var.name}"
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }

  depends_on = ["null_resource.deploy"]
}
