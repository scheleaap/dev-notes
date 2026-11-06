# AWS

## CLI

Install the CLI:
```sh
cd "$(mktemp -d)"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
# or
mise use -g aws-cli@latest
```

Configure profiles:
`aws configure sso`

To set a default profile:
`export AWS_PROFILE=AdministratorAccess-123456789012`

## Helpers

```sh
pipx install aws-sso-util
pipx install awsume
```

Then, configure this alias:
```
alias awsume=". awsume"
```

## Lambda RIE

```sh
curl -Lo ~/.local/bin/aws-lambda-rie \
  https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie \
  && chmod +x ~/.local/bin/aws-lambda-rie
```