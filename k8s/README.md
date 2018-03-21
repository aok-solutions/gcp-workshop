# K8S Deployment

### Creating Deployment
```shell
kubectl create -f https://raw.githubusercontent.com/tomqwu/gcp-workshop/a-k8s/k8s/gcp-workshop.yml
```


### Rolling update for deployment

```shell
kubectl set image deployments/gcp-workshop gcp-workshop=tomqwu/gcp-workshop:0.0.2
```
