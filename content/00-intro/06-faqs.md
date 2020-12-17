---
title: 'Frequently Asked Questions (FAQs)'
menuTitle: 'FAQs'
disableToc: true
weight: 60
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

{{< toc >}}

## General

### Q: Where can I learn more about this project including who's involved and how I can contribute?

See [Project Information]({{< relref "07-project" >}})

### Q: How can I see what has materially changed in the guide?

See [Change History]({{< relref "07-change-history" >}})

### Q: How does this guide relate to AWS Control Tower immersion days?

This guide leverages AWS Control Tower as a key enabler, but it does not dive deeply into AWS Control Tower features. This guide complements AWS Control Tower immersion days by focusing on helping customers establish a working end-to-end foundational AWS environment in support of their initial proof of value production workloads.  The foundation is based on an example reference implementation that represents a working real-world AWS environment.

You don't need to participate in an AWS Control Tower immersion day in order to use this guide. However, you'll likely gain value from experiencing an AWS Control Tower immersion day so that you can learn how to take advantage of the broader set of AWS Control Tower features.

## Federated Access to AWS Platform

### Q: Why isn't federated access with an existing identity store addressed from the start?

It's typical for an organization to require more than a few days to plan and coordinate the work required to set up federated access using an existing identity source. Consequently, the guide defaults to the using AWS Single Sign-On (AWS SSO) with locally managed users and groups to provide federated access to your AWS accounts.

The[Federated Access to the AWS Platform]({{< relref "02-federated-access-to-aws" >}}) section of this guide helps you start planning to integrate your existing identity source in support of federated access to AWS.

## AWS Accounts

### Q: Shouldn't we develop a comprehensive design of our AWS account structure before we do any build out?

This guide starts with a basic starter form of the AWS recommended account structure. You don't need to spend a lot of time designing the ultimate structure of your AWS environment in support of this early project stage of adoption and your first few proof of value workloads.  You can grow and expand this structure as you gain more experience with AWS.

### Q: Why aren't "Sandbox" AWS accounts included in the initial build out?

The goal of this guide is to help you quickly establish a foundation on which you can deploy your first few proof of value workloads. Since sandbox environments that are disconnected from your internal development services such as source and artifact management are typically not required in support of your first few proof of value workloads, this guide doesn't currently focus on establishing disconnected sandbox environments.

#### Flexible team development environments

Instead, this guide provides detailed set up instructions for establishing team development environments. The optional team development environments are intended to provide your builders with the freedom to experiment and get things done subject to a set of guardrails.  These team development environments are similar to the notion of ["governed sandboxes"](https://www.flux7.com/blog/aws-best-practice-sandbox-accounts-provide-secure-middle-ground/).

You will likely enable these team development environments to access some of your existing internal development services.  Access to these services can help your builders perform more formal experiments and development in their team development environments.

Later, as you expand your use of AWS and onboard more of your builders, you will likely find it useful to establish a formal mechanism to support disconnected sandbox environments.

#### Moving existing experimental AWS accounts

You might already have an AWS account or two in which you've been performing early experiments. These accounts can be easily moved into your new AWS environment so that you consolidate billing and cost management and have greater control over these environments.  Over time, you might supplant these environments with either your more formal team development environments or a disconnected sandbox environment capability.

## Cloud Resource Naming and Tagging

### Q: Shouldn't we define and implement tagging standards early on in our journey?

In the early stage of cloud adoption addressed by this guide where you'll have relatively few workloads in just a few AWS accounts, you likely won't need a sophisticated approach to tagging your cloud resources.  However, before you expand adoption further, it's recommended that you spend the time to begin developing and applying your own cloud resource tagging standards.
