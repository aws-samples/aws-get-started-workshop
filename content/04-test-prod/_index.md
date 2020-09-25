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

<<<<<<< HEAD
=======
{{% notice note %}}
**Review Note:** The test and production environment section is only sketched out topically at this stage. We expect to begin addressing this section after drafting the higher priority [Optional Capabilities]({{< relref "05-optional" >}}) section. If you have comments and suggestions about this guide, see [Contributing]({{< relref "03-contributors" >}}).
{{% /notice %}}

>>>>>>> master
Once you've established your initial foundation and delivered the initial set of development environments to teams, your next step is to expand your foundation by introducing a set of capabilities that organizations typically require before moving workloads into production.

[![Initial test and Production Environments in Single AWS Region](/images/04-test-prod/initial-foundation-test-prod-single-region.png)](/images/04-test-prod/initial-foundation-test-prod-single-region.png)

## Refine Requirements and Identify Solutions

<<<<<<< HEAD
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
=======
* Governance
* Data Classification and Compliance
* Encryption
  * At Rest
  * In Transit
  * Key Management 
  * Certificate Management
* Multi-Region
* test and Production AWS Account Design and Tenancy Model
  * Pre-Production Test, Production, and Builder Services AWS Accounts
  * Grouping like workloads together in same AWS accounts
* test and Production Networks
  * VPC Design
>>>>>>> master
  * On-premises Network Integration
  * DNS Integration
  * Internet Integration
### Initial Iteration of Workload Promotion and Release Management
* Evolved Foundation Baseline Management


<<<<<<< HEAD
=======
* Establish test and Production AWS Accounts
* Establish test and Product AWS Account Access Controls
* Enhance Development AWS Accounts with Production-like Access Controls (for early testing)
* Establish test and Production Networks
* Onboard Foundation Team
  * Promotion and Release Management
  * Operational Monitoring and Support
* Establish Encryption Support
* Establish Promotion and Release Management Process
* Onboard Development Teams
  * Ability to Perform Early Testing of Production-like Access Controls in Development
  * Promotion and Release Management
  * Operational Monitoring and Support
  
>>>>>>> master
## Deploy Workloads and Operate the Environment

...
