# OpenSSL

## Viewing a certificate

`openssl x509 -in /tmp/certs/server-cert.pem -text -noout`


## Creating a CSR

```
openssl genrsa -out $USER.key 4096 && openssl req -new -sha256 -key $USER.key -out $USER.csr
```

## Check if a certificate matches a private key?

Source: https://www.ssl247.com/kb/ssl-certificates/troubleshooting/certificate-matches-private-key

For your SSL certificate: `openssl x509 -in <certificate>.crt -noout -modulus | openssl md5`

For your RSA private key: `openssl rsa -in <private key>.key -noout -modulus | openssl md5`

For your CSR: `openssl req -in <csr>.csr -noout -modulus | openssl md5`