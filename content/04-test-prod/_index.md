---
title: 'Setting Up Foundation for Test and Production Environments'
menuTitle: '4. Foundation for Test and Prod'
disableToc: true
weight: 40
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}
Once you've established your initial foundation and delivered the initial set of development environments to teams, your next step is to expand your foundation by introducing a set of capabilities that organizations typically require before moving workloads into production.

[![Initial test and Production Environments in Single AWS Region](/images/04-test-prod/initial-foundation-test-prod-single-region.jpg)](/images/04-test-prod/initial-foundation-test-prod-single-region.jpg)

## Refine Requirements and Identify Solutions

### Governance
Moving workloads into a production phase often requires increased levels of governance and oversight.  There are many mechanisms and tools in AWS that can be used to build a strong governance function while still allowing flexibility and autonomy to the builder teams.  The primary mechanisms we've discussed in this guide are AWS Control Tower Guardrails set on the AWS Organizational Units, and Permission Boundaries to restrict IAM grants.

### Tagging
Amazon Web Services allows customers to assign metadata to their AWS resources in the form
of tags. Each tag is a simple label consisting of a customer-defined key and an optional value
that can make it easier to manage, search for, and filter resources. Although there are no
inherent types of tags, they enable customers to categorize resources by purpose, owner,
environment, or other criteria.

[An effective tagging strategy](https://d1.awsstatic.com/whitepapers/aws-tagging-best-practices.pdf) supports automation, operations support, access control, and security risk management.  You can enforce your tagging strategy by applying Tag Policies on your AWS Organizational Units.  

### AWS Region Selection
This guide assumes that your workload will be deployed in a single region.  Every AWS region is comprised of at least two Availability Zones so they can support a wide variety of high-availability requirements for mission-critical workloads.

{{% notice tip %}}
**Choose your workload region carefully:** Most companies will want to consolidate infrastructure into a single region to avoid potential costs related to cross-region data transfer.  Each AWS region has a different cost structure and not all regions will have all AWS services available.
{{% /notice %}}

### AWS Account Tenancy Model
AWS Control Tower scales operations to enable customers to support hundreds of distinct and isolated AWS accounts.  This guide assumes a distinct AWS account will be created for each workload environment beyond the team development accounts.  However, there are other valid approaches that might be right for your enterprise, such as accounts related to physical locations or workgroups.  AWS accounts can scale to support hundreds of distinct workloads; most of the AWS limits are "soft" limits and can be increased via request to AWS Support.

### Workload Administration
Resources deployed in support of workloads will often require operational access to perform runbook tasks.  This group will traditionally be distinct from the Foundation and Development teams.  This might be dependent on [the cloud operating model](https://d1.awsstatic.com/whitepapers/building-a-cloud-operating-model.pdf) that your organization is adopting.  As you scale up your usage in the cloud, most organzations will move to a more distributed "DevOps" model.  This guide assumes the creation of a workload adminstration team and role to support this scenario.

The Workload Administration team will be responsible for operations and monitoring of the workload.  Additionally we assume they need to use IAM to create roles and policies necessary to run the workload securely.  IAM Permissions Boundaries will be used to ensure that this access does not cause conflict with policies put in place by the Cloud and Security Administration teams.

### Networking Support
The first production workload hosted in AWS is often a trigger to implement [hybrid networking solutions]({{<ref "/05-optional/01-hybrid-networking/" >}}).  Hybrid networking enables integration with systems and tools residing on-prem over secure channels.

### Encryption Support
End-to-end encryption is often a requirement of production workloads.  All calls to the AWS control plane are encrypted in transit using TLS.  Customers can employ [AWS Certificate Manager](https://aws.amazon.com/certificate-manager) to manage TLS certificates for their workloads.  Most AWS services support native encryption at-rest using customer-managed keys.  [AWS Key Management Service (KMS)](https://aws.amazon.com/kms) presents a single control point to manage keys and define policies consistently across integrated AWS services and your own applications.
