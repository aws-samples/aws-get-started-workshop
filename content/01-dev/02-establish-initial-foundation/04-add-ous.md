---
title: 'Add Organizational Units (OUs)'
menuTitle: '4. Add OUs'
disableToc: true
weight: 40
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this step your Security and Cloud Administrators will add an initial set of AWS Organizations Organizational Units (OUs) to help you organize your first set of AWS accounts.

This step should take about 10 minutes to complete.

{{< toc >}}

## 1. Review Example OUs

The following diagram represents an example set of OUs and AWS accounts that can help you get started with your initial AWS environment in support of your first few production workloads. This initial set of OUs is intended to enable you to group AWS accounts that have similar security and management needs.

The development and workloads AWS accounts names shown in the diagram are examples. Depending on your needs, your AWS account names will vary. Refer to the [initial AWS accounts]({{< relref "04-address-prerequisites#initial-aws-accounts" >}}) for a description of the AWS accounts referenced in the diagram.

[![Initial OUs and AWS Accounts](/images/01-dev/aws-accounts-ous.png)](/images/01-dev/aws-accounts-ous.png)

### Foundational OUs

|OU Name|Description|
|-------|------------|
|**`Core`**|Automatically created by AWS Control Tower. Includes several foundational AWS accounts.|
|**`infrastructure-prod`**|Includes foundation infrastructure related AWS accounts including the Network Production and Infrastructure Shared Services AWS accounts that you will create later in this guide. These accounts are managed by your Cloud Foundation team.|

### Business-oriented OUs

|OU Name|Description|
|-------|------------|
|**`development-foundation`**|Includes the team development AWS account(s) for your Cloud Foundation teams. These AWS accounts will have more write access to AWS resources as compared to your standard team development AWS accounts. For example, the ability to create and manage foundational VPC resources.|
|**`development-standard`**|Includes the bulk of your team development AWS accounts.|
|**`workloads-test`**|Includes the formal test environment AWS accounts for your business-oriented workloads.|
|**`workloads-prod`**|Includes the formal production environment AWS accounts for your business-oriented workloads.|

{{% notice note %}}
**Your OU design is not intended to reflect your company's organizational structure:** AWS Organizations OUs are not meant to be used to reflect your enterprise's organizational structure. Instead, OUs are intended to provide a means to group AWS accounts that have similar security and operational requirements. 
{{% /notice %}}

{{% notice info %}}
**Your OU design will evolve:** Since you have the ability to move AWS accounts between OUs and modify OUs, you don't need to perform a complete OU design at this early stage. As you progress on your journey, you will evolve your OU design to suit your emerging needs.  If you'd like to learn more about OUs, see [AWS Organizations in Control Tower](https://docs.aws.amazon.com/controltower/latest/userguide/organizations.html).
{{% /notice %}}

## 2. Add OUs

Using AWS Control Tower, add the OUs:

1. Sign in to the AWS SSO URL for your environment using the **AWS Control Tower Administrator** user.
2. Select the AWS **`master`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`AWS Control Tower`**.
6. Select **`Organizational units`**.
7. Select **`Add an OU`**.  
8. Follow the prompts to create a new OU based on the names listed in table above.
