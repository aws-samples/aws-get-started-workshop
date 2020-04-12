---
title: "Review Development Environment Requirements"
menuTitle: "1. Review Requirements"
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section introduces the typical requirements for your inital formal development environments and the supporting foundation. Organizations typically require at least the following capabilities when establishing their initial formal development environments. A separate set of sections address a series of [development fast follow capabilities]({{< relref "02-dev-fast-follow" >}}) that might be required up front depending on your organization's needs.

## Cloud Adoption Framework Perspectives

The following requirements are organized based on a series of perspectives defined in the [AWS Cloud Adoption Framework](https://aws.amazon.com/professional-services/CAF/).

## Business Perspectives

### Business
* Use of company authorized payment instrument, e.g. corporate credit card, by centralized cloud owner to pay for AWS cloud resources.
* Transparent and frequent cost reporting with alerts for greater than expected consumption.

### People
* The organization must have at least several technologists who are assigned to and capable of configuring and managing the initial phases of the enterprise’s use of AWS.

### Governance
* Cross-functional departments such as Security, Compliance, Operations, and Finance are important stakeholders in the use of the AWS platform and must be part of the initial planning, design, and implementation effort.
* Sufficient access controls and permissions to protect the cloud foundation resources from inadvertent and intentional modification by unauthorized users.
* Clearly defined roles and responsibilities for managing the use of AWS.

## Technical Perspectives

### Platform
* Builder Team Requirements
  * An isolated environment for each team to carry out initial experiments and formal development work.
  * Isolation from other builder teams being able to inadvertently impact a team's cloud resources.
  * Ability to access other builder teams' deployed servies via networking where agreed and explicitly configured.
  * Access to AWS services and AWS-hosted workloads from the corporate desktops on the corporate network.
    * CLI and API access to AWS services.
  * Access to a broad set of AWS services to enable experimentation and development.
    * Including broad access to create and manage application-oriented AWS IAM role and policy resources in support of experimenting and developing application and data services.
  * Access to an AWS network environment in support of those AWS services for which private networking is either required or desirable.
  * Access to Internet-hosted code and package repositories so that 3rd party packages and code can be downloaded to VMs hosted in AWS.
  * Use of corporate source code management services to manage code used in support of experiments and development.
  * Insight into the costs of AWS services consumed in their development environments so that teams can make informed decisions.
  * Sufficient documentation to enable builders to get started in the new AWS environment.
* The initial cloud platform team needs an isolated environment in which they can develop and test foundation capabilities.
  * Separate from other builder teams and environments.
  * Potentially with wider access permissions than typical development teams to enable deeper foundation development work.

### Security
* Sufficient isolation between cloud development environments and existing corporate resources.
* Inhibit builder teams from making workloads publicly accessible from their development environments.
* Sufficient auditing of cloud access and activity and separation of duty for access to audit data.
 * Use of per user identities to separate access and ensure sufficient auditing.
* Use of Multi-Factor Authentication (MFA) for all human user access to the AWS platform.
* Inhibit use of IAM users for human access.
* Inhibit use of long-term access keys to access AWS services.

### Operations
* A sufficient set of runbooks and playbooks to support common operational needs and scenarios.
