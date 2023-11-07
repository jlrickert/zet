# How to upload a SSH key pair from the CLI to AWS

I ran into a scenario where I wanted to upload a previously created key on AWS.
The issue was that it was a private public keypair in pem format. It appears
that AWS only allows uploading public keys from the CLI. This is the steps that
I took to upload it.

```bash
ssh-keygen -f test-keypair.pem -y > test-key.pub
aws ec2 import-key-pair --key-name test-key --public-key-material fileb://test-key.pub
```

## Meta

    tags: #aws
