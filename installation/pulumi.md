# Pulumi

```sh
VERSION=$(curl -Ls https://api.github.com/repos/pulumi/pulumi/releases/latest | jq ".tag_name" --raw-output | cut -c2-)
cd "$(mktemp -d)"
curl -Ls "https://github.com/pulumi/pulumi/releases/download/v${VERSION}/pulumi-v$VERSION-linux-x64.tar.gz" -o pulumi.tar.gz
tar xvzf pulumi.tar.gz
cp -r pulumi/* $HOME/.local/bin
```
