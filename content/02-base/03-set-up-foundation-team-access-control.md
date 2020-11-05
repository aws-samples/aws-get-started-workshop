---
title: 'Set Up Foundation Access Controls'
menuTitle: '3. Set Up Foundation Access'
disableToc: true
weight: 30
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this step your Security and Cloud Administrators will decide on and implement the initial approach to controlling foundation team member access to the AWS platform.

This step should take about 30 minutes to complete.

{{< toc >}}

## 1. Temporarily Use AWS SSO Locally Managed Users and Groups

If your team needs to move very quickly in a matter of 1-2 days to establish your initial development environments and does not have an immediate requirement to integrate your existing enterprise identity management system to help control access to the AWS platform, then it’s recommended that:

1. Your Security and Cloud Administrators temporarily define and manage users and groups within the AWS SSO service.
2. Make plans for a parallel workstream to integrate your preferred enterprise identity management system with the AWS platform and transition away from locally managed users and groups in the AWS SSO service. See [Federated Access to Your AWS Environment]({{< relref "02-federated-access-to-aws" >}}) for an overview of your options.

{{% notice info %}}
**What about AWS IAM users and groups?:** Although the AWS Identity and Access Management (AWS IAM) service supports management of locally defined users and groups, it’s generally not recommended that customers depend on this capability to help manage human user access to the AWS platform _at scale_. Instead, AWS recommends that you reuse your preferred enterprise identity management system and associated processes to act as the basis for human user access to the AWS platform.
{{% /notice %}}

## 2. Map Foundation Functional Roles to Existing AWS Groups {#map-foundation-functional-roles}

Earlier in this guide you should have mapped your foundation team members to the [initial set of functional roles]({{< relref "04-map-people-to-foundation-roles.md" >}}) to be played in support of your AWS environment. 

The following table represents a mapping of those functional roles to a set of AWS SSO groups and permissions. Although AWS Control Tower automatically provisioned most of the AWS SSO groups, several of the groups in the table are not pre-defined. You will create these custom groups later in this section.

