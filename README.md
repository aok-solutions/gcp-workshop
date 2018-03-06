# GCP/Kubernetes (k8s)/Terraform Workshop

## Areas to cover

* Google Cloud
* k8s Deployment
* k8s Service
* k8s Rolling Update
* Infrastructure as code (Terraform)

## Rules of Engagement

* Let's do pairing
* We will provision infrastructure and application via Google Cloud Console and command line first then automate the infrastructure as code using Terraform at end

## Things are provided to the teams

* Dockerfile for `gcp-workshop` app
* `Makefile` for building and running `gcp-workshop` app locally
* Pre-built Docker images [tomqwu/gcp-workshop](https://hub.docker.com/r/tomqwu/gcp-workshop/) with tags `0.0.1` and `0.0.2`
<<<<<<< HEAD
* Terraform and k8s code are commited in branches in case you are stuck
=======
>>>>>>> update README

## How to run `gcp-workshop` app locally

```shell
make build
make run
```

## Part A: Deploy A Two-tier `gcp-workshop` app

> Deploy a two-tier node.js app on Google Kubernetes Engine (GKE), approximately 45-90 mins

1.  [Install Gcloud SDK](https://cloud.google.com/sdk/docs/quickstart-macos)
    * **Definition of Done**
      * Able to install and init
1.  [Create Project and GKE cluster](https://cloud.google.com/kubernetes-engine/docs/concepts/kubernetes-engine-overview)
    * **Definition of Done**
      * GKE cluster is in a healthy state
      * Configure `kubectl` command line access GKE cluster
1.  _Optional/Bonus_: Use Makefile to build docker image locally and push to Google Container Registry (GCR)
<<<<<<< HEAD
    * **Definition of Done**
      * images should be able be pulled and ran locally and on GKE cluster
1.  Create and apply Kubernetes Deployment (or Replication Controller) and Service definition yaml
    * Use `kubectl` to create deploy both deployment and service
    * [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) or [Replication Controller](https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/)
    * [Service](https://kubernetes.io/docs/concepts/services-networking/service/)
      * Should be able to connect to GKE cluster via gcloud and `kubectl` in cli
1.  Use Makefile to build docker image locally and push to Google Container Registry (GCR) OR you may use prebuild `tomqwu/gcp-workshop:0.0.1` and `tomqwu/gcp-workshop:0.0.2` image
=======
>>>>>>> update README
    * **Definition of Done**
      * images should be able be pulled and ran locally and on GKE cluster
1.  Create and apply Kubernetes Deployment (or Replication Controller) and Service definition yaml
    * Use `kubectl` to create deploy both deployment and service
    * [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) or [Replication Controller](https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/)
    * [Service](https://kubernetes.io/docs/concepts/services-networking/service/)
    * **Definition of Done**
      * gcp-workshop replication set (3 pods) should be deployed on GKE with healthy status
      * exposed with external IP via service
      * the app is accessible via browser with correct information displayed
1.  Perform a rolling update on GKE cluster with different docker image tag
<<<<<<< HEAD

=======
>>>>>>> update README
    * [Rolling Update](https://kubernetes.io/docs/tasks/run-application/rolling-update-replication-controller/)
    * Check the content changes and downtime
    * **Definition of Done**
      * use `kubectl` to perform rolling update on `gcp-workshop` app
      * should be able to observe the content changes without downtime

1.  Implement infrastructure as code via Terraform
<<<<<<< HEAD

    * [Install Terraform](https://www.terraform.io/intro/getting-started/install.html)
    * Create Backend
      * Create Google Storage Bucket
=======
    * [Install Terraform](https://www.terraform.io/intro/getting-started/install.html)
    * Create Backend
>>>>>>> update README
      * [Google Storage Bucket](https://www.terraform.io/docs/backends/types/gcs.html)
    * Create Provider(s)
      * [Google Cloud](https://www.terraform.io/docs/providers/google/index.html)
      * [kubernetes](https://www.terraform.io/docs/providers/kubernetes/index.html)
    * Create Resources
      * [GKE](https://www.terraform.io/docs/providers/google/r/container_cluster.html#)
      * [Storage Bucket](https://www.terraform.io/docs/providers/google/r/storage_bucket.html)
      * [Registry Repo](https://www.terraform.io/docs/providers/google/d/google_container_registry_repository.html)
    * **Definition of Done**
<<<<<<< HEAD

      * The k8s cluster should be provisioned via Terraform
      * Terraform state should be stored in Google Storage Bucket
      * `gcp-workshop` app should be provisioned via
        * `kubectl create`
        * _or_ Terraform `kubernetes provisioner`
      * **Bonus** - `gcp-workshop` is accessible via endpoint after `terraform apply` without any manual/GUI steps
      * **Bonus** - Refactor terraform to use modules and organize the project to match the environment/organization and the infrastructure structure

            ├── README.md
            ├── live
            │   ├── dev
            │   │   └── us-central1
            │   │       ├── nodeapp-k8s
            │   │       │   ├── README.md
            │   │       │   ├── main.tf
            │   │       │   ├── terraform.tfvars
            │   │       │   └── variables.tf
            │   │       └── nodeapp-mig
            │   ├── mgmt
            │   ├── production
            │   └── staging
            └── modules
                ├── lb
                │   ├── README.md
                │   ├── main.tf
                │   ├── output.tf
                │   └── variables.tf
                └── nodeapp
=======
      * The k8s cluster should be provisioned via Terraform
      * `gcp-workshop` app should be provisioned via
        * `kubectl create`
        * **Bonus** -  Terraform `kubernetes provisioner`
      * **Bonus** - `gcp-workshop` is available after `terraform apply` without any manual/GUI steps
>>>>>>> update README

## _Coming next ..._

### Part B: Deploy A Two-tier Node.js app with managed instance group

<<<<<<< HEAD
### Part C: TDD with Infrastructure as code
=======
### Part C: Refactor Terraform Code and multiply the environment

### Part D: TDD with Infrastructure as code
>>>>>>> update README
