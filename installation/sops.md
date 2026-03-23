# sops

```sh
sops_version_tag=$(curl -Ls https://api.github.com/repos/getsops/sops/releases/latest | jq ".tag_name" --raw-output)
curl -Ls "https://github.com/getsops/sops/releases/download/${sops_version_tag}/sops-${sops_version_tag}.linux.amd64" -o "$HOME/.local/bin/sops"
chmod +x "$HOME/.local/bin/sops"
```
