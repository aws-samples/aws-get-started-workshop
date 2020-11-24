---
title: 'Obtain Email Addresses for New AWS Accounts'
menuTitle: '2. Obtain Email Addresses'
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

Regardless as to whether you create a new management AWS account or reuse an existing management AWS account, you'll need to prepare a set of email addresses to represent the root user of each of the new AWS accounts that will be created. In later steps, when you create AWS accounts, you'll be referring to these email addresses. Each AWS account must have a unique email address associated with it.

{{< toc >}}

## Use either email distribution lists (DLs) or shared mailboxes
Instead of using a person's email address, it's recommended that you use either email distribution lists (DLs) or shared mailboxes so that you can enable at least several trusted people, for example, your Cloud Administrators, access to email messages associated with each AWS account.

## Carefully control access to the email accounts
Since the email address associated with an AWS account is used as the [root user login for the account](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html), anyone with access to that email account will have access to password reset process for the account.

## Define and request DLs or shared mailboxes
The following diagram and table include the minimum set of email addresses to get started. Each AWS account must have a globally unique email address.

Several optional AWS accounts and email addresses are included in the table depending on the extent of capabilities you expect to require in the initial form of your AWS environment.

If you already have a naming standard for mail addresses associated with services, you should use that standard format and include references to at least "aws" and an abbreviation of the unique role or purpose of each account.

Use your standard internal process to request either DLs or shared mailboxes based on set of addresses you identify.

## Use of “+” style email addresses

Your email system might support the use of “+” style email addresses (also known as plus addressing or subaddressing) in which multiple email addresses are aliased to the same email account or distribution list. If this is the case, then you might find it beneficial to use this feature to reduce the number of email accounts or DLs that you need to create in support of your AWS accounts.

For example, the addresses [aws-account1+management@example.com](mailto:aws-account+management@example.com) and [aws-account1+audit@example.com](mailto:aws-account+audit@example.com) will be treated as unique addresses in AWS, but with the use of plus addressing, your mail system would deliver messages for both of these addresses to the same [aws-account1@example.com](mailto:aws-account@example.com) email account or distribution list.

In 2020, Microsoft 365 introduced support for [plus addressing in Exchange Online](https://docs.microsoft.com/en-us/exchange/recipients-in-exchange-online/plus-addressing-in-exchange-online).

## AWS accounts and example email addresses

### Management AWS account {#initial-aws-accounts}

|AWS Account Name|Purpose|Email Address Example|"+" Addressing Example|
|---|---|---|---|
|**`management`**|You'll either create a new management AWS account or reuse an existing compatible AWS account.|`aws-account-management@example.com`|`aws-account+management@example.com`|

### Foundational AWS accounts {#foundation-aws-accounts}

|AWS Account Name|Purpose|Email Address Example|"+" Addressing Example|
|---|---|---|---|
|**`Audit`**|Created by AWS Control Tower.|`aws-account-audit@example.com`|`aws-account+audit@example.com`|
|**`Log archive`**|Created by AWS Control Tower.|`aws-account-log-archive@example.com`|`aws-account+log-archive@example.com`|
|**`dev-infra`**|Environment where your Cloud Foundation team can develop and perform early testing of foundation changes.<br><br>If you have a very small cross-functional team responsible for managing your initial foundation, then you'll likely need to start with only one foundation team development AWS account.|`aws-account-dev-infra@example.com`|`aws-account+dev-infra@example.com`|
|**`network-prod`**|Centrally managed network resources.<br><br>For example, hybrid networking resources such as AWS Site-to-Site VPN and AWS Transit Gateway resources.|`aws-account-network-prod@example.com`|`aws-account+network-prod@example.com`|
|**`infra-shared-prod`**|Shared infrastructure services.<br><br>Recommended if you plan to connect your on-premises network to your AWS environment.<br><br>For example, this AWS account can host shared directory services such as Microsoft Active Directory and contain resources to support integration with your on-premises DNS services.|`aws-account-infra-shared-prod@example.com`|`aws-account+infra-shared-prod@example.com`|

### Team development and workload environments AWS accounts {#other-aws-accounts}

|AWS Account Name|Purpose|Email Address Example|"+" Addressing Example|
|---|---|---|---|
|**`dev-<team identifier>`**|A team development environment for your builder team that needs to experiment, develop, and perform early testing of their initial workloads.<br><br>You should 1) identify how many distinct teams will be developing and performing early testing of your initial workloads and 2) arrive at an AWS account name and email address for each team.|`aws-account-dev-<team identifier>@example.com`|`aws-account+dev-<team identifier>@example.com`|
|**`workloads-test-<workload group identifier>`**|Formal test environments for your business-oriented workloads and data.<br><br>You should 1) identify how many distinct groups of related workloads you'll initially be supporting and 2) arrive at an AWS account name and email address for each distinct group.<br><br>For example `workloads-test-vdi` and `workloads-prod-vdi` for a set of accounts supporting virtual desktop infrastructure (VDI) workloads.|`aws-account-workloads-test-<workload-group-identifier>@example.com`|`aws-account+workloads-test-<workload-group-identifier>@example.com`|
|**`workloads-prod-<workload group identifier>`**|Environment where your initial production workloads and data will reside.|`aws-account-workloads-prod-<workload-group-identifier>@example.com`|`aws-account+workloads-prod-<workload-group-identifier>@example.com`|