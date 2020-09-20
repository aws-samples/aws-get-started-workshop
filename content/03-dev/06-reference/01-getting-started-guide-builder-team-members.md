---
title: "Getting Started Guide for Builder Teams"
menuTitle: 'Gettting Started: Builders'
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

{{% notice tip %}}
**An Example Getting Started Guide:** This document represents an example that can help your organization develop and publish your own getting started guide internally for builder teams that are onboarding to your AWS environment.  You are free to copy this content into your own internal wiki or other system and modify it to meet your needs. As your organization progresses on its cloud adoption journey, you will likely significantly expand your internal documentation to help communicate additional and increasingly sophisticated capabilities and associated best practices that are available to teams.
{{% /notice %}}

{{% notice note %}}
**Review Note: Help add useful day 1 topics for new builder teams and members:** What is the minimum knowledge a builder team would need for day 1 use of their new team development AWS account? Don't overload the initial document with more advanced capabilities. Focus on the "crawl" level of knowledge that they need.
{{% /notice %}}

This document is intended to provide builder team members with awareness of the typical day-to-day tasks and supporting methods, tools, and AWS services to help them experiment, develop, and perform early testing in their team development AWS accounts.

{{< toc >}}

## Accepting Invite to Join AWS SSO

After your Cloud Administrators have onboarded your builder team and added your individual user logins, you will receive an email from AWS with the subject "Invitation to join AWS Single Sign-On".  To login to your AWS account, you'll need to [accept the invitation](https://docs.aws.amazon.com/singlesignon/latest/userguide/howtoactivateaccount.html).

Once you're able to login, you'll need to [register an MFA device](https://docs.aws.amazon.com/singlesignon/latest/userguide/user-device-registration.html) to your AWS SSO account.

## Understanding Your Team's Initial Development Environment

### Environment Overview

Review the [Initial Development Environment Solution Overview]({{< relref "01-review-dev-solution" >}}) for an introduction to the overall environment.

### Network Overview

The following diagram provides a more detailed view of the initial network environment that is available to your team development AWS account:

[![Common Development Network Details](/images/03-dev/initial-foundation-dev-network-details.png)](/images/03-dev/initial-foundation-dev-network-details.png)

When you access your team development AWS account via the the AWS Management Console and review the Virtual Private Cloud (VPC) resources, you will see a series of private subnets that have been shared with your AWS account.  

The private subnets and other VPC resources are hosted in a **network-prod** AWS account that is managed by your Cloud Administrators.  All team development AWS accounts have read only access to these VPC resources.

By design, your team does not have permissions to create and modify VPC resources in your own team development AWS account.

{{% notice info %}}
**What is a "private" subnet?** Workloads deployed to private subnets cannot be directly accessed from the Internet.  i.e. unsolicited traffic from the Internet is not allowed. In the initial configuration of the common set of shared private subnets for team development AWS accounts, your workloads are able to connect outbound to services on the Internet via NAT Gateway services that are hosted in a set of centrally managed public subnets.
{{% /notice %}}

### Where should my team deploy resources?

All AWS resources that your team creates and manages are constrained to your team development AWS account.  In support of workloads requiring access to VPC resources, your team can deploy those workloads in the private subnets of the centrally managed development VPC.

## Understanding Your Team's Access Permissions and Responsibilities

*...use of personal users set up in AWS SSO...*

*...summary of access permissions to their team development AWS account... withe pointers to detailed permissions...*

*...extent of AWS services available via their team development AWS accounts and how that extent may likely evolve over time as the security baselines get more sophisticated...*

*mention that an initial set of preventative and detective security guardrails are in place to avoid and recognize out of compliant resources...*

*highlight that their access permissions will likely be further constrained for their team development AWS accounts over time to help reduce the risk to the overall organization...*

*...use scripted builds for their cloud resources where feasible to avoid cost of rework as their team development AWS networks are likely to be replaced over time... provide pointers to Infrastructure as Code resources...*

## Accessing Your Team's Development AWS Account

For non-production environments, you're allowed access to use the AWS Management Console to create and update AWS resources.  As workloads move towards production and our practices on AWS mature, we'll be implementing a "Console Read Only" policy in production environments.

All resources required for your formal workloads should be managed with Infrastructure as Code (IaC).

### Access Via AWS Management Console
When you log into your AWS SSO portal ([add your company's link here]()), you'll be shown a list of AWS accounts you have access to.  Initially, each builder team is provided a single team development AWS account.

### From Your Corporate Desktop - Access Via AWS CLI, AWS SDKs, and AWS APIs

AWS SSO supports CLI access via the AWS CLI.  

First, [Install the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

Then review [Configuring the AWS CLI to Use AWS SSO](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html).

### Other Tools

See [Tools on AWS](https://aws.amazon.com/tools/) for a list of tools and SDKs that AWS supports.

## Working with AWS Services

Since there are some constraints in using AWS services in your team development AWS account, refer to  [Using AWS Services]({{< relref "03-using-aws-services" >}}) for more details on both general considerations and AWS service specific considerations. 

## Monitoring and Managing Costs

With the adoption of AWS, we're shifting our operation model to empower builders with more flexibility and control over their environments.  This includes understanding the AWS resources they're consuming and the costs that are associated with them.

1. Use your personal user to log into AWS SSO.
2. Select your team development AWS account.
3. Select **`Management console`**.
4. Access the **`Billing`** service.

Learn about [AWS Billing and Cost Management](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/billing-what-is.html). Specifically, review how you can use Cost Explorer and Budgets to help you monitor your cloud costs incurred within your development AWS account.

## Learning Architecture Best Practices

### How to Get an Application to Production

*.... Well Architected Review...Any other changes to traditional SDLC...*

### How to Apply Additional Compliance Guardrails for Sensitive Applications?
*... engaging cloud foundations team for SCP/Organizational changes/creation...*

## Learning About AWS Services

See additional getting started with AWS information:

* [AWS Getting Started](https://aws.amazon.com/getting-started/)
* [AWS Training and Certification](https://aws.amazon.com/training/?e=gs&p=gsrc)
* [Start Developing with AWS](https://aws.amazon.com/developers/getting-started/)
* [Migrating with AWS](https://aws.amazon.com/cloud-migration/)

## Working with Other AWS Accounts

### Consuming Another Team's APIs or Resources

Since a common set of private subnets are shared across team development AWS accounts, any workloads you deploy to these subnets have the potential to connect to each other.

### Working With External AWS Accounts

If I already have an AWS account registered with my corporate/company email, can I use it instead?

If you have production workloads, contact your cloud foundations team to absorb that account into our proper environment to ensure compliance and security requirements are met.

## Getting Support

*...address how builder teams get support to get things done in their team development AWS accounts... include: 1) organization-specific support needds; 2) support for AWS services - can the dev teams file tickets?...*

Typically, best practices are:

For organization-specific usage needs, consult these resources in this order:
* Review the internal documentation.
* Interact with the internal community forum.
* File an internal support ticket.

For AWS-specific usage needs:
* Review external documentation.
* Interact with public community forums. Being careful to not disclose company confidential and other sensitive information.
* File a ticket with AWS Support.  See internal guidelines and procedures for doing so.
