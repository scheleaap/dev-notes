# AWS

Install the CLI:
```sh
cd "$(mktemp -d)"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

Configure profiles:
`aws configure sso`

To set a default profile:
`export AWS_PROFILE=AdministratorAccess-123456789012`
