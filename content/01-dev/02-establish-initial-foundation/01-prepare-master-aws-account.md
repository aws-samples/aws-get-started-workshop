---
title: 'Create or Prepare Master AWS Account'
menuTitle: 'Prepare Master AWS Account'
pre: "1. "
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this step your Cloud Administrators will either reuse an existing master AWS account or use the standard AWS new account creation process to create a new “master” AWS account.

This step should take about 20 minutes to create a new AWS master account and just a few minutes to prepare an existing AWS master account.

{{< toc >}}

## 1. Review the Benefits of Using Multiple AWS Accounts

AWS accounts are coarse grained resource containers that help you isolate and secure different collections of cloud resources and data. Use of multiple AWS accounts can make your use of cloud more secure by providing clear ownership and control boundaries and lowering the blast radius of any particular set of cloud resources. 

In support of your initial need for team development environments, this guide first leads you through the process to create an initial set of foundation and builder team development AWS accounts.  Later in the guide, you will create a series of pre-production test and production AWS accounts to isolate the formal pre-production test and production environments from your development environments.

Over the course of your cloud adoption journey, you will likely end up with a number of accounts ranging from a dozen or so to hundreds depending on the size of your application and data services portfolio and the granularity by which you choose to isolate the associated cloud resources and data across your organization and across the software development lifecycle (SDLC).

## 2. Determine Whether to Reuse Existing Master AWS Account

Determine whether or not you want to create a new master AWS account or reuse an existing master AWS account in order to use AWS Control Tower to establish your initial landing zone.

Review [Plan Your AWS Control Tower Landing Zone](https://docs.aws.amazon.com/controltower/latest/userguide/planning-your-deployment.html) for guidance when considering whether or not to use an existing master AWS account.

If you either don't have an existing master AWS account or you don't want to reuse an existing master AWS account, proceed to the next step.

If you'd like to reuse an existing master AWS account, proceed to [8. Create an IAM user for Administrative Bootstrap Purposes](#8-create-an-iam-user-for-administrative-bootstrap-purposes) to ensure that you have a suitable AWS IAM administrative user account that you'll use in the next section.

## 3. Start With a New Master AWS Account

The initial AWS account that you create will be configured as a new master AWS account in which billing for AWS services consumed across accounts will be consolidated and your Cloud Administrators will provision new “member” AWS accounts for builder teams.

After you create your new master AWS account, you can make use of a standard process to move any existing AWS accounts into your new master AWS account so that you can easily consolidate billing and day-to-day management of all of your AWS accounts.

## 4. Create a New AWS Master Account

Visit https://aws.amazon.com/ and click “Create AWS Account” and enter the the required information on the following page.

### Provide Account Root User’s Email Address

Use the master AWS account [root user email address]({{< relref "04-address-prerequisites.md#1-create-email-addresses-for-new-aws-accounts" >}}) that you already established. Since this email address is used to initially access your AWS account, be very careful that you enter the correct email address and that you have access to the email account.

### Set Personal or Professional

Set your account to either personal or professional.  Both types of accounts have the same functionality and features.  Enter your personal or professional information and then read and accept the [AWS Customer Agreement](https://aws.amazon.com/agreement/).

### Provide Billing Information

At this point, you’ll have an account created and you’ll get a confirmation email.  However, you’ll need to enter billing information before you can continue.

Add a payment method and contact information for the billing method.  You’ll go through a brief account verification process via a mobile device so enter a phone number you have current access to.

### Select a Support Plan

On the Select a Support Plan page, choose one of the available support plans.  Since your organization is going to be using AWS for formal development and eventually production purposes, we recommend that you start by selecting at least “Developer” support. 

Before you transition any applications or data services to production, it's strongly recommended that you upgrade to "Business" support.  

Once you are preparing to host business critical workloads and data in the cloud, you should consider upgrading to "Enterprise" support levels. 

See [AWS Support Plans](https://aws.amazon.com/premiumsupport/plans/) for a description of features and benefits of each level of support.

## 5. Receive Confirmation Email

In a few minutes your account should be fully activated and you’ll receive a confirmation email.  If you don’t, review the troubleshooting steps from the [Create and Activate an AWS Account support page](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)

## 6. Secure Your AWS Account Root User

It’s strongly recommended and an AWS security best practice to enable multi-factor authentication (MFA) to the AWS account root user and to avoid using the root user, even for administrative tasks, from this point forward.

See [Enable MFA on the AWS Account Root User](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html#id_root-user_manage_mfa) for instructions.

{{% notice warning %}}
**Do not create administrative access keys for the root user:** Under no circumstances create programmatic access keys for your AWS account root user and admininistrative bootstrap users.
{{% /notice %}}

## 7. Set Alternate Contacts

Using the root user, set the Alternate Contacts for your account so that notifications of billing, operations, and security events are routed to the proper teams.  As a best practice, you can use email distribution lists so that notifications are set to multiple people in the same team.

Access [Account  Settings](https://console.aws.amazon.com/billing/home?#/account) in the AWS Management Console to set the Alternate Contacts.

## 8. Create an IAM user for Administrative Bootstrap Purposes

{{% notice note %}}
**Review Note: Is creating an admin bootstrap IAM user necessary?:** Functionally, is this user necessary? From a security best practices perspective is it necessary? Since this overall guide gets the foundation team members to start using their human user logins via AWS SSO as soon as feasible, this type of IAM admin user isn't currently used for anything other than working with AWS Control Tower to create the initial landing zone. AWS Control Tower [recommends that an IAM user](https://docs.aws.amazon.com/controltower/latest/userguide/setting-up.html) be established and used, but it doesn't state that it's an absolute requirement for the landing zone to be established.
{{% /notice %}}

Although you will be provisioning cloud administrator and builder user accounts via the AWS Single Sign-on (SSO) service later in this guide, it is required that you first create an administrative bootstrap user account via the AWS Identity and Access Management (IAM) service and switch to that user to set up the next parts of your initial foundation.

This administrative user should be only used to complete your initial foundation setup and act as a “break glass” user in case access via AWS SSO user accounts encounters an issue.

### Recommendations for Administrative Bootstrap User

* Since this account will only be used for break glass purposes after your foundation has been established, you don’t need to associate the user with a human user. Instead, you can use a name such as “Administrator”.
* Enable “AWS Management Console access” only for this user. “Programmatic access” should not be necessary for this user.

### Create the Administrative Bootstrap User

While logged in as the root user, follow the instructions in [Create an IAM user](https://docs.aws.amazon.com/controltower/latest/userguide/setting-up.html#setting-up-iam) to create this administrative user.

Once the user has been created, sign into the AWS Management Console as the user and enable MFA to help secure the account. See [Enable a Virtual MFA Device fo an IAM User](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa_enable_virtual.html#enable-virt-mfa-for-iam-user).