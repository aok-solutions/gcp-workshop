# GCP/Kubernetes (k8s)/Terraform Workshop

## Areas to cover

* Google Cloud
* k8s Deployment
* k8s Service
* k8s Rolling Update
* Infrastructure as code (Terraform)

## Rules of Engagement

* Let's do pair
* Try using cli and scriptive approach as much as possible
* Use Google Cloud Console GUI if you are not familar with input and output of each component

## How to run the `gcp-workshop` app

### Build and run locally

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
      * Should be able to connect to GKE cluster via gcloud and `kubectl` in cli
1.  Use Makefile to build docker image locally and push to Google Container Registry (GCR) OR you may use prebuild `tomqwu/gcp-workshop:0.0.1` and `tomqwu/gcp-workshop:0.0.2` image
    * **Definition of Done**
      * should be able to ready to run two versions of gcp-workshop docker images locally and on kubernetes
1.  Apply provided definition yaml to GKE cluster
    * **Definition of Done**
      * gcp-workshop replication set (3 pods) should be deployed on GKE with healthy status
      * exposed with external IP via service
      * the app is accessible via browser with correct information displayed
1.  Make change to the Node.js app and do rolling update on GKE cluster

    * [Rolling Update](https://kubernetes.io/docs/tasks/run-application/rolling-update-replication-controller/)
    * Check the content changes and downtime
      * `for ((i=1;i<=100;i++)); do curl -v --header "Connection: keep-alive" "http://[external_ip]:3000"; done`
    * **Definition of Done**
      * use `kubectl` to perform rolling update on `gcp-workshop`
      * should be able to observe the content changes without downtime

1.  Implement infrastructure as code via Terraform
    * Backend
      * [Google Storage Bucket](https://www.terraform.io/docs/backends/types/gcs.html)
    * Provider
      * [Google Cloud](https://www.terraform.io/docs/providers/google/index.html)
      * [kubernetes](https://www.terraform.io/docs/providers/kubernetes/index.html)
    * Resource
      * [GKE](https://www.terraform.io/docs/providers/google/r/container_cluster.html#)
      * [Storage Bucket](https://www.terraform.io/docs/providers/google/r/storage_bucket.html)
    * **Definition of Done**
      * The k8s cluster should be provided via Terraform
      * Initial k8s `gcp-workshop` app and service should be provisioned via provisioner (`local-exec` with `kubectl`) or `kubernetes` provider
      * `gcp-workshop` should be available after `terraform apply` without any manual steps
