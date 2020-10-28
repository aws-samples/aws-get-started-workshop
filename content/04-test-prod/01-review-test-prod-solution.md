---
title: 'Review Test and Production Environments Solution'
menuTitle: '1. Review Solution'
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

After you've established your team development environments to support experimentation, development, and early testing, you will soon need to support formal testing and eventually production hosting of your first few proof of value workloads.

The following diagram represents the addition of test and production AWS accounts to your initial AWS environment. A set of optional networks are also depicted.

[![Initial Test and Production Environments in Single AWS Region](/images/04-test-prod/initial-foundation-test-prod-single-region.png)](/images/04-test-prod/initial-foundation-test-prod-single-region.png)

## AWS account design

The design of your test and production environments intentionally starts with a simple pair of AWS accounts. After you gain experience securing, deploying, and operating your initial proof of value workloads, you'll want to spend more time assessing the needs of future workloads, reviewing AWS best practices, and designing how you'll expand your AWS account structure.

### Single production account

This guide assumes that a single production AWS account will suffice to support your first several proof of value workloads.  However, if you're initially getting several diverse workloads into production, you may want to consider creating a separate AWS account for each workload at this time.  By doing so, you can isolate these workloads from the start and not need to migrate them to their own accounts in the future.

### Production-like test account

In this guide we lead you through setting up a single test account that is a companion to the production account.  If you choose to set up multiple production accounts from the start, we recommend doing likewise with the companion test accounts.

We recommend that for each production AWS account, you establish at least one non-production test account in which you can safely perform production-like testing of changes to your workload. By closely mirroring your production environment, you'll be able to detect issues earlier and before you apply changes to your production environment.

Your overall set of account baselines, guardrails, and access control should be very similar if not identical across your production and test environments. Similarly, if your workloads require networking support, then the network design should be very similar across your production and test environments.

Your test accounts can be used to host multiple instances of your workload. i.e. multiple workload environments.  The types of testing that you need to perform will help you understand how many workloads environments you might create in your test account.  For example, you might use different workload environments for functional and performance testing of your workload in a single test AWS account.

## Security and governance guardrails

Moving workloads into a production phase often requires increased levels of governance and oversight.  There are many mechanisms and tools in AWS that can be used to build a strong governance function while still allowing flexibility and autonomy to the builder teams.  The primary mechanisms we've discussed in this guide are AWS Control Tower Guardrails set on the AWS Organizational Units, and Permission Boundaries to restrict IAM grants.

## Access control

### Your operating model delivery approach

Even in this early stage of using AWS, it's important for you to consider the roles and responsibilities of people and teams who will be managing and operating your production workloads.  In other words, what is the operating model that applies to your first few proof of value workloads?

For example, will the team that owns the workload also deploy and manage the workload in production? Or will that team depend on an operations to team for deployment and operation of the workload in production?

The former model can be considered a "you build it, you run it" or a "DevOps" style model.  The latter model may be considered more of a centralized operations model.

Independent of the model that you choose to apply to your first few proof of value workloads, we recommend that you define a functional role to deploy and operate the workloads that are distinct from the roles used to manage your cloud foundation.

{{% notice tip %}}
**Cloud Operating Model:** See [Building a Cloud Operating Model](https://d1.awsstatic.com/whitepapers/building-a-cloud-operating-model.pdf) and specifically section "6. Own your own lifecycle" for more information on considering how your organization can operate more efficiently with the cloud.
{{% /notice %}}

### Apply foundation functional roles

Similar to how you applied the foundational functional roles of Cloud Administration and Security Administration to your other accounts, you will also enable these roles to access your test and production accounts. By doing so, you'll enable your foundation team with the necessary access to manage the foundational resources in the test and production accounts.

### Introduce functional role for workload administration

As a best practice, we recommend that you define a distinct role for the purpose of administering and operating the workloads that reside in your test and production environments.  In this guide, we show you how to define and provision a "Workload Administrator" role that can be used by the team that manages the initial workload. By using a distinct role to administer and operate your workloads, you're able to separate those duties from other teams who may have responsibility for managing the underlying foundation of your environment.

As a start, you'll provide wide ranging access permissions to the Workload Administrator role, but it will be constrained from modifying foundational resources. Over time, you can modify the permissions align more with least privilege best practice and potentially create different workload administrator roles in support of different workloads.

Over time, if you apply automation to deploying and managing workloads, then you'll have less dependence on using workload administrator roles in your production environment. At that stage, you may need only a workload operator type of roles that have far less write access to your environment.

## Networking

If your initial proof of value workloads don't depend on networking, you can skip this section. For example, if your initial workload uses Amazon CloudFront for content delivery network (CDN) and Amazon S3 for static web site storage, then you may not need networking in your test and production accounts.  Similarly, use of many of the serverless services such as AWS Lambda and Amazon DynamoDB don't require networks in your environment.

### Dedicated VPC per account

If the workload does require a VPC, your Network Administrators will create a VPC that resides in the test and prod workload accounts.  This will allow for more isolation and workload-specific VPC configuration than you would typically need in development scenarios

### Secure internet integration

If your initial workload requires access either to or from the internet, then we recommend that you review these options with your security and network teams so that you decide on the best approach in support of your initial workloads.

|Approach|Description|Advantages|Disadvantages|
|--------|-----------|----------|-------------|
|**Direct internet access from VPCs**|Deploy a set of public subnets and associated internet and potentially NAT gateways in each VPC. Ensure use of direct internet access is performed in a secure manner.|Easy setup<br><br>No dependencies on other teams<br><br>No on-premises dependencies|Might not meet your internet security requirements<br><br>Responsibility on team managing the workloads to ensure secure internet access,|
|**Temporarily route internet traffic to on-premises**|Use only private subnets in each VPC. Route all internet traffic over private connection to on-premises and reuse your existing enterprise internet security services.|Relatively straighforward to configure if you already plan on setting up private connectivity with your on-premises environment.|Stopgap solution<br><br>Increased latency.<br><br>Potentially insufficient bandwidth<br><br>Cost depending on the amount of data transferred out of AWS to your on-premises environment<br><br>Dependencies on other teams|
|**Establish centrally managed internet egress/ingress security capabilities in AWS**|Use only private subnets in each VPC. Route all internet traffic through a new centralized internet security services in your AWS environment.<br><br>For example, [Securing VPC Egress Using IDS/IPS Leveraging Transit Gateway](https://aws.amazon.com/blogs/networking-and-content-delivery/securing-egress-using-ids-ips-leveraging-transit-gateway/) and [How to Integrate Third-Party Firewall Appliances into an AWS Environment](https://aws.amazon.com/blogs/networking-and-content-delivery/how-to-integrate-third-party-firewall-appliances-into-an-aws-environment/).|Performance<br><br>Scales for broader adoption of AWS|Significant undertaking<br><br>Dependencies on other teams|  

### On-premises network integration

Your test and production workloads might require connectivity to on-premises resources and services over a private connection. If you have not already established this connectivity, see [Hybrid Networking]({{<ref "/05-extend/01-hybrid-networking/" >}}) for an overview of your options and detailed step-by-step instructions for setting up a site-to-site VPN connection.
