---
title: 'Use Organizational Units (OUs) to Structure Your AWS Accounts'
menuTitle: '4. Organize AWS Accounts'
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

## 1. Review example OU and account structures

Depending on the extent of your initial foundation build out, your initial OU and account structure will likely resemble one of the following examples.

The development and workloads AWS accounts names shown in the diagrams are examples. Depending on your needs, your AWS account names will vary. Refer to the [initial AWS accounts]({{< relref "02-obtain-email-addresses" >}}) for a description of the AWS accounts referenced in the diagrams.

{{% notice note %}}
**Your OU design is not intended to reflect your company's organizational structure:** AWS Organizations OUs are not meant to be used to reflect your enterprise's organizational structure. Instead, OUs are intended to provide a means to group AWS accounts that have similar security and operational requirements. 
{{% /notice %}}

{{% notice info %}}
**Your OU design will evolve:** Since you have the ability to move AWS accounts between OUs and modify OUs, you don't need to perform a complete OU design at this early stage. As you progress on your journey, you will evolve your OU design to suit your emerging needs.  If you'd like to learn more about OUs, see [AWS Organizations in Control Tower](https://docs.aws.amazon.com/controltower/latest/userguide/organizations.html).
{{% /notice %}}

### Minimal starter structure

The following OU and account structure is the bare minimum we recommend in support of your initial few production workloads.  In addition the AWS Organizations management account, there are the Audit and Log archive accounts created by AWS Control Tower.

We recommend that you create at least test and production workload accounts and associated OUs so that you have isolated environments in which to test and validate changes to your workload environments before promoting those changes to your production environment.

[![Minimal Starter Environment](/images/02-base/aws-accounts-ous-minimal.png?height=400px)](/images/02-base/aws-accounts-ous-minimal.png)

### Including development environments

If you have teams who need to perform experimentation and development of new workload configurations, we recommend that you establish flexible team development environments.

[![Dev Environments Included](/images/02-base/aws-accounts-ous-with-dev.png)](/images/02-base/aws-accounts-ous-with-dev.png)

### Including network and shared infrastructure services environments

If you have requirements to establish network connectivity between your on-premises and AWS environments, then it's recommended that you establish at least a production network account. Hybrid networking resources such as 

If you choose to set up the foundation for team development environments, you'll see later in this guide the recommendation to use a shared network across those environments.  Since it's expected to be a production quality foundational service, this centrally managed development network would also be managed within your production network environment.

If you have a need to support shared infratructure services such as hybrid DNS resolution or Active Directory (AD) in your AWS environment, we recommend that you establish a production infrastructure shared services account.

{{% notice note %}}
**Establishing test environments in the future:** As your use of AWS expands, you will likely benefit from establishing test environments to test and validate changes to your network and shared infrastructure before promoting those changes to your production environments.
{{% /notice %}}

[![Network and Shared Infrasructure Services Included](/images/02-base/aws-accounts-ous-with-infra.png)](/images/02-base/aws-accounts-ous-with-infra.png)

### OU Descriptions

|OU Name|Description|
|-------|------------|
|**`Core`**|Automatically created by AWS Control Tower. Includes several foundational AWS accounts.|
|**`infrastructure_dev`**|Includes the team development AWS account(s) for your Cloud Foundation teams. These AWS accounts will have more write access to AWS resources as compared to your standard team development AWS accounts. For example, the ability to create and manage foundational VPC resources.|
|**`infrastructure_prod`**|Includes foundation infrastructure related AWS accounts including the Network Production and Infrastructure Shared Services AWS accounts that you will create later in this guide. These accounts are managed by your Cloud Foundation team.|
|**`workloads_dev`**|Includes the bulk of your team development AWS accounts.|
|**`workloads_test`**|Includes the formal test environment AWS accounts for your business-oriented workloads.|
|**`workloads_prod`**|Includes the formal production environment AWS accounts for your business-oriented workloads.|

## 2. Add OUs

Based on the scope of your initial AWS environment, add the initial set of OUs to suit your needs.  Use the example structures above for guidance.

These OUs can be easily changed later.

Using AWS Control Tower, add the OUs:

1. Sign in to the AWS SSO URL for your environment using the **AWS Control Tower Administrator** user.
2. Select the AWS **`master`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`AWS Control Tower`**.
6. Select **`Organizational units`**.
7. Select **`Add an OU`**.  
8. Follow the prompts to create a new OU based on the names listed in table above.
