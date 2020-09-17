---
title: 'Setting Up Foundation for Test and Production Environments'
menuTitle: '3. Foundation for Test and Prod'
disableToc: true
weight: 30
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

{{% notice note %}}
**Review Note:** The pre-production test and production environment section is only sketched out topically at this stage. We expect to begin addressing this section after drafting the higher priority [Optional Capabilities]({{< relref "04-optional" >}}) section. If you have comments and suggestions about this guide, see [Contributing]({{< relref "03-contributors" >}}).
{{% /notice %}}

Once you've established your initial foundation and delivered the initial set of development environments to teams, your next step is to expand your foundation by introducing a set of capabilities that organizations typically require before moving workloads into production.

[![Initial Pre-Production Test and Production Environments in Single AWS Region](/images/03-preprod-prod/initial-foundation-test-prod-single-region.png)](/images/03-preprod-prod/initial-foundation-test-prod-single-region.png)

## Refine Requirements and Identify Solutions

* Governance
* Data Classification and Compliance
* Encryption
  * At Rest
  * In Transit
  * Key Management 
  * Certificate Management
* Multi-Region
* Pre-Production Test and Production AWS Account Design and Tenancy Model
  * Pre-Production Test, Production, and Builder Services AWS Accounts
  * Grouping like workloads together in same AWS accounts
* Pre-Production Test and Production Networks
  * VPC Design
  * On-premises Network Integration
  * DNS Integration
  * Internet Integration
* Initial Iteration of Workload Promotion and Release Management
* Evolved Foundation Baseline Management
* Cloud Operating Model
  * Defining who does what in terms of promotion and production operations
* Identity and Access Management
  * Enhanced Service Control Policies (SCPs)
  * IAM for:
    * Workloads
      * Runtimes
      * Lifecycle management
      * Operations and monitoring
    * Foundation
      * Runtimes
      * Lifecycle management
      * Operations and monitoring

## Establish the Environments

* Establish Pre-Production Test and Production AWS Accounts
* Establish Pre-Production Test and Product AWS Account Access Controls
* Enhance Development AWS Accounts with Production-like Access Controls (for early testing)
* Establish Pre-Production Test and Production Networks
* Onboard Foundation Team
  * Promotion and Release Management
  * Operational Monitoring and Support
* Establish Encryption Support
* Establish Promotion and Release Management Process
* Onboard Development Teams
  * Ability to Perform Early Testing of Production-like Access Controls in Development
  * Promotion and Release Management
  * Operational Monitoring and Support
  
## Deploy Workloads and Operate the Environment

...