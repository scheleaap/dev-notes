# Prometheus

## promtool

Latest `promtool` version:
```sh
VERSION=$(curl -Ls https://api.github.com/repos/prometheus/prometheus/releases/latest | jq ".tag_name" --raw-output | cut -c2-)
cd ~/.local/bin && wget -qO- "https://github.com/prometheus/prometheus/releases/download/v${VERSION}/prometheus-$VERSION.linux-amd64.tar.gz" \
  | tar xvzf - "prometheus-$VERSION.linux-amd64"/promtool --strip-components=1
```
