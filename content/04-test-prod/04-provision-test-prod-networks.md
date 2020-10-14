---
title: 'Configure Test and Production Networks'
menuTitle: '4. Configure Test and Prod Networks'
disableToc: true
weight: 40
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

{{% notice note %}}
Review Note: This section is an early draft and undergoing reviewing and editing.
{{% /notice %}}

In this step your Cloud Administrators will review the solution's networking requirements and provision VPCs in the workload accounts if required.

This step should take about 60 minutes to complete.

{{< toc >}}

## 1. Review Networking Requirements
{{% notice tip %}}
If you've determined that the workload will not require VPC networking support, you can skip this step.
{{% /notice %}}

### Dedicated VPCs
Unlike the development/sandbox accounts, test and production environments would typically call for dedicated VPCs.  Dedicated VPCs increase isolation of the accounts and provide additional flexibility in certain deployment scenarios.

### Subnets and Availability Zones
In those AWS regions in which at least 3 Availability Zones (AZs) are available for customer use, it's recommended that your initial set of VPCs have subnets in each of the 3 AZs so that your builder teams can experiment with and perform early testing of workloads and AWS services that can take advantage of 3 AZs.

### Public and Private Subnets
At least one public subnet will have a NAT Gateway that enables workloads in any of the private subnets to send traffic outbound to the Internet. For example, to enable workloads to download content from Internet accessible source code and package repositories.

{{% notice tip %}}
**Option to filter outbound Internet traffic:** As you progress in your journey, you may transition from this initial approach of providing builder teams with unfiltered outbound or egress Internet access via the initial set of public subnets and NAT Gateway to a more secure architecture where all Internet egress traffic is routed through your standard enterprise edge security services so that all egress traffic is inspected for compliance. This capability is highlighted in the [optional capabilities]({{< relref "05-optional" >}}).
{{% /notice %}}

[![Test and Production Network Details](/images/04-test-prod/initial-foundation-test-prod-single-region.jpg)](/images/04-test-prod/initial-foundation-test-prod-single-region.jpg)

## 2. Determine IP Address CIDR Blocks
If you have a formally assigned CIDR block to use, in this step you'll:

1. Review Default VPC Topology
2. Determine VPC CIDR Block
3. Determine Subnet CIDR Blocks

### Review Default VPC Topology

The default parameters of the AWS CloudFormation template that you will use in the next step will result in a VPC with:
* 2 tiers of subnets:
  * Public tier
  * Private tier
* 3 subnets for each tier.
* Subnets are mapped across 3 Availability Zones (AZs).

The CloudFormation template requires you to supply a CIDR block for each of the following:

* Overall VPC
* Public subnets 1, 2, and 3
* Private subnets 1, 2, and 3

To keep things simple, you can size the subnets identically.

### Determine VPC CIDR Block
{{% notice tip %}}
Allocate a distinct CIDR range for each AWS account if possible to allow for ease of future VPC peering and/or hybrid connectivity scenarios.  As you will be subdividing this CIDR block into six different subnets, please try and allocate at minimum a `/20` and ideally a `/18` for each workload account to allow for scale-out.
{{% /notice %}}
If you followed earlier instructions, your Network team has supplied a relatively large non-overlapping CIDR block, for example a `/16` - `/20`. You should strive to use a distinct CIDR range for each VPC you build, so make sure it's different from what you've previously used for [your shared development VPC]({{< relref "02-set-up-common-dev-network#dev-cidr" >}})

If you need to break down a larger block:

1. Access the [Visual Subnet Calculator](http://www.davidc.net/sites/default/subnets/subnets.html).
2. Enter your network address without the mask portion **`/nn`** in the **`Network Address`** field.
3. Enter the size of allocated block in the **`Mask bits`** field.
4. Click **`Update`**.  
5. In the table at the bottom, click the **`Divide`** link to break down the block into smaller blocks.  

When you've reached block sizes from **`/20`** - **`/22`**, select a block size of most interest to you and record that CIDR range so that you can use it in the next step.

### Determine Subnet CIDR Blocks

Once you've determined the VPC CIDR block, breaking it down into an equal size block per subnets is straightforward.

1. Access the [Visual Subnet Calculator](http://www.davidc.net/sites/default/subnets/subnets.html)
2. Enter your network address without the mask portion **`/nn`** the **`Network Address`** field.
3. Enter the size of allocated block in the **`Mask bits`** field.
4. Click **`Update`**.  
5. In the table at the bottom, click the **`Divide`** links to start subdividing the larger block into 6 blocks of equal size.
6. Note the first 6 blocks and supply them as the subnet CIDR blocks in the next step.

## 3. Provision Prod Workload VPC {#provision-prod-vpc}

You can use this [sample AWS CloudFormation template](https://github.com/aws-samples/vpc-multi-tier) to easily deploy your centrally managed development network.

Download the sample AWS CloudFormation template [vpc-multi-tier.yml](https://raw.githubusercontent.com/aws-samples/vpc-multi-tier/master/vpc-multi-tier.yml) to your desktop. You can review the [README](https://github.com/aws-samples/vpc-multi-tier/blob/master/README.md) to understand the role of this template.

Next, access the `workload-prod` AWS account:

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the **`workload-prod-<workloadId>`** AWS account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.

Now create a new AWS CloudFormation stack using the sample template you downloaded to your desktop:

1. Navigate to **`CloudFormation`**.
2. Select **`Create stack`** and **`With new resources`**.
3. Select **`Upload a template file`**.
4. Select **`Choose file`** to select the downloaded template file from your desktop.
5. Select **`Next`**.
6. Enter a **`Stack name`**. For example, **`prod-infra-vpc`**.
7. In **`Parameters`**:

|Parameter|Guidance|
|---------|--------|
|**`Business Scope`**|Replace `example` with your organization identifier or stock ticker if that applies. This value is used as a prefix in the name of some of the VPC-related cloud resources. For example, in the name of the IAM role used to support VPC flow logs.|
|**`VPC Name`**|Change to **`prod`**|
|**`Cidr`**|Enter values for the `pVpcCidr`, `pTier1..`, and `pTier2...` CIDR blocks from the prior step. You can ignore the `pTier3...` parameters because only two tiers - public and private - are being provisioned by default.|

Leave all of the other parameters at their default settings unless you're comfortable changing them.  You can always easily create another stack to experiment with other parameter values. Review the [README](https://github.com/aws-samples/vpc-multi-tier/blob/master/README.md) for details on parameters.

{{% notice info %}}
**If you have reviewed guidance above and you do not need public subnets, set the following parameters:**
- `pTier1Create`: false
- `pCreateNatGateways`: false
- `pCreateInternetGateways`: false
{{% /notice %}}

8. Select **`Next`**.
9. Select **`Next`**.
10. Scrolls to the bottom and mark the checkbox to acknowledge that IAM resources will be created.
11. Select **`Create stack`**.

In the **`Events`** tab, monitor the progress of the stack creation process. After 5 or so minutes, creation of the stack should complete.

## 4. Provision Test Workload VPCs {#provision-test-vpc}

Repeat steps 1-3 above for the `workloads-test-<workloadId>` account.