|Foundation Functional Role|AWS SSO Groups|Effective Permissions|
|---	|---	|--- |
|**Cloud Administration**|`AWSControlTowerAdmins`|[Administrator](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_job-functions.html#jf_administrator) access in the master, log archive, and audit accounts.|
| |`AWSAccountFactory`|Ability to use the Account Factory product via AWS Service Catalog.|
| |`example-cloud-admin`|[Administrator](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_job-functions.html#jf_administrator) access in all other AWS accounts.
|**Security Administration**|`AWSAuditAccountAdmins`|[Administrator](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_job-functions.html#jf_administrator) access in the audit account.|
| |`AWSLogArchiveAdmins`|[Administrator](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_job-functions.html#jf_administrator) access in the log archive account.|
|**Cost Management**|`example-cost-mgmt`|[Billing and cost management](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_job-functions.html#jf_accounts-payable) access in the management account.|
|**Audit**|`AWSSecurityAuditors`|Read only access in all accounts.|

{{% notice info %}}
**Your AWS platform access permissions will evolve:** The initial mapping of functional roles to groups in AWS SSO and the underlying permissions associated with those groups shown in the table above is only a simple starting point for your AWS platform access permissions for foundation team members. As you progress on your journey, you will evolve these groups and underlying permissions to meet your needs.
{{% /notice %}}

## 3. Access AWS SSO Using Your AWS Control Tower Administrator User

You'll need to use the AWS SSO service to add a new groups for Cloud Administrators and Cost Managers and create users for foundation team members.

Since you have not yet created users in AWS SSO for each member of your foundation team, your Security or Cloud Administrator team members will need to use the AWS Control Tower Administrative user to start adding AWS SSO users for each foundation team member.  Once these users have been onboarded in a subsequent step, you can stop using the AWS Control Tower Administrator user.

Access the AWS SSO service:

1. Sign in to the AWS SSO URL for your environment using the **AWS Control Tower Administrator** user.
2. Select the AWS **`management`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`AWS SSO`**.

{{% notice info %}}
**Permissions error:** If you encounter a permissions error when attempting to access AWS SSO via the AWS Management Console, ensure that you've selected the proper AWS account and role, `AWSAdministratorAccess`.
{{% /notice %}}

## 4. Customize AWS SSO Portal URL

As an optional step, you may want to customize the URL that you use to access the AWS SSO portal.  

If you have plans to implement your own vanity URL for the portal, you can skip this step.

The default form the portal URL is similar to this example of: `https://d-3a274d5e7d.awsapps.com/start`. Via the AWS SSO settings, you can customize the `d-3a274d5e7d` portion of the URL shown in the example.

1. Access **`Groups`** in AWS SSO.
2. Select **`Settings`**.
3. Under **`User portal`**, select **`Customize`**.
4. Set the first portion of the URL to a unique value.  Use your identifier, stock ticker symbol, or another identifier that you use as an abbreviated reference to your environments.

## 5. Add a Cloud Admin Group in AWS SSO

Since Cloud Administrators don't have administrator access to newly created AWS accounts, you'll need to start laying the groundwork for this access by adding a new group in AWS SSO. In a subsequent step, you'll add Cloud Administrator team members to the new group. Later on, after the initial set of team development AWS account are created, you will assign this group and a permission set to each of those new accounts so that the Cloud Administrators can gain administrator level access to manage those accounts. 

1. Access **`Groups`** in AWS SSO.
2. Select **`Create group`**.
3. Provide a group name. For example **`example-cloud-admin`**. Where you should replace `example` with a common abbreviation for your organization.
4. Provide a description. For example, **`Cloud administration`**.
5. Select **`Create`**.

{{% notice tip %}}
**Cloud Resource Naming - Using Qualifiers in Shared Namespaces:** When adding cloud resources to a shared namespace, it's a best practice to prefix those resource names with an organization identifier so that you avoid conflict with AWS-managed resources and can easily identify your own custom resources.
{{% /notice %}}

{{% notice tip %}}
**Cloud Resource Naming - Lower Case, Camel Case, etc:** Most AWS cloud resource names support using a range of characters and cases.  Typically, AWS-managed resources use camel case, but organizations often standardize on one style and strive to use that style throughout their cloud environment.
{{% /notice %}}

## 6. Add a Cost Management Group and Assign Permissions in AWS SSO

Since there's no suitable predefined AWS SSO group for cost management team members, you need to add a new group in AWS SSO and associate the necessary permissions with that group. In a subsequent step, you'll add cost management team members to the new group. 

In the spirit of least privilege access, the resulting permissions will enable cost management team members to access only your master AWS account and only the cost management and billing resources and data accessible within that AWS account.

### Add Cost Management Group in AWS SSO

1. Access **`Groups`** in AWS SSO.
2. Select **`Create group`**.
3. Provide a group name. For example **`example-cost-mgmt`**. Where you should replace `example` with a common abbreviation for your organization.
4. Provide a description. For example, **'Cost management and billing`**.
5. Select **`Create`**.

### Associate Group and Permission Set with AWS Management Account

1. Access **`AWS accounts`** in AWS SSO.
2. Select the checkbox next to your **`management`** AWS account.
3. Select **`Assign users`**.
4. Select **`Groups`**.
5. Select the checkbox next to **`example-cost-mgmt`** or similar.
6. Select **`Next: Permission sets`**.

### Create New Permission Set for Billing

7. Select **`Use an existing job function policy`**.
8. Select **`Next: Details`**.
9. Select **`Billing`**.
10. Select **`Next: Tags`**.
11. Select **`Next: Review`**.
12. Select **`Create`**. 

### Associate Billing Permission Set 

12. Select the checkbox next to **`Billing`**.
13. Select **`Finish`**.

AWS SSO deploys the selected permission set to the selected AWS account.
