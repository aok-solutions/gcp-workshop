# k8s cheatsheet

### Creating Deployment
```shell
kubectl create -f gcp-workshop.yml

### Rolling update for replicate controller

```shell
kubectl get pods -l App=gcp-workshop-sandbox -L deployment
kubectl rolling-update gcp-workshop-sandbox -f gcp-workshop-rc-v2.yml
```

### Rolling update for deployment

```shell
kubectl set image deployments/gcp-workshop gcp-workshop=tomqwu/gcp-workshop:0.0.2
```
