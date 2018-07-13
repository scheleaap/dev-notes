# OpenSSL

## Creating a CSR

```
openssl genrsa -out $USER.key 4096 && openssl req -new -sha256 -key $USER.key -out $USER.csr
```
