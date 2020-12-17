---
title: 'Set Up Test and Production Networks'
menuTitle: '5. Set Up Test and Prod Networks'
disableToc: true
weight: 50
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this step your Cloud Administrators will review the solution's networking requirements and provision VPCs in the workload accounts if required.

{{% notice tip %}}
If you've determined that your initial workloads do not require VPC networking support, you can skip this section and proceed to [Onboard Workload Admins to Test and Production AWS Accounts]({{< relref "06-onboard-workload-admins" >}}).
{{% /notice %}}

This step should take about 60 minutes to complete.

{{< toc >}}

## 1. Determine initial network design

First, determine the overall topology of your VPC design in support of your test and production environments.

### Dedicated VPC for each test and production environment

As mentioned in the [Review Test and Production Environments Solution]({{< relref "01-review-test-prod-solution" >}}), it's recommended that you start with using a dedicated VPC per test and production environment.

### Availability zones

In those AWS regions in which at least 3 Availability Zones (AZs) are available for customer use, it's recommended that your initial set of VPCs have subnets in each of the 3 AZs so that your teams can leverage deployment architectures and AWS services that can take advantage of 3 AZs. At a minimum, we recommend using at least 2 AZs in each tier of your VPC.

### Public and private subnets

If you workloads in your test and production environments require either egress or ingress access to the internet, then it's recommended that you either establish a set of public subnets in your test and production VPCs or you consider alternative architectures.

As a starting point, the following steps walk you through setting up test and production VPCs that contain only private subnets.  Depending on your needs for internet integration, you can include public subnets and other resources in your initial VPC topology.

{{% notice note %}}
**Options for internet integration:** Draft Review Note: Provide references to existing AWS documentation, guides, and/or session videos that walk through the internet integration scenarios.
{{% /notice %}}

[![Test and Production Network Details](/images/05-test-prod/initial-foundation-test-prod-single-region.png?height=600px)](/images/05-test-prod/initial-foundation-test-prod-single-region.png)

## 2. Determine IP address CIDR blocks

If you have a formally assigned CIDR block to use, in this step you'll:
1. Review VPC topology
2. Determine VPC CIDR block
3. Determine subnet CIDR blocks
4. Document CIDR block usage

### 2.1 Review VPC topology

At a minimum, we recommend that you provision a topology of:
* A private tier of subnets
* 3 subnets for each tier
* Each subnet is associated with an Availability Zone (AZ) resulting in the use of 3 AZs.

In support of this topology, you will need to supply a CIDR block for each of the following:

* Overall VPC
* Private subnets 1, 2, and 3

To keep things simple, you can size the subnets identically.

If you need to provide internet access to workloads in your test and production VPCs, you'll need to account for a set of public subnets to be deployed in each AZ.

### 2.2 Determine VPC CIDR block

As a result of your up front tasks to [Obtain a Non-Overlapping IP Address Block]({{< relref "03-obtain-ip-address-range" >}}), your Network team may have already supplied a relatively large non-overlapping CIDR block for your use of AWS. 

Since you should strive to use non-overlapping CIDR ranges across all of your VPCs in AWS and your on-premises environments, you'll want to ensure that you identify a distinct set of CIDR blocks for your test and production VPCs.

Since you will be subdividing the CIDR block for each account into either 3 (private subnets only) or 6 (public + private subnets) subnets, try to allocate at least either a `/20` in the case of private only subnets or `/19` in the case of public + private subnets.

If you need to break down a larger block:

