# JQ examples

```
cat data.json | jq '.details.fields[] | select(.designation=="password").value' --raw-output
```

Complex example with:
* mapping
* filtering
* merging
```
kubectl get scheduledsparkapplications.sparkoperator.k8s.io --all-namespaces -o json | jq '.items | map({ uid: .metadata.uid, name: .metadata.name, namespace: .metadata.namespace, "cron-schedule": .spec.schedule })' > /tmp/ssa

kubectl get sparkapplications.sparkoperator.k8s.io --all-namespaces -o json | jq '.items | map(select(.status.applicationState.state == "COMPLETED") | { uid: .metadata.ownerReferences[0].uid, start: .status.lastSubmissionAttemptTime, finish: .status.terminationTime })' > /tmp/sa

jq -s '[ .[0] + .[1] | group_by(.uid)[] | add | del(.uid) ]' /tmp/ssa /tmp/sa
# or:
jq -s '.[0] + .[1] | group_by(.uid)[] | add | del(.uid) | .namespace + "," + .name + "," + ."cron-schedule" + "," + .start + "," + .finish' --raw-output /tmp/ssa /tmp/sa
```
