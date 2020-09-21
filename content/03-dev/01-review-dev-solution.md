---
title: "Review Development Environment Solution"
menuTitle: "1. Review Solution"
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

The following diagram represents the recommended configuration of an initial set of team development environments.

[![Initial Development Environment](/images/03-dev/initial-foundation-dev.png)](/images/03-dev/initial-foundation-dev.png)

Key aspects of the initial solution include:

## Team Development AWS Accounts

Each builder team is allocated a distinct team development AWS account to act as a resource container for the AWS resources a team creates and manages on its own.  Since AWS service costs are automatically reported for each AWS account, using a distinct AWS account for each team’s development needs is a convenient way to make costs visible and attributable to each team.

In addition to your initial application and data engineering teams that need access to the AWS platform, you should view your initial cloud and security administrators as a team of builders in its own right that should have its own AWS account for its own work to iterate on, develop, and perform early testing of changes to the foundation.

## Common Development Network {#common-development-network}

A centrally managed development network in the form of an AWS Virtual Private Cloud (VPC) is used to support the networking needs of builder teams for their development tasks.  Your Cloud Administrators will provision this centrally managed VPC to a new "Network" AWS account and share a common set of private subnets with team development AWS accounts.

The common development VPC will support cases in which a builder team needs to deploy AWS resources that reside in VPCs. For example, deploying Amazon EC2 Virtual Machines (VMs) and Amazon Relational Database Service (RDS) instances.

The common development VPC provides private subnets in multiple Availability Zones (AZs) to mimic typical production topologies so that builder teams can start experimenting and perform early testing of multi-AZ topologies early in the lifecycle.

The common development VPC includes a set of public subnets that host one or more Network Address Translation (NAT) Gateways to enable outbound connectivity from the shared private subnets to the Internet.  The public subnets are not shared to the team development AWS accounts.

The routing configuration of the shared private subnets and the NAT Gateways enable teams to access Internet-based resources such as package repositories and publicly available APIs during their experimentation and development work.

Benefits of using a common VPC for builder team's development needs include:

+ The organization needs to manage and pay for only one set of common shared VPC resources for all builder teams. For example, one set of NAT Gateways - which are billed on an hourly basis.

+ Configuration of organization standard newtork services such as AWS VPC endpoints is easier to manage in a single VPC.

+ Builder teams reuse centrally managed VPC resources for multiple builder teams.

+ Builder teams self-service manage their workload-specific cloud resources including security groups, EC2 instances, etc.

+ Subject to how builder teams set up their EC2 security groups, builder teams have the potential to have network connectivity to other teams' development quality services given that their workloads reside in the same subnets.

+ Builder teams cannot see and manage other teams' workloads even though they're sharing the same VPCs.

+ Builder teams cannot modify the VPC and related resources that are centally hosted and managed in a separate network AWS account. No additional IAM policies are required.

+ Costs for builder teams' cloud resources are still allocated to their respective team development AWS accounts.

+ Costs for shared VPC foundation resources are allocated to the **network-prod** AWS account.

{{% notice tip %}}
**Learn more about sharing VPC resources** See [NET320-R1 - The right AWS network architecture for the right reason](https://youtu.be/Ot1kcQfUIdg?t=1003) for more background on the benefits and practical considerations of sharing VPC resources.
{{% /notice %}}
