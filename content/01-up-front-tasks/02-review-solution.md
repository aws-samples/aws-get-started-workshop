---
title: "Review Overall Solution"
menuTitle: "2. Review Overall Solution"
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

The following diagram represents an initial set of foundational capabilities that you may choose to establish by using this guide.  You should view the capabilities as a superset of capabilities that typically provide value in this early "project" stage of adoption. 

Depending on your requirements and the needs of your initial proof of value workloads, you might choose to defer establishing some of the capabilities shown in the diagram until later in your adoption of AWS.

[![Overall Environment](/images/01-up-front-tasks/initial-foundation-superset.png)](/images/01-up-front-tasks/initial-foundation-superset.png)

Key aspects of the initial solution include:

## Initial Users of Your AWS Environment

The initial workload builder teams, your designated cloud administrators, security and compliance team members, and potentially your finance team members who are concerned with cloud spend, will typically use their corporate desktops to access the AWS Management Console and AWS service APIs over the Internet.

Builders will typically install the AWS Command Line Interface (CLI) and related Software Development Kits (SDKs) on their local corporate desktops to ease the process of interacting with your AWS environment.

By default, all of these users who need access to AWS services will require that you provision users and groups in AWS SSO.

## Users Gain Access to AWS Services via Internet

In this initial stage of your foundation, your technologists will use their existing access to the Internet via your corporate network to access AWS services.

## Management AWS Account and Initial Landing Zone

Once you’ve either identified a compatible existing AWS account or signed up for a new AWS account to act as the AWS Ogranizations management account (formerly known as the master account), your cloud administrators will use AWS Control Tower via the management AWS account to establish a “landing zone” of a few foundational AWS accounts and resources that form your initial base foundation of your AWS environment. 

Your management AWS account will be the place in which your cloud administrators will use AWS Control Tower’s [Account Factory](https://docs.aws.amazon.com/controltower/latest/userguide/account-factory.html) via AWS Service Catalog to create new team development accounts.  You will use AWS Single Sign-On (AWS SSO) to create and manage groups and users in a locally managed directory.

AWS Control Tower sets up a Log Archive AWS account to securely store logs such as AWS CloudTrail logs that record access to all AWS APIs across your AWS accounts and AWS Config logs that record all changes to AWS resources across your AWS accounts.

## Standard AWS Control Tower Guardrails

By using AWS Control Tower, you automatically benefit from the set of [built-in guardrails](https://docs.aws.amazon.com/controltower/latest/userguide/guardrails.html) that represent common preventative and detective security controls. AWS Control Tower includes mandatory, strongly recommended, and elective guardrails.

## AWS Single Sign-On (SSO) and Locally Managed Users and Groups

AWS SSO is used to manage the initial relatively limited number of human users across your builder and cloud foundation teams who need to access the AWS Management Console and AWS APIs to get things done in either team development AWS accounts or in support of managing and operating the overall use of AWS. Initially, you’ll use a locally managed store of groups and users in AWS to represent people who can access your AWS accounts.

As a best practice, it’s strongly recommended that all users managed via AWS SSO set up multi-factor authentication (MFA) for their user accounts.

AWS SSO includes the ability to manage permission sets that define which groups of users can access which AWS accounts and the fine grained AWS Identity and Access Management (IAM) permissions associated with this access.  AWS SSO automatically propagates these permissions to each member AWS account in your AWS organization.

{{% notice tip %}}
**Reuse your corporate identity store and overall RBAC processes:** It's common for organizations planning to adopt AWS to require use of their existing corporate identity store and overall role based access control (RBAC) tools and procedures to grant users entitlements to applications. This guide recommends that you start simple by first using a small set of users and groups defined locally in the AWS SSO service.  Once you've established your initial foundation in AWS, the guide provides a summary of your federated access options and resources to enable you to evolve your AWS environment to use your existing corporate identity source.  See [Federated Access to Your AWS Environment]({{< relref "02-federated-access-to-aws" >}}) for an overview of your options.
{{% /notice %}}

## Team Development Environments

This guide provides you with the option to set up the foundation for team development environments. Even if your initial proof of value workloads don't involve traditional application development teams, your technologists or builders will likely benefit from having access to team development environments. You're encouraged to review the benefits of [Establishing Team Development Environments]({{< relref "03-dev" >}}) before making a decision to skip setting up these environments. If you still decide to defer setting up team development environments, you can return to this guide later and follow the set up instructions.

This guide recommends that each builder team be allocated a distinct team development AWS account to act as a resource container for the AWS resources a team creates and manages on its own.  Since AWS service costs are automatically reported for each AWS account, using a distinct AWS account for each team’s development needs is a convenient way to make costs visible and attributable to each team.

In addition to your initial application and data engineering teams that need access to the AWS platform, you should view your initial cloud and security administrators as a team of builders in its own right that should have its own AWS account for its own work to iterate on, develop, and perform early testing of changes to the foundation.

Access controls and guardrails are established via AWS Identity and Access Management (IAM) to provide your builders with the freedom to get things done in their team development environents,, but with overarching security controls.

A common team development network is established so that you can share a set of subnets across your team development environments.  See [Benefits of Using Shared Subnets]({{< relref "01-review-dev-solution#common-development-network" >}}) for more information.

## Test and Production Environments

A pair of test and production AWS accounts are established to provide you with environments in which you can test changes to your workloads before promoting the changes to a separate production environment.  In order for production-like testing to occur in your test environment, very similar security policies are applied to both test and production environments.

AWS IAM is used to provide your teams who own and will deploy and operate your initial proof of value workloads sufficient access to carry out their work in the test and production environments.

If your initial proof of value workloads depend on networking capabilities, you have the option to set up a basic network environment in each of the test and production environments.

## Network Connectivity Between Your On-premises Network and Your AWS Environment

As an optional capability, this guide leads you through the process of setting up network connectivity between your on-premises network and your AWS environment.  Typically, you would use AWS Site-to-Site VPN for this integration and potentially plan for transitioning to AWS Direct Connect later in your journey.

If you don't need this connectivity in support of your initial proof of value workloads, you can return to this guide later to review your options and the detailed set up steps.

See [Connecting Your On-Premises Network to Your AWS Environment]({{< relref "01-hybrid-networking" >}}) for the typical reasons for needing this connectivity, an overview of your options, and detailed set up instructions for using AWS Site-to-Site VPN and AWS Transit Gateway.