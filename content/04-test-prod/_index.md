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

[![Initial Pre-Production Test and Production Environments in Single AWS Region](/images/04-test-prod/initial-foundation-test-prod-single-region.png)](/images/04-test-prod/initial-foundation-test-prod-single-region.png)

## Refine Requirements and Identify Solutions

### Governance
Moving workloads into a production phase often requires increased levels of governance and oversight.  There are many mechanisms and tools in AWS that can be used to build a strong governance function while still allowing flexibility and autonomy to the builder teams.  The primary mechanisms we've discussed in this guide are AWS Control Tower Guardrails set on the AWS Organizational Units, and Permission Boundaries to restrict IAM grants.

- SCPs
- Tagging Policies
- Security Hub etc etc
- Cloud Operating Model

### Data Classification and Compliance
- Tagging
- Resource Tagging Policies
- tagging, tag-on-create and Attribute-Based Access Control (ABAC)
- Macie

### Region Support
- Need for multi-region
- Region restrictions

### Pre-Production Test and Production AWS Account Design and Tenancy Model
  * Pre-Production Test, Production, and Builder Services AWS Accounts
  * Grouping like workloads together in same AWS accounts

### Workload Administration
  - Admin access into accounts
  - Runtime roles/policies
  - Monitoring
### Pre-Production Test and Production Networks
  * VPC Design - dedicated VPC?
  * On-premises Network Integration
  * DNS Integration
  * Internet Integration
### Initial Iteration of Workload Promotion and Release Management
* Evolved Foundation Baseline Management


## Deploy Workloads and Operate the Environment

...
