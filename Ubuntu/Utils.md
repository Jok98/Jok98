## SSH Key

| Algorithm     | Public key         | Private key       |
|---------------|--------------------|-------------------|
| ED25519       | id_ed25519.pub     | id_ed25519        |
| ED25519\_SK   | id_ed25519_sk.pub  | id_ed25519_sk     |
| ECDSA\_SK     | id_ecdsa_sk.pub    | id_ecdsa_sk       |

### Generate SSH Key
`ED25519`
```bash
ssh-keygen -t ed25519 -C "<comment>"
```

`2048-bit RSA`
```bash
ssh-keygen -t rsa -b 2048 -C "<comment>"
```

`output`
```bash
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/user/.ssh/id_ed25519):
```

`Specify a passphrase`
```bash
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
```

### Update SSH Key
```bash
ssh-keygen -p -f /home/user/.ssh/
```


