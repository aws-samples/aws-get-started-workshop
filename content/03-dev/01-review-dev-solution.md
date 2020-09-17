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

The following diagram represents a typical team development environment as a distinct AWS account supported by an initial set of foundation capabilities managed via a set of shared AWS accounts to meet the typical requirements outlined above. 

Since your specific requirements may include some of the [optional capabilities]({{< relref "05-optional" >}}), aspects of your initial solution may be different than shown in this diagram.

[![Initial Development Environment](/images/01-dev/initial-foundation-dev-initial.png)](/images/01-dev/initial-foundation-dev-initial.png)

Key aspects of the initial, minimal solution include:

## Master AWS Account and Initial Landing Zone

Once you’ve either identified a compatible existing AWS account or signed up for a new AWS account, the “master” account, your cloud administrators will use AWS Control Tower via the Master AWS account to establish a “landing zone” of conventional shared AWS accounts and resources to help provide an initial foundation for your use of AWS. 

Your master AWS account will be the place in which your cloud administrators will use AWS Control Tower’s [Account Factory](https://docs.aws.amazon.com/controltower/latest/userguide/account-factory.html) via AWS Service Catalog to create new team development accounts, AWS SSO to create and manage groups and users in the locally managed directory, and generally monitor the overall use and health of your AWS environment.

AWS Control Tower sets up a Log Archive AWS account to securely store AWS platform-wide logs such as AWS CloudTrail logs that record access to all AWS APIs across your AWS accounts and AWS Config logs that record all changes to AWS resources across your AWS accounts.

## Standard AWS Control Tower Guardrails

By using AWS Control Tower, your organization automatically benefits from the set of [built-in guardrails](https://docs.aws.amazon.com/controltower/latest/userguide/guardrails.html) that represent common preventative and detective security controls. AWS Control Tower includes mandatory, strongly recommended, and elective guardrails.

## AWS Single Sign-On (SSO) and Locally Managed Users and Groups

AWS SSO is used to manage the initial relatively limited number of human users across your builder and cloud foundation teams who need to access the AWS Management Console and AWS APIs to get things done in either team development AWS accounts or in support of managing and operating the overall use of AWS. Initially, you’ll use a locally managed store of groups and users in AWS to represent people who can access your AWS accounts.

As a best practice, it’s strongly recommended that all users managed via AWS SSO set up MFA for their user accounts.

AWS SSO includes the ability to manage permission sets that define which groups of users can access which AWS accounts and the fine grained AWS Identity and Access Management (IAM) permissions associated with this access.  AWS SSO automatically propagates these permissions to each member AWS account in your AWS organization.

{{% notice tip %}}
**Reuse your corporate identity store and overall RBAC processes:** It's common for organizations planning to adopt AWS to require use of their existing corporate identity store and overall role based access control (RBAC) tools and procedures to grant users entitlements to applications. This guide recommends that you start simple by first using a small set of users and groups defined locally in the AWS SSO service.  Once you've established your initial foundation in AWS, the guide provides a summary of your federated access options and resources to enable you to evolve your AWS environment to use your existing corporate identity source.  See [Federated Access to Your AWS Environment]({{< relref "02-federated-access-to-aws" >}}) for an overview of your options.
{{% /notice %}}

## Initial Users of Your AWS Environment

The initial workload builder teams, your designated cloud administrators, security and compliance team members, and potentially your finance team members who are concerned with cloud spend, will typically use their corporate desktops to access the AWS Management Console and AWS service APIs over the Internet.

Builders will typically install the AWS Command Line Interface (CLI) and related Software Development Kits (SDKs) on their local corporate desktops to ease the process of interacting with your AWS environment.

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

{{% notice tip %}}
**Access to on-premises resources:** It's common that your builder teams' development environments and your test and/or production environments in AWS will need to have connectivity to some of your on-premises resources. For example, there may be existing test and production data services in your on-premises environment that your workloads in AWS will need to access.  If this is the case, you should review [On-premises Network Integration]({{< relref "01-hybrid-networking" >}}) for an overview of your options.
{{% /notice %}}

## Access AWS Services via Internet
In this initial stage of your foundation, your builders’ existing access to the Internet via the corporate network is used to enable authorized builders to access the AWS platform.
