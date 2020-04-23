---
title: 'Set Up Team Development Environment Access Controls'
menuTitle: '6. Set Up Team Development Access Controls'
disableToc: true
weight: 60
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this step your Security and Cloud Administrators will provision resources to control the access to team development AWS accounts.

This step should take about 20 minutes to complete.

{{< toc >}}

## 1. Apply Service Control Policies (SCPs) to `development` OU

Using AWS Organizations, create several Service Control Policies (SCPs) that will be specific for the `development` OU.  When applied to the `development` OU, these SCPs will disallow any user including builder team members and foundation team members from creating and modifying foundation VPC networking resources in team development AWS accounts.

{{% notice tip %}}
**Service Control Policies (SCPs):** If you'd like to learn more about SCPs, see [Managing AWS Organizations policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies.html).
{{% /notice %}}

{{% notice tip %}}
**Review the sample team development access controls:** See [Controlling Builder Team Access]({{< relref "02-controlling-builder-team-access.md" >}}) for a detailed explanation of the requirements and sample implementation of how you can provide freedom to your builder teams in their team development AWS accounts, but inhibit them from adversely impacting the security of your overall AWS environment.
{{% /notice %}}

### Create the SCPs

Download the sample team development environment oriented SCPs to your desktop:
* [`acme-base-team-dev-scp-vpc-core.json`](/code-samples/02-scps/acme-base-team-dev-scp-vpc-core.json)
* [`acme-base-team-dev-scp-vpc-boundaries.json`](/code-samples/02-scps/acme-base-team-dev-scp-vpc-boundaries.json)

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the AWS **`master`** account.
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`AWS Organizations`**.
6. Select **`Policies`**.
7. Select **`Create policy`**.
8. Follow the prompts to create a new SCP named **`acme-base-team-dev-scp-vpc-core`** based on copying the content of the policy file you downloaded.
9. Repeat steps 6-8 in order to create a new SCP named **`acme-base-team-dev-scp-vpc-boundaries`**

### Apply the SCPs to the `development` OU

1. Navigate to **`AWS Organizations`**.
2. Select **`Organize accounts`**.
3. In the Organization tree on the left, select the **`development`** OU.
4. On the right side of the console, select **`Service control policies`**.
5. On the right side of the console, select the **`Attach`** link next to the SCP **`acme-base-team-dev-scp-vpc-foundations`**
6. Repeat steps 3-5 in order to attach the SCP **`acme-base-team-dev-scp-vpc-boundaries`**

## 2. Distribute Permissions Boundary to Development OU

In this step you'll use AWS CloudFormation StackSets to distribute an IAM permissions boundary policy to the "development" OU that you just created.  This boundary policy will help ensure that builder teams using team development AWS accounts can't modify your foundation cloud resources.

In a later section, when you create several team development AWS accounts, you will associate the AWS accounts with the "development" OU. Any AWS account that is added to that OU will automatically be configured with the IAM permissions boundary policy resource.  Similarly, when an AWS account is removed from the OU, the IAM permissions boundary policy resource will be automatically removed from the AWS account.

### Enable Trusted Access in AWS Organizations

First, enable the AWS CloudFormation service to automatically configure permissions required to use the CloudFormation StackSets feature to deploy stacks to AWS accounts in your AWS organization.

1. Navigate to **`AWS CloudFormation`**.
2. Select **`StackSets`**.
3. Select **`Enable trusted access`**.

{{% notice info %}}
**This is a one time operation:** If you'd like more background, see [Enabling Trusted Access with AWS Organizations](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-orgs-enable-trusted-access.html).
{{% /notice %}}

### Download AWS CloudFormation Template

Next, download the sample AWS CloudFormation template [`acme-base-team-dev-boundary.yml`](/code-samples/01-iam-policies/acme-base-team-dev-boundary.yml) to your desktop.

### Deploy Permissions Boundary as a StackSet

Create a StackSet to deploy the permissions boundary policy to all AWS accounts associated with the "development" OU. 

1. Select **`Create StackSet`**.
2. Select **`Upload a template file`**.
3. Select **`Choose file`** to select the downloaded template file from your desktop.
4. Select **`Next`**.
5. Enter a **`StackSet name`**. For example, **`acme-base-team-dev-boundary`**. 

It's useful to prefix your custom cloud resources that live in a larger name space with your organization identifier and a qualifier such as **`base`** to represent foundation resources. The important consideration is to be consistent with naming of foundation cloud resources so that you can apply IAM policies that will inhibit unauthorized modification of those resources.

6. In **`Parameters`**:

|Parameter|Guidance|
|---------|--------|
|**`pOrg`**|Replace **`acme`** with your organization identifier or stock ticker if that applies. This value is used as a prefix in the name of IAM managed policy that is created by the template.|

Leave the other parameters at their default settings.

7. Select **`Next`**.
8. Leave the **`Permissions`** set to **`Service managed permissions`**.
9. Select **`Next`**.
10. In **`Deployment targets`**, select **`Deploy to organizational units (OUs)`**.
11. Enter the OU ID of the "development" OU that you created in the previous step.
12. In **`Specify regions`**, select your home AWS region.
13. Select **`Next`**.
14. Scrolls to the bottom and mark the checkbox to acknowledge that IAM resources will be created.
15. Select **`Submit`**.

Since you have not yet created the team development AWS accounts, this CloudFormation StackSet won't create CloudFormation stacks in the team development AWS accounts until those AWS accounts are created in a subsequent section.

Proceed to the next step.

## 3. Create Team Development Permission Set in AWS SSO

Next, you'll create a custom permission set in AWS SSO to represent the initial iteration of an AWS IAM policy under which builder team members will work in their team development AWS accounts.

### Download and Customize Sample IAM Policy

1. Download the sample policy [`acme-base-team-dev-saml.json`](/code-samples/01-iam-policies/acme-base-team-dev-saml.json) to your desktop.
2. Open the file and replace all occurrences of **`acme`** with a reference to your own organization's identifier.

{{% notice tip %}}
**Infrastructure as Code (IaC) Opportunity:** Since you've just modified "code" that represents an important security policy for your AWS environment, it's a best practice to manage that source code file in a version control system such as a Git repository and control who can modify this file moving forward. If your organization is not already using Git-based version control, see the [Development Fast Follow Capabilities]({{< relref "02-dev-fast-follow" >}}) for assistance on how to get started using Git-based version control.
{{% /notice %}}

### Create Permission Set in AWS SSO

1. Access **`AWS accounts`** in AWS SSO.
2. Select **`Permission sets`**.
3. Select **`Create permission set`**.
4. Select **`Create a custom permission set`**.
5. Enter a **`Name`**. For example **`acme-base-team-dev`**. 
6. Enter a **`Description`**. For example, **`Day-to-day permission used by builders in their team development AWS accounts.`**.
7. Set the **`Session duration`** to the desired value.
8. Select the checkbox **`Create a custom permissions policy`**.
9. Open the sample policy file that you just customized in a text editor, copy, and paste the content.
10. Select **`Create`**.

Later, when you onboard the builder teams to their team development AWS accounts, you'll reference this permission set.