1. Access the [Visual Subnet Calculator](http://www.davidc.net/sites/default/subnets/subnets.html).
2. Enter your network address without the mask portion **`/nn`** in the **`Network Address`** field.
3. Enter the size of allocated block in the **`Mask bits`** field.
4. Click **`Update`**.  
5. In the table at the bottom, click the **`Divide`** link to break down the block into smaller blocks.  

### 2.3 Determine subnet CIDR blocks

Once you've determined the VPC CIDR block, you can use the following steps to break it down into an equal size block per subnet:

1. Access the [Visual Subnet Calculator](http://www.davidc.net/sites/default/subnets/subnets.html)
2. Enter your network address without the mask portion **`/nn`** the **`Network Address`** field.
3. Enter the size of allocated block in the **`Mask bits`** field.
4. Click **`Update`**.  
5. In the table at the bottom, click the **`Divide`** links to start subdividing the larger block into 6 blocks of equal size.
6. Note the first 3 or 6 blocks and supply them as the subnet CIDR blocks in the next step.

### 2.4 Document CIDR block usage

Once you've determine the CIDR block allocations for your test and production VPCs, you should document these allocations in your system configuration documentation. If you use an IP Address Management (IPAM) tool, you should also be able to register the use of these CIDR blocks in that tool.

## 3. Provision test workloads VPC {#provision-test-vpc}

You can use this [sample AWS CloudFormation template](https://github.com/aws-samples/vpc-multi-tier) to provision a VPC to your test environment.

Download the sample AWS CloudFormation template [vpc-multi-tier.yml](https://raw.githubusercontent.com/aws-samples/vpc-multi-tier/master/vpc-multi-tier.yml) to your desktop. You can review the [README](https://github.com/aws-samples/vpc-multi-tier/blob/master/README.md) to understand the role of this template.

Next, access the `workloads-test-<workload-id>` AWS account:

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the **`workloads-test-<workload-id>`** AWS account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.

Create a new AWS CloudFormation stack using the sample template you downloaded to your desktop:

1. Navigate to **`CloudFormation`**.
2. Select **`Create stack`** and **`With new resources`**.
3. Select **`Upload a template file`**.
4. Select **`Choose file`** to select the downloaded template file from your desktop.
5. Select **`Next`**.
6. Enter a **`Stack name`**. For example, **`infra-test-<workload-id>-vpc`** or **`infra-prod-<workload-id>-vpc`** depending on the context.
7. In **`Parameters`**:

|Parameter|Guidance|
|---------|--------|
|**`Business Scope`**|Replace `example` with your organization identifier or stock ticker if that applies. This value is used as a prefix in the name of some of the VPC-related cloud resources. For example, in the name of the IAM role used to support VPC flow logs.|
|**`VPC Name`**|Change to **`test-<workload-id>`** or **`prod-<workload-id>`** depending on the context.|
|**`VPC CIDR Block`**|Enter the overall CIDR block to be assigned to this VPC.|
|**`Create Internet Gateway?`**|Set to `false` if you're not provisioning a tier of public subnets.|
|**` Create NAT Gateways?`**|Set to `false` if you're not provisioning a tier of public subnets.|
|**`Tier 1 Create?`**|Set to `false` if you're not provisioning a tier of public subnets.|
|**`Tier 2 AZ n - CIDR`**|Enter the CIDR block for each of the private tier subnets.|

Leave all of the other parameters at their default settings unless you're comfortable changing them.  For example, if you intend to set up a public tier of subnets. You can always easily create another stack to experiment with other parameter values. Review the [README](https://github.com/aws-samples/vpc-multi-tier/blob/master/README.md) for details on parameters.

8. Select **`Next`**.
9. Select **`Next`**.
10. Scrolls to the bottom and mark the checkbox to acknowledge that IAM resources will be created.
11. Select **`Create stack`**.

In the **`Events`** tab, monitor the progress of the stack creation process. After 5 or so minutes, creation of the stack should complete.

## 4. Provision production workloads VPCs {#provision-prod-vpc}

Repeat step 3 to provision a VPC with an identical topology, but with a different CIDR block in your `workloads-prod-<workload-id>` account.

## 5. Optionally integrate with your on-premises network environment

See [Connecting Your On-Premises Network to Your AWS Environment]({{< relref "01-hybrid-networking" >}}) if you have a need to connect your test and production workloads with resources in your on-premises environment.