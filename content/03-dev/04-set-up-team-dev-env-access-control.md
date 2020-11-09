---
title: 'Set Up Team Development Environment Access Controls'
menuTitle: '4. Set Up Team Dev Access'
disableToc: true
weight: 40
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this step your Security and Cloud Administrators will provision resources to control the access to team development AWS accounts.

This step should take about 10 minutes to complete.

## Create Team Development Permission Set in AWS SSO

Next, you'll create a custom permission set in AWS SSO to represent the initial iteration of an AWS IAM policy under which builder team members will work in their team development AWS accounts.

### Download and Customize Sample IAM Policy

1. Download the sample policy [`example-infra-team-dev-saml.json`](/code-samples/iam-policies/example-infra-team-dev-saml.json) to your desktop.
2. Open the file and replace all occurrences of **`example`** with a reference to your own organization's identifier.

### Create Permission Set in AWS SSO

1. Access **`AWS accounts`** in AWS SSO.
2. Select **`Permission sets`**.
3. Select **`Create permission set`**.
4. Select **`Create a custom permission set`**.
5. Enter a **`Name`**. For example **`example-infra-team-dev`**. 
6. Enter a **`Description`**. For example, **`Day-to-day permission used by builders in their team development AWS accounts.`**.
7. Set the **`Session duration`** to the desired value.
8. Select the checkbox **`Create a custom permissions policy`**.  Select **`Next:Details`**.
9. Open the sample policy file that you just customized in a text editor, copy, and paste the content.

{{% notice warning %}}
**Replace `example` with your own identifier:** Before you select **`Create`**, in the permissions policy, ensure that you replace all occurrences of **`example`** with your own organization's identifier.  Otherwise, the permission set will not work as expected.
{{% /notice %}}

10. Select **`Create`**.

Later, when you onboard the builder teams to their team development AWS accounts, you'll reference this permission set.