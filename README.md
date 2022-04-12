# Terraform secret management


## Description
Small example on how to manage safely secret in Terraform.

The only we might want to add to this is that when a remote state file is used it should be as well encrypted with KMS.

To encrypted the file here the command:
```
aws kms encrypt \
  --key-id <KMS ARN> \
  --region eu-west-1 \
  --plaintext fileb://creds.yaml \
  --output text \
  --query CiphertextBlob \
  > creds.yaml.encrypted
``` 

The plan looks like that:
```
tf_0.14.8 plan                                                                                                                  (git)-[master]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:

Terraform will perform the following actions:

Plan: 0 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + password_1 = "bar"
  + password_2 = "toto"
```

The secret file (which should not be commited) in plain text contains the following:
```yaml
---
mysecret:
  login: "foo"
  password: "bar"
my2dsecret:
  login: "titi"
  password: "toto"

```
