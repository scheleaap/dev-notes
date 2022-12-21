# Kubernetes / Minikube Cheat Sheet

What | Description
--- | ---
Follow logs | `kubectl -n <namespace> logs -f <pod>`
Get the node a pod is running on | `kubectl get pod -o jsonpath='{.items[0].spec.nodeName}'`
Get the node each pod is running on | `kubectl get pod -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.nodeName}{"\n"}{end}'`
Instantiate a cronjob | `kubectl create job --from=cronjob/<myjob> <myjob>-$(date +%s)-manual`
See all pods not running or completed | `kubectl get pod --all-namespaces | grep -Ev '(Running|Completed)'`

Run a pod with `kubectl run` with volumes:
```sh
kubectl run -n dev-analyticshub wout-experiment --rm -it --image ubuntu --restart=Never --overrides='
{
    "spec": {
        "containers": [
            {
                "stdin": true,
                "tty": true,
                "args": [ "bash" ],
                "name": "wout-experiment",
                "image": "ubuntu",
                "volumeMounts": [
                    {
                        "mountPath": "/tmp/foo",
                        "name": "test-volume"
                    }
                ]
            }
        ],
        "volumes": [
            {
                "name": "test-volume",
                "emptyDir": {
                    "sizeLimit": "500Gi"
                }
            }
        ]
    }
}
'
```
Source: https://gist.github.com/ctaggart/c372783291162d9c0b8e40441ab14845

## Kubeconfig management

Merging multiple files into one config file:
```sh
vault_uuid=pvdicrklimc4is66zcok44wyca
mkdir $HOME/.kube/config.d
for uuid in $(op list items --vault $vault_uuid | jq '.[].uuid' --raw-output); do
    name=$(op get item $uuid | jq '.overview.title' --raw-output | cut -d' ' -f3)
    op get item $uuid | jq '.details.sections[0].fields[] | select(.t=="~/.kube/config").v' --raw-output > $HOME/.kube/config.d/$name
done
kubeconfigs=""
for f in $(ls $HOME/.kube/config.d); do
    kubeconfigs+="$HOME/.kube/config.d/$f:"
done
KUBECONFIG=$kubeconfigs kubectl config view --flatten > $HOME/.kube/config
chmod 600 $HOME/.kube/config
```

Extracting a context:
```sh
kubectl config view --minify --flatten --context=minikube
```
