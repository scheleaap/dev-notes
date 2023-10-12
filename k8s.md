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

See [kubeconfig-1password.sh](./installation/kubeconfig-1password.sh).
