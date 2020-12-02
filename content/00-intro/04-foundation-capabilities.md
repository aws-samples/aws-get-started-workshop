---
title: 'Foundation Capabilities in Scope'
menuTitle: 'Foundation Capabilities'
disableToc: true
weight: 40
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This guide helps you establish a set of AWS foundational capabilities to help support your use of development, test, and production environments to deliver your first few proof of value workloads in production. 

{{< toc >}}

## Workload-specific capabilities

Other capabilities that are specific to your workloads and your desired Software Development Lifecycle (SDLC) and operational processes including supporting tools are not currently addressed by this guide. You'll layer those capabilities and solutions on top of the initial foundation capabilities addressed in this guide.

## An initial foundation

Even in the early project stage of adoption, AWS recommends that an initial foundation be established that can be extended over time as you transition into the foundation stage to prepare for larger scale cloud adoption. This guide will help you establish the beginning of a foundation on AWS in support of your initial few proof of value workloads in production.

The guide leads you through the process of:
1. Addressing a series of up front tasks that may require lead time depending on your internal processes.
2. Setting up a base foundation of your new AWS environment.
3. Extending the foundation to support team development environments.
4. Extending the foundation to support of your first set of test and production environments.

The guide also addresses a set of common additional capabilities that, for some organizations, are required before those organizations either perform formal experiments and development in the cloud or move an initial set of workloads into production.

Later, after you've demonstrated success with the initial few projects, you will likely make larger investments during the foundation stage of your journey to support cloud adoption at scale.

[![Cloud Foundation](/images/00-intro/initial-foundation-foundation.png?height=600px)](/images/00-intro/initial-foundation-foundation.png)

## Foundation capabilities in scope

Initial degrees of foundational capabilities addressed by this guide include:

**Your Initial Overall AWS Environment**
* An initial AWS account structure
* Automated AWS account provisioning
* AWS accounts for foundation management and workload hosting environments including development, test, and production

**Security**
* AWS account hardening
* An initial set of guardrails to help ehance the security of your overall AWS environment
* Centralized logging of AWS API calls and AWS resource configuration changes
* Federated access to help manage human user access to your AWS environment
* Policies to help manage access to AWS accounts:
  * Cloud platform team access including cloud and security administration, audit, and finance
  * Builder team access to team development environments
  * Least privileged workload administrative access to test and production environments

**Networking**
* Virtual networking for workloads that depend on networking
* Hybrid on-premises network connectivity
* Internet integration

**Cost Management**
* Centralized billing and cost management