---
title: "(Optional) Set Up `Development` Service Control Policies"
menuTitle: "8. (Opt)Set Up Dev SCPs"
disableToc: true
weight: 80
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this step your Cloud Administrators will optionally setup a Service Control Policy (SCP) limiting what service APIs are available to use in the **`development`** account.

This step should take about 5 minutes to complete.

{{< toc >}}

## 1. Apply Service Control Policies to `development` OU

Using AWS Organizations, create a new Service Control Policy (SCP) that will be specific for the `development` OU.  This SCP will restrict the permissions of the developer user in regards to VPC/EC2, Direct Connect, and Global Accelerator related services.

{{% notice tip %}}
**For Development Accounts:** For accounts which require their VPC boundary configurations (in terms of ingress / egress) to remain immutable, the SCP ([`acme-base-team-dev-scp-vpc-boundaries.json`](/code-samples/02-scps/acme-base-team-dev-scp-vpc-boundaries.json)) can enforce this.  If you'd like to learn more about SCPs, see [Managing AWS Organizations policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies.html).
{{% /notice %}}

### Create the `development` VPC SCP

1. Navigate to **`AWS Organizations`**.
2. Select **`Policies`**.
3. Select **`Create policy`**.
4. Follow the prompts to create a new SCP named **`DevImmutableVPCBoundariesSCP`**

### Apply the SCP to the `development` OU

1. Navigate to **`AWS Organizations`**.
2. Select **`Organize accounts`**.
3. In the Organization tree on the left, select the **`development`** OU
4. On the right side of the console, select **`Service control policies`**
5. On the right side of the console, select the **`Attach`** link next to the SCP **`DevImmutableVPCBoundariesSCP`**