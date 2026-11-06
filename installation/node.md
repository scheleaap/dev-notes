# NodeJS etc.

## Mise

```sh
mise use node@24
mise exec -- node --version
mise settings add idiomatic_version_file_enable_tools node # Optionally add --local
```

## Node Version Manager (nvm)

```sh
nvm_version=0.40.3
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${nvm_version}/install.sh | bash

# For example
nvm install 24
```
