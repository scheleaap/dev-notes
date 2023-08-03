# Kubernetes

## kubelogin

Latest version:
```sh
version=$(curl -Ls https://api.github.com/repos/int128/kubelogin/releases/latest | jq ".tag_name" --raw-output | cut -c2-)
wget -q "https://github.com/int128/kubelogin/releases/download/v${version}/kubelogin_linux_amd64.zip" -O /tmp/kubelogin-${version}.zip \
&& unzip /tmp/kubelogin-${version}.zip -d /tmp/kubelogin-${version} \
&& mv /tmp/kubelogin-${version}/kubelogin ~/.local/bin/kubectl-oidc_login
```
