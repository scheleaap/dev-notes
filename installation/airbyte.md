# Airbyte

EC2 instance setup:
```sh
sudo yum install -y docker && sudo usermod -a -G docker ec2-user && sudo systemctl start docker && sudo systemctl enable docker
exit
curl -LsfS https://get.airbyte.com | bash -
abctl local install --host ec2-3-123-17-110.eu-central-1.compute.amazonaws.com --port 80 --insecure-cookies
abctl local credentials
```