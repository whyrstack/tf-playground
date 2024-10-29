## Playground
Create AWS infrastructure for labbing purposes.

The services have been setup to use tf-modules that can easily be commented out if not required.

## Prerequisites
- AWS Account
- EC2 SSH key
- Setup tfvars (or veriables.tf)

## Commands
```bash
# SSH #
$ ssh -i <path-to-.pem> ubuntu@<pub_ip>

# EFS #
$ sudo mount -t efs -o tls,accesspoint=fsap-xxxx fs-xxxx:/ /mnt/efs
```