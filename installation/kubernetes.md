# Kubernetes

## kubefwd

Latest version:
```sh
version=$(curl -Ls https://api.github.com/repos/txn2/kubefwd/releases/latest | jq ".tag_name" --raw-output)
wget -q "https://github.com/txn2/kubefwd/releases/download/${version}/kubefwd_amd64.deb" -O /tmp/kubefwd-${version}.deb \
&& dpkg --install /tmp/kubefwd-${version}.deb
```

## kubelogin

Latest version:
```sh
version=$(curl -Ls https://api.github.com/repos/int128/kubelogin/releases/latest | jq ".tag_name" --raw-output)
wget -q "https://github.com/int128/kubelogin/releases/download/${version}/kubelogin_linux_amd64.zip" -O /tmp/kubelogin-${version}.zip \
&& unzip /tmp/kubelogin-${version}.zip -d /tmp/kubelogin-${version} \
&& mv /tmp/kubelogin-${version}/kubelogin ~/.local/bin/kubectl-oidc_login
```
