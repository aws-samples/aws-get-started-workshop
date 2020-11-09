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

This guide helps you establish a set of AWS foundational capabilities to help support your use of development, test, and production environments to host your first few initial workloads.  

{{< toc >}}

## Workload-specific Capabilities

Other capabilities that are specific to your workloads and your desired Software Development Lifecycle (SDLC) and operational processes including supporting tools are not currently addressed by this guide. You'll layer those capabilities and solutions on top of the initial foundation capabilities addressed in this guide.

## An Initial Foundation

Even in the early project stage of adoption, AWS recommends that an initial foundation be established that can be extended over time as you transition into the foundation stage to prepare for larger scale cloud adoption. This guide will help you establish the beginning of a secure foundation on AWS in support of your initial few projects.

The guide starts with establishing an initial foundation in support of several development environments before it addresses how to extend your foundation to support deploying your first few workloads to test and production environments.  

The guide also address a set of "fast follow" capabilities that, for some organizations, are required before those organizations either perform formal experiments and development in the cloud or move an initial set of workloads into production.

Later, after you've demonstrated success with the initial few projects, you will likely make larger investments during the foundation stage of your journey to support cloud adoption at scale.

![Cloud Foundation](/images/00-intro/foundation.png)

## Foundation Capabilities in Scope

Initial forms of foundation capabilities addressed by this guide include:

**Your Initial Overall AWS Environment**
* An initial AWS account structure
* Automated AWS account provisioning
* AWS accounts for foundation management and workload hosting environments including development, test, and production

**Security**
* AWS account hardening
* Guardrails for overall AWS environment security
* Centralized secure logging of AWS API calls and AWS resource configuration changes
* Federated access to the AWS platform
* Policies for managing access to AWS accounts:
  * Cloud platform team access including cloud and security administration, audit, and finance
  * Builder team access to team development environments
  * Least privileged workload administrative access to test and production environments

**Networking**
* Virtual networking for hosting workloads
* On-premises network connectivity
* Internet integration

**Cost Management**
* Centralized billing and cost management

{{% notice note %}}
**Review Note:** Insert a layered architecture diagram to highlight the foundational capabilities that you will establish via this guide in support of your first few workloads moving into production will be just the start of an ongoing establishment of foundational capabilities.  The upper layers of the diagram will show capabilites that are more workload and perhaps origanizational tool specific that are not addressed by the guide.  For example, what the customer puts into their team development AWS accounts is outside the scope of the guide.
{{% /notice %}}

## Progression of Foundation Capabilities

{{% notice note %}}
**Review Note:** This section will use the familiar notion of "crawl, walk, run" to emphasize that the initial set of capabilities and their degrees of realization as addressed in this guide is more akin to the "crawl" stage of cloud adoption and that further investment in the foundation is often needed as adoption expands. 
{{% /notice %}}