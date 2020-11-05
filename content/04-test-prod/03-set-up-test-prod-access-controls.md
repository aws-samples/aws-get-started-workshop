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

{{% notice note %}}
Review Note: This section is an early draft and undergoing reviewing and editing.
{{% /notice %}}

In this step your Security and Cloud Administrators will provision resources to control the extent of access workload administrators have in your test and production workload AWS accounts.

This step should take about 10 minutes to complete.

## 1. Review and adjust example policy for workload administrators

Depending on your requirements for controlling who can make changes to your production environments, you will likely need to modify the sample workload administrator access permissions applied in this section.

## 2. Create workload administrator permission set in AWS SSO

Next, you'll create a custom permission set in AWS SSO to represent the initial iteration of an AWS IAM policy under which workload administrators will work in the workload specific AWS accounts.

### Download and Customize Sample IAM Policy

{{% notice note %}}
To Do: We need to move away from using the team development example policy and provide an example that is more tailored toward the role of a workload administrator.
{{% /notice %}}

{{% notice note %}}
To Do: Deliver the example policy and permission set as a CloudFormation template.
{{% /notice %}}

1. Download the sample policy [`example-infra-team-dev-saml.json`](/code-samples/iam-policies/example-infra-team-dev-saml.json) to your desktop.
2. Open the file and replace all occurrences of **`example`** with a reference to your own organization's identifier.

### Create Permission Set in AWS SSO

1. Access **`AWS accounts`** in AWS SSO.
2. Select **`Permission sets`**.
3. Select **`Create permission set`**.
4. Select **`Create a custom permission set`**.
5. Enter a **`Name`**. For example **`example-workload-admin-team-<workload_id>`**.
6. Enter a **`Description`**. For example, **`Day-to-day permission used by admins in their workload test and prod AWS accounts.`**.
7. Set the **`Session duration`** to the desired value.
8. Select the checkbox **`Create a custom permissions policy`**.
9. Open the sample policy file that you just customized in a text editor, copy, and paste the content.

{{% notice warning %}}
**Replace `example` with your own identifier:** Before you select **`Create`**, in the permissions policy, ensure that you replace all occurrences of **`example`** with your own organization's identifier.  Otherwise, the permission set will not work as expected.
{{% /notice %}}

10. Select **`Create`**.

Later, when you onboard the people who are playing the role of workload administrators to the new workload AWS accounts, you'll reference this permission set.