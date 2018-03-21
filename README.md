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
* Terraform and k8s code are commited in branches in case you are stuck

## How to run `gcp-workshop` app locally

```shell
make build
make run
```

## Prerequisites

> Setup all required tools and dependencies, approximately 10-15 minutes

1.  [Install Gcloud SDK](https://cloud.google.com/sdk/docs/quickstart-macos)
    * **Definition of Done**
      * Able to install and init
1.  [Create Project](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
    * **Definition of Done**
      * Able to deploy resources in project with project owner permission

## Part A: Deploy A Two-tier `gcp-workshop` app on Kubernetes

> Deploy a two-tier node.js app on Google Kubernetes Engine (GKE), approximately 45-90 mins

1.  [Create Kubernetes cluster in Kubernetes Engine](https://cloud.google.com/kubernetes-engine/docs/concepts/kubernetes-engine-overview)

    * Creat Kubernetes with default settings
    * Enable `kubectl` component via gcloud [components](https://cloud.google.com/sdk/gcloud/reference/components/install) install
    * Connect to Kubernetes cluster via gcloud, e.g. `gcloud container clusters get-credentials [cluster_name] --zone [Zone] --project [project_id]`, this will generate local `~/.kube/config` credential
    * **Definition of Done**
      * the cluster is up and in healthy running state
      * able to use `kubectl` interact with the cluster, e.g. `kubectl cluster-info` etc.

1.  _Optional/Bonus_: Use Makefile to build docker image locally and push to Google Container Registry (GCR)
    * **Definition of Done**
      * images should be able be pulled and ran locally and on GKE cluster
1.  Create and apply Kubernetes Deployment (or Replication Controller) and Service definition yaml
    * Use `kubectl` to create deploy both deployment and service
    * [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) or [Replication Controller](https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/)
    * [Service](https://kubernetes.io/docs/concepts/services-networking/service/)
    * **Definition of Done**
      * gcp-workshop replication set (3 pods) should be deployed on GKE with healthy status
      * exposed with external IP via service
      * the app is accessible via browser with hostname and commit# displayed
1.  Perform a rolling update on GKE cluster with different docker image tag
    * Rolling Update
      * [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-update-deployment) **Recommended**
      * [Replication Controller](https://kubernetes.io/docs/tasks/run-application/rolling-update-replication-controller/)
    * Check the content changes and downtime
    * **Definition of Done**
      * use `kubectl` to perform rolling update on `gcp-workshop` app
      * should be able to observe the content changes without downtime

> IMPORTANT: Before continuing on Part B, you should have basic knowledge of

* How to create a Kubernetes cluster via Google Console or cli
* What required **input** parameters are
* What available **output** values are, such as endpoint, credential etc.
* Able to deploy container app and service via `kubectl`

## Part B-1: Get started with Terraform

1.  Setup and initialize Terraform

    * [Install Terraform](https://www.terraform.io/intro/getting-started/install.html)
    * Create a sub-directory called `terraform`
    * Create Terraform backend in `backend.tf` to save Terraform state using [Google Storage Bucket](https://www.terraform.io/docs/backends/types/gcs.html)
      > TIP: You will need to create bucket first
    * Create Provider(s) in `main.tf`
      * [Google Cloud](https://www.terraform.io/docs/providers/google/index.html) provider
    * Run `terraform init`
    * **Definition of Done**
      * `terraform init` should run without error
      * Terraform state should be created in Google Storage Bucket
      * It looks like
        ```shell
        terraform
        ├── backend.tf
        └── main.tf
        ```

1.  Create GKE cluster

    * Create [GKE - Container Cluster](https://www.terraform.io/docs/providers/google/r/container_cluster.html#) in `main.tf`
    * **Definition of Done**
      * GKE cluster should be up and running in healhy state after `terraform apply`

1.  Application Provisioning
    * Two Provisioning Options:
      1.  Run Kubernetes deployment via [local-exec](https://www.terraform.io/docs/provisioners/local-exec.html) provisioner
          > TIP: Use `gcloud` authenticate and `kubectl` apply locally
      2.  _optionally_ Terraform [Replication Controller](https://www.terraform.io/docs/providers/kubernetes/r/replication_controller.html) resource via Terraform [Kubernetes Provider](https://www.terraform.io/docs/providers/kubernetes/index.html)
          > TIP: how do you pass Kubernetes cluster credentials to provisioner to interact with k8s api
    * **Definition of Done**
      * `gcp-workshop` is accessible via endpoint after `terraform apply` without any manual/GUI steps

## Part B-2: Make Terraform DRY

1.  Create Terraform Modules

    * Refactor terraform to use modules and organize the project to match the environment/organization and the infrastructure structure

          ├── README.md
          ├── live
          │   ├── dev
          │   │   └── us-central1
          │   │       ├── gcp-workshop
          │   │       │   ├── README.md
          │   │       │   ├── main.tf
          │   │       │   ├── terraform.tfvars
          │   │       │   └── variables.tf
          │   │       └── other-app
          │   ├── mgmt
          │   ├── production
          │   └── staging
          └── modules
              ├── k8s
              │   ├── README.md
              │   ├── main.tf
              │   ├── output.tf
              │   └── variables.tf
              └── gcp-workshop

    * Create `k8s` module
    * Create `gcp-workshop` module to use `k8s` module and provision `kubectl` via

1.  _Bonus_ - use [workspace](https://www.terraform.io/docs/state/workspaces.html) to manage environments like dev, staging or production instead of using directory namespaces

## _Coming next ..._

### Part C: Deploy a three-tier Node.js app with managed instance group

### Part D: TDD with Infrastructure as code
