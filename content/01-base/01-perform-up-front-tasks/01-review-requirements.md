---
title: "Review Foundational Requirements"
menuTitle: "1. Review Requirements"
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section introduces the typical requirements for your inital foundation in support of development, test, and production environments. Organizations typically require at least the following capabilities when establishing their initial formal environments. A typical set of [optional capabilities]({{< relref "04-optional" >}}) are also addressed in this guide.

## Cloud Adoption Framework Perspectives

The following requirements are organized based on a series of perspectives defined in the [AWS Cloud Adoption Framework](https://aws.amazon.com/professional-services/CAF/).

## Business Perspectives

### Business

**Company Payment Instrument** - Use of company authorized payment instrument, e.g. corporate credit card, by centralized cloud owner to pay for AWS cloud resources.

**Cost Reporting** - Transparent and frequent cost reporting with alerts for greater than expected consumption.

### People

**Initial Cloud Platform Team** - The organization must have at least several technologists who are assigned to and capable of configuring and managing the initial phases of the enterprise’s use of AWS.

### Governance

**Involvement of Cross-Functional Teams** - Cross-functional departments such as Security, Compliance, Operations, and Finance are important stakeholders in the use of the AWS platform and must be part of the initial planning, design, and implementation effort.

**Sufficient Access Controls** - Sufficient access controls and permissions to protect the cloud foundation resources from inadvertent and intentional modification by unauthorized users.

**Clearly Defined Roles and Responsibilities** - Clearly defined roles and responsibilities for managing the use of AWS.

## Technical Perspectives

### Platform

#### Builder Team Requirements
**Sufficiently Isolated Team Development Environments** - An isolated environment for each team to carry out initial experiments and formal development work.

**Avoid Cross-Team Impacts** - Isolation from other builder teams being able to inadvertently impact a team's cloud resources.

**Cross-team Workload Access** - Ability to access other builder teams' deployed servies via networking where agreed and explicitly configured.

**Access from Corporate Desktops** - Access to AWS services and AWS-hosted workloads from the corporate desktops on the corporate network. Includes access to the AWS Management Console, AWS services APIs, and use of the AWS CLI.

**Access to Broad Set of AWS Services** - Access to a broad set of AWS services to enable experimentation and development.

**Ability to Develop and Test Workload-specific Resources** - Including broad access to create and manage application-oriented AWS Identity and Access Management (IAM) role and policy resources in support of experimenting and developing application and data services.

**Access to AWS Network Environment** - Access to an AWS network environment in support of those AWS services for which private networking is either required or desirable.
  
**Access to Select Internet Resources** - Access to Internet-hosted code and package repositories so that 3rd party packages and code can be downloaded to VMs hosted in AWS.

**Access to Corporate Source Code and Artifact Management Service** - Use of corporate source code management and artifact management services to manage code and access artifacts used in support of experiments and development.

**Self-Service AWS Costs Insights** - Insight into the costs of AWS services consumed in their development environments so that teams can make informed decisions.

**User Documentation** - Sufficient documentation to enable builders to get started in the new AWS environment.

{{% notice tip %}}
**Access to on-premises resources:** It's common that your builder teams' development environments and your test and/or production environments in AWS will need to have connectivity to some of your on-premises resources. For example, there may be existing test and production data services in your on-premises environment that your workloads in AWS will need to access.  If this is the case, you should review [On-premises Network Integration]({{< relref "01-hybrid-networking" >}}) for an overview of your options.
{{% /notice %}}

#### Cloud Platform Team Requirements

The initial cloud platform team needs an isolated environment in which they can develop and test foundation capabilities.
  * Separate from other builder teams and environments.
  * Potentially with wider access permissions than typical development teams to enable deeper foundation development work.

### Security

**Isolate AWS Development from Corporate Resources** - Sufficient isolation between cloud development environments and existing corporate resources.

**Inhibit Public Exposure of Cloud Resources** - Inhibit builder teams from making workloads and data publicly accessible from their development environments.

**Audit All AWS Activity** - Sufficient auditing of cloud access and activity and separation of duty for access to audit data.

**Use of Per User Identities** - Use of per user identities to separate access and ensure sufficient auditing.

**Multi-Factor Authentication** - Use of Multi-Factor Authentication (MFA) for all human user access to the AWS platform.

**Inhibit Use of Locally Managed IAM Users** - Inhibit use of IAM users for human access.

**Inhibit Use of Long-term AWS Access Keys** - Inhibit use of long-term access keys to access AWS services.

{{% notice tip %}}
**Reuse your corporate identity store and overall RBAC processes:** It's common for organizations planning to adopt AWS to require use of their existing corporate identity store and overall role based access control (RBAC) tools and procedures to grant users entitlements to applications. This guide recommends that you start simple by first using a small set of users and groups defined locally in the AWS SSO service.  Once you've established your initial foundation in AWS, the guide provides a summary of your federated access options and resources to enable you to evolve your AWS environment to use your existing corporate identity source.  See [Federated Access to Your AWS Environment]({{< relref "02-federated-access-to-aws" >}}) for an overview of your options.
{{% /notice %}}

### Operations

A sufficient set of runbooks and playbooks to support common operational needs and scenarios.
