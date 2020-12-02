---
title: 'Set Up Test and Production Access'
menuTitle: '3. Set Up Test and Prod Access'
disableToc: true
weight: 30
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this step your Security and Cloud Administrators will define and provision policies to control the extent of access workload administrators have in your test and production workload AWS accounts.

Depending on the extent of your workload administrator policy needs, this step can take 30 minutes to several hours to complete.

{{< toc >}}

## 1. Define IAM policies for your workload administrators

You'll first need to define a set of IAM policies that can form the basis of an AWS SSO permission set that can be used to grant your workload administrators sufficient access to get their work done in their test and production environments.

Since the permissions provided by these policies are largely dependent on the type of workload and the supporting AWS resources, this guide does not provide you with an example set of policies.

See [Access management for AWS resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/access.html) for an introduction to managing access via IAM.

AWS provides predefined, AWS managed policies for common sets of permissions associated with many of the AWS services. You can browse the AWS managed policies by accessing the IAM service in the AWS management console and selecting **`Policies`**.

Depending on the AWS services your initial workloads use, you might be able to reuse some of the AWS managed policies combined with custom policies that you create to suit your particular needs.

## 2. Create workload administrator permission set in AWS SSO

Once you've identified a set of policies that are suitable for your workload administrators, you'll need to create a permission set in AWS SSO so that you can assign the permissions to the test and production accounts and grant the appropriate team members access to those accounts using those permissions.

### Log in as a cloud administrator

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the AWS **`management`** account.
3. Navigate to **AWS SSO** from the Services menu.

### Create Permission Set in AWS SSO

1. Access **`AWS accounts`** in AWS SSO.
2. Select **`Permission sets`**.
3. Select **`Create permission set`**.
4. Select **`Create a custom permission set`**.
5. Enter a **`Name`**. For example, **`example-infra-workload-admin`**. Replace **`example`** with your organization identifier.
6. Enter a **`Description`**. For example, **`Day-to-day permissions used workload administrators in their test and prod AWS accounts`**.
7. Set the **`Session duration`** to the desired value.
8. Depending on whether you're starting with the use of AWS managed policies and/or using a policy that you've defined:
  * Select **`Attach managed policies`** and select the AWS managed policies of interest.
  * Select **`Create a custom permissions policy`** and paste the content of your custom policy.
9. Select **`Next: Tags`**
10. Select **`Next: Review`**
11. Select **`Create`**

Later, when you onboard the people who are playing the role of workload administrators to the new workload AWS accounts, you'll reference this permission set.

## 3. Iterate on the workload administrator policy

In the next section, after you've created the initial test and production AWS accounts, you should test the workload administrator permission set and supporting policies. You should adjust the policies based on the results of your testing and be prepared to evolve the policies over time.