# k8s cheatsheet

### Rolling update for replicate controller

```shell
kubectl rolling-update gcp-workshop-sandbox-v2 -f .k8s/gcp-workshop-rc.yml
```

### Rolling update for deployment

```shell
kubectl set image deployments/gcp-workshop gcp-workshop=tomqwu/gcp-workshop:0.0.2
```
