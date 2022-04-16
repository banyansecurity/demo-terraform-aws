# Banyan Security demo for AWS environments using Terraform

## Prerequisities

To run this demo, you will need the following:

1. AWS account and credentials, and an EC2 key-pair
2. Terraform CLI 0.14.9+
3. Banyan account and admin API key, and a device with the Banyan Desktop App installed

For instructions on how to set these up, go to the [Prerequisities Details section](#prerequisities-details).

## Run it

Clone this repo to your machine. Edit the `locals.tf` file with details from your environment.

```tf
locals {
  name_prefix = "bnn-demo"

  region = "us-east-1"
  ssh_key_name = "YOUR_AWS_KEY_NAME"

  banyan_host = "https://team.console.banyanops.com/"
  banyan_api_key = "YOUR_BANYAN_API_KEY"
  banyan_org = "YOUR_BANYAN_ORG"
}
```

You can then run `terraform apply` to provision the entire stack in a single shot, or follow along step-by-step:

### Step 1 - Network

Get started by creating the network layer. This will provision a new VPC with just a private subnet.

```bash
terraform apply -target=module.network
```

### Step 2 - Database

Next, provision the database layer. This will provision an RDS instance in your VPC.

```bash
terraform apply -target=module.database
```

### Step 3 - Application

Next, provision the application layer. This will provision an EC2 instance in your VPC that runs a simple demo website container.

```bash
terraform apply -target=module.application
```

At the end of Step 3, you have a basic but representative AWS environment. Now we will set up Banyan to provide secure remote access to this environment.


### Step 4 - Banyan Connector

Deploy a Banyan Connector that will create an outbound connection to the Banyan Global Edge network, so you can manage access to your AWS environment.

```bash
terraform apply -target=module.banyan-connector
```

### Step 5 - Banyan Policies

Create a few roles and policies to establish which users and devices can access your AWS environment.

```bash
terraform apply -target=module.banyan-policies
```


### Step 6 - Banyan Services

Publish the services that are deployed in your AWS environment.

```bash
terraform apply -target=module.banyan-services
```

## Access your AWS resources

To access your AWS resources, open the Banyan App and check your services list. Click on a given service to connect to it.

TODO: Need image here.



## Prerequisities Details

### AWS

This demo requires an AWS account. If you don't already have an AWS account, you can create a [free AWS account](https://aws.amazon.com/free/).

Then, you need to download AWS credentials that will allow you automate infra provisioning. You can create a new Access Key via the [IAM section of the AWS console](https://console.aws.amazon.com/iam/home?#/security_credentials).

Check that your AWS account and credentials are set up correctly by installing the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html). [Configure the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) from your terminal to use your credentials.

Finally, you need an EC2 key-pair that you will use if you need to SSH into the instances. If you don’t have a EC2 key-pair, you can [create a key-pair via the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-services-ec2-keypairs.html#creating-a-key-pair).


### Terraform

This demo uses Terraform. Follow the [getting started in AWS tutorial](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) to install the Terraform CLI (v0.14.9+) and learn the basics of Terraform.


### Banyan

This demo shows you to how to use Banyan Security Zero Trust Remote Access. If you don't have a Banyan account, sign up for a [free Banyan account](https://www.banyansecurity.io/team-edition-signup/).

Note your Org name. Navigate to the API Keys section in the Banyan Command Center console and [create an admin API key](https://docs.banyansecurity.io/docs/banyan-components/command-center/api-keys/). Also, [install the Banyan Desktop App on your device](https://support.banyanops.com/support/solutions/folders/44000931532).




