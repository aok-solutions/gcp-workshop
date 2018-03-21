apiVersion: apps/v1beta2
kind: Deployment
metadata:
  name: ${name}
  labels:
    App: ${name}
spec:
  replicas: 3
  selector:
    matchLabels:
      App: ${name} 
  template:
    metadata:
      labels:
        App: ${name}
    spec:
      containers:
      - name: ${name}
        image: tomqwu/gcp-workshop:0.0.1
        ports:
        - containerPort: 3000
        env:
        - name: GITSHA
          value: "83262352"
