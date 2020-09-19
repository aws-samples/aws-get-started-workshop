---
title: 'Create or Prepare Management AWS Account'
menuTitle: '1. Prepare Management AWS Account'
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this step your Cloud Administrators will either reuse an existing AWS Organizations management AWS account or use the standard AWS new account creation process to create a new “management” AWS account.

This step should take about 20 minutes to create a new AWS management account and just a few minutes to prepare an existing AWS management account.

{{< toc >}}

## 1. Review the benefits of using multiple AWS accounts

AWS accounts are coarse grained resource containers that help you isolate and secure different collections of cloud resources and data. Use of multiple AWS accounts can make your use of cloud more secure by providing clear ownership and control boundaries and lowering the blast radius of any particular set of cloud resources. 

In support of your initial need for team development environments, this guide first leads you through the process to create an initial set of foundation and builder team development AWS accounts.  Later in the guide, you will create a series of pre-production test and production AWS accounts to isolate the formal pre-production test and production environments from your development environments.

Over the course of your cloud adoption journey, you will likely end up with a number of accounts ranging from a dozen or so to hundreds depending on the size of your application and data services portfolio and the granularity by which you choose to isolate the associated cloud resources and data across your organization and across the software development lifecycle (SDLC).

## 2. Determine whether to reuse existing management AWS account

Determine whether you will create a new management AWS account or reuse an existing management AWS account in order to use AWS Control Tower to establish your initial landing zone.

Review [Plan Your AWS Control Tower Landing Zone](https://docs.aws.amazon.com/controltower/latest/userguide/planning-your-deployment.html) for guidance when considering whether or not to use an existing management AWS account.

If you plan to create a new management AWS account, proceed to the next step.

If you'd like to reuse an existing management AWS account, proceed to [8. Create an IAM user for Administrative Bootstrap Purposes]({{< relref "#iam-bootstrap-user" >}}) to ensure that you have a suitable AWS IAM administrative user account that you'll use in the next section.

## 3. Start with a new management AWS account

The initial AWS account that you create will be configured as a new management AWS account in which billing for AWS services consumed across accounts will be consolidated and your Cloud Administrators will provision new “member” AWS accounts for builder teams.

After you create your new management AWS account, you can make use of a standard process to move any existing AWS accounts into your new management AWS account so that you can easily consolidate billing and day-to-day management of all of your AWS accounts.

## 4. Create a new AWS management account

Visit [Create an AWS Account](https://portal.aws.amazon.com/billing/signup#/start) and enter the the required information on the following page.

|Field|Description|Tips|
|-----|------------|---|
|**Email address**|A unique email address that identifies the AWS account and is the name of the AWS account root user.|Use the management AWS account [root user email address]({{< relref "04-address-prerequisites#initial-aws-accounts" >}}) that you already established. Since this email address is used to initially access your AWS account, be very careful that you enter the correct email address and that you have access to the email account.|
|**Password**|A password for the AWS account root user.|Ensure that secure this value. In a later step, you'll have the option to enable Multi-factor Authentication (MFA) - a highly recommended approach to secure your AWS account.|
|**AWS account name**|A brief identifier for the AWS account.|For example, **`management`**. This value does not have to be unique and can be modified later on.|

### Set personal or professional

Set your account to either personal or professional.  Both types of accounts have the same functionality and features.  Enter your personal or professional information and then read and accept the [AWS Customer Agreement](https://aws.amazon.com/agreement/).

### Provide billing information

At this point, you’ll have an account created and you’ll get a confirmation email.  However, you’ll need to enter billing information before you can continue.

Add a payment method and contact information for the billing method.  You’ll go through a brief account verification process via a mobile device so enter a phone number you have current access to.

### Select a support plan

On the Select a Support Plan page, choose one of the available support plans.  Since your organization is going to be using AWS for formal development and eventually production purposes, we recommend that you start by selecting at least “Developer” support. 

Before you transition any applications or data services to production, it's strongly recommended that you upgrade to "Business" support.  

Once you are preparing to host business critical workloads and data in the cloud, you should consider upgrading to "Enterprise" support levels. 

See [AWS Support Plans](https://aws.amazon.com/premiumsupport/plans/) for a description of features and benefits of each level of support.

## 5. Receive confirmation email

In a few minutes your account should be fully activated and you’ll receive a confirmation email.  If you don’t, review the troubleshooting steps from the [Create and Activate an AWS Account support page](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)

## 6. Secure your AWS account root user

It’s strongly recommended and an AWS security best practice to enable multi-factor authentication (MFA) to the AWS account root user and to avoid using the root user, even for administrative tasks, from this point forward.

See [Enable MFA on the AWS Account Root User](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html#id_root-user_manage_mfa) for instructions.

{{% notice warning %}}
**Do not create administrative access keys for the root user:** Under no circumstances create programmatic access keys for your AWS account root user and admininistrative bootstrap users.
{{% /notice %}}

## 7. Set alternate contacts

Using the root user, set the Alternate Contacts for your account so that notifications of billing, operations, and security events are routed to the proper teams.  As a best practice, you can use email distribution lists so that notifications are set to multiple people in the same team.

Access [Account  Settings](https://console.aws.amazon.com/billing/home?#/account) in the AWS Management Console to set the Alternate Contacts.

## 8. Create an IAM user for administrative bootstrap purposes {#iam-bootstrap-user}

Although you will be provisioning cloud administrator and builder user accounts via the AWS Single Sign-on (SSO) service later in this guide, it is required that you first create an administrative bootstrap user account via the AWS Identity and Access Management (IAM) service and switch to that user to set up the next parts of your initial foundation.

This administrative user should be only used to complete your initial foundation setup and act as a “break glass” user in case access via AWS SSO user accounts encounters an issue.

### Recommendations for administrative bootstrap user

* Since this account will only be used for break glass purposes after your foundation has been established, you don’t need to associate the user with a human user. Instead, you can use a name such as “Administrator”.
* Enable “AWS Management Console access” only for this user. “Programmatic access” should not be necessary for this user.

### Create the administrative bootstrap user

While logged in as the root user, follow the instructions in [Create an IAM user](https://docs.aws.amazon.com/controltower/latest/userguide/setting-up.html#setting-up-iam) to create this administrative user.

Once the user has been created, sign into the AWS Management Console as the user and enable MFA to help secure the account. See [Enable a Virtual MFA Device fo an IAM User](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa_enable_virtual.html#enable-virt-mfa-for-iam-user).
