---
title: 'Frequently Asked Questions (FAQs)'
menuTitle: 'FAQs'
disableToc: true
weight: 50
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

{{< toc >}}

## General

### Q: Where can I learn more about this project including who's involved and how I can contribute?

See [Project Information]({{< relref "06-project" >}})

### Q: How can I see what has materially changed in the guide?

See [Change History]({{< relref "04-change-history" >}})

## Federated Access to AWS Platform

### Q: Why isn't federated access with an existing identity store addressed from the start?

It's typical for an organization to require at least several weeks to plan and coordinate the work required to set up federated access using an existing identity source. Consequently, the guide defaults to the use of AWS Single Sign-On (AWS SSO) to provide federated access to your AWS accounts. This transitional approach entails managing users and groups in an identity source maintained within AWS SSO.

You have the option to implement federated access using your existing identity source. See [Federated Access to the AWS Platform]({{< relref "02-federated-access-to-aws" >}}) for more background.

## AWS Accounts Design

### Q: Shouldn't we develop a comprehensive design of our AWS account structure before we do any build out?

It's useful to have a design in place for your initial AWS account structure to support your first few workloads. This guide provides recommendations and examples for your starter set of AWS accounts and AWS Organizations Organizational Units (OUs).

You can modify the structure of your AWS environment over time as you learn more about the AWS platform and your requirements.

### Q: Why aren't "Sandbox" AWS accounts included in the initial build out?

Since the premise of the initial guide is to help customers quickly establish a set of formal team development environments in which experimentation, integration, development, and early testing of the first few application and/or data services can take place before they are rapidly moved through formal pre-production testing environments and into production, the traditional role of completely isolated and disconnected sandbox AWS accounts in which your organization's intellectual propertly (IP) including source code is not allowed does not yet apply to this overall scenario.

Instead, a focus of this guide is to establish team development AWS accounts to enable the formal work in support of the first few projects to progress rapidly.

#### Similarities to Traditional Sandbox AWS Accounts
In this very first and minimal stage of the build out, there are similarities between the team development AWS accounts and typical sandbox AWS accounts. For example, the initial lack of on-premises network integration and failrly wide ranging access to AWS services. However, the expectation is that your organization will either 1) require such gaps to be addressed at the outset and before builder teams are onboarded, or 2) quickly address these gaps as fast follow-on requirements.

We expect that in most cases the initially provisioned developemnt team AWS accounts will quickly evolve to take on these additional properties. Rather than characterizing the initial team development AWS accounts as sandbox AWS accounts and needing to rename and reposition them later, the decision was made to position them as formal team development AWS accounts from the start.

#### Governed Sandboxes
The notion of ["governed sandboxes"](https://www.flux7.com/blog/aws-best-practice-sandbox-accounts-provide-secure-middle-ground/) is similar to the approach taken in this guide where builder teams are provided wide latitude to manage cloud resources in their team development AWS accounts, but within a set of overall guardrails.

#### Future Role for Traditional Sandboxes
Similar to other aspects of overall AWS account design, the guide intentionally avoids overloading your organization with the fuller "to be" state of capabilities too early in your cloud adoption journey. Depending on your needs, in the future and perhaps in the larger "foundation" stage of adoption or even earlier as a parallel workstream, the capability to provide truly isolated and ephemeral sandbox AWS accounts to support a specific set of use cases may be addressed.

## Cloud Resource Naming and Tagging

### Q: Shouldn't we define and implement tagging standards early on in our journey?

In the early stage of cloud adoption addressed by this guide where you'll have relatively few workloads, you likely won't need a sophisticated approach to tagging your cloud resources.  However, before you expand adoption further, it's recommended that you spend the time to begin developing and applying your own cloud resource tagging standards.
