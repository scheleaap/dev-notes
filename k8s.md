# Kubernetes / Minikube Cheat Sheet

Follow logs:

kubectl -n <namespace> logs -f <pod?>



minikube start --vm-driver kvm2
minikube ssh
minikube stop
minikube delete
minikube dashboard
minikube service hello-minikube --url

kubectl cluster-info
kubectl config view
cat ~/.minikube/machines/minikube/config.json
kubectl get nodes
kubectl describe node
kubectl get pods
kubectl expose deployment first-deployment --port=80 --type=NodePort
export PORT=$(kubectl get svc first-deployment -o go-template='{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}') \
  && echo "Accessing host01:$PORT" \
  && curl host01:$PORT

Delete a namespace and everything in it:
```bash
kubectl -n local-integrationhub delete --all all
kubectl delete namespace local-integrationhub
```